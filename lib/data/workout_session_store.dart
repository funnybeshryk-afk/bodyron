import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../database/database_helper.dart';
import '../models/active_exercise.dart';
import '../models/completed_workout.dart';
import '../models/exercise_definition.dart';
import '../models/personal_record.dart';
import '../models/workout_set_entry.dart';
import 'exercise_library.dart';
import 'rest_timer_notification_service.dart';

const String _restDurationSettingKey = 'rest_duration_seconds';

/// Хранит состояние активной тренировки, библиотеку пользовательских
/// упражнений и таймер отдыха. Живёт на уровне [MainScreen], поэтому не
/// сбрасывается при переключении вкладок. Завершённые тренировки и
/// пользовательские упражнения персистятся в SQLite через
/// [DatabaseHelper] — см. [loadFromDatabase].
class WorkoutSessionStore extends ChangeNotifier {
  final List<ActiveExercise> exercises = [];
  final List<ExerciseDefinition> _customExercises = [];

  DateTime? _startedAt;
  int _nextSetId = 1;

  /// История завершённых тренировок, от старых к новым. `history.last` —
  /// это последняя тренировка (используется на Dashboard).
  final List<CompletedWorkout> history = [];

  bool isLoaded = false;

  int restDurationSeconds = 90;
  int _restRemaining = 0;
  Timer? _restTimer;
  Timer? _completionFlashTimer;
  bool restJustCompleted = false;

  bool get isActive => exercises.isNotEmpty;

  Duration get elapsed =>
      _startedAt == null ? Duration.zero : DateTime.now().difference(_startedAt!);

  bool get isResting => _restTimer != null;
  int get restRemaining => _restRemaining;

  List<ExerciseDefinition> get customExercises => List.unmodifiable(_customExercises);

  Map<String, List<ExerciseDefinition>> get exercisesByMuscle {
    final map = <String, List<ExerciseDefinition>>{};
    for (final group in ExerciseLibrary.muscleGroups) {
      map[group] = [
        ...ExerciseLibrary.builtIn.where((e) => e.muscleGroup == group),
        ..._customExercises.where((e) => e.muscleGroup == group),
      ];
    }
    return map;
  }

  // ---------------------------------------------------------------------
  // Persistence
  // ---------------------------------------------------------------------

  /// Загружает историю, пользовательские упражнения и настройку таймера
  /// отдыха из БД. Вызывается один раз при старте приложения.
  Future<void> loadFromDatabase() async {
    final db = DatabaseHelper.instance;

    final loadedHistory = await db.getWorkoutHistory();
    final loadedCustomExercises = await db.getCustomExercises();
    final storedRestDuration = await db.getSetting(_restDurationSettingKey);

    history
      ..clear()
      ..addAll(loadedHistory);
    _customExercises
      ..clear()
      ..addAll(loadedCustomExercises);
    if (storedRestDuration != null) {
      restDurationSeconds = int.tryParse(storedRestDuration) ?? restDurationSeconds;
    }

    isLoaded = true;
    notifyListeners();
  }

  // ---------------------------------------------------------------------
  // Exercises
  // ---------------------------------------------------------------------

  void addExercise(ExerciseDefinition exercise) {
    _startedAt ??= DateTime.now();
    if (exercises.any((e) => e.exercise == exercise)) return;
    exercises.add(ActiveExercise(exercise: exercise));
    notifyListeners();
  }

  void removeExercise(ActiveExercise entry) {
    exercises.remove(entry);
    notifyListeners();
  }

  ExerciseDefinition addCustomExercise({
    required String name,
    required String muscleGroup,
  }) {
    final trimmed = name.trim();
    final definition = ExerciseDefinition(
      name: trimmed,
      muscleGroup: muscleGroup,
      isCustom: true,
    );

    final alreadyExists =
        _customExercises.contains(definition) || ExerciseLibrary.builtIn.contains(definition);

    if (!alreadyExists) {
      _customExercises.add(definition);
      DatabaseHelper.instance.insertCustomExercise(definition);
    }

    notifyListeners();
    return definition;
  }

  // ---------------------------------------------------------------------
  // Sets
  // ---------------------------------------------------------------------

  void addSet(ActiveExercise entry) {
    final previous = entry.sets.isNotEmpty ? entry.sets.last : null;
    entry.sets.add(
      WorkoutSetEntry(
        id: _nextSetId++,
        weight: previous?.weight ?? 0,
        reps: previous?.reps ?? 0,
        rpe: previous?.rpe,
        toFailure: previous?.toFailure ?? false,
      ),
    );
    notifyListeners();
  }

  void removeSet(ActiveExercise entry, WorkoutSetEntry set) {
    entry.sets.removeWhere((s) => s.id == set.id);
    notifyListeners();
  }

  void updateSetWeight(ActiveExercise entry, WorkoutSetEntry set, double weight) {
    _replaceSet(entry, set, set.copyWith(weight: weight < 0 ? 0 : weight));
  }

  void updateSetReps(ActiveExercise entry, WorkoutSetEntry set, int reps) {
    _replaceSet(entry, set, set.copyWith(reps: reps < 0 ? 0 : reps));
  }

  void setSetRpe(ActiveExercise entry, WorkoutSetEntry set, double rpe) {
    _replaceSet(entry, set, set.withRpe(rpe));
  }

  void setSetToFailure(ActiveExercise entry, WorkoutSetEntry set) {
    _replaceSet(entry, set, set.withToFailure());
  }

  void clearSetIntensity(ActiveExercise entry, WorkoutSetEntry set) {
    _replaceSet(entry, set, set.withoutIntensity());
  }

  void toggleSetCompleted(ActiveExercise entry, WorkoutSetEntry set) {
    final updated = set.copyWith(completed: !set.completed);
    _replaceSet(entry, set, updated);
    if (updated.completed) {
      startRestTimer();
    }
  }

  void _replaceSet(ActiveExercise entry, WorkoutSetEntry oldSet, WorkoutSetEntry newSet) {
    final index = entry.sets.indexWhere((s) => s.id == oldSet.id);
    if (index == -1) return;
    entry.sets[index] = newSet;
    notifyListeners();
  }

  // ---------------------------------------------------------------------
  // Rest timer
  // ---------------------------------------------------------------------

  void startRestTimer({int? seconds}) {
    _restTimer?.cancel();
    _completionFlashTimer?.cancel();
    restJustCompleted = false;
    _restRemaining = seconds ?? restDurationSeconds;

    // Дублируем таймер локальным OS-уведомлением на случай, если приложение
    // свернут/экран выключат до истечения отдыха.
    final notifications = RestTimerNotificationService.instance;
    notifications.ensurePermission().then((_) {
      notifications.scheduleRestComplete(_restRemaining);
    });

    _restTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      _restRemaining--;
      if (_restRemaining <= 0) {
        _finishRestTimer();
      } else {
        notifyListeners();
      }
    });

    notifyListeners();
  }

  void adjustRestTimer(int deltaSeconds) {
    if (!isResting) return;
    _restRemaining += deltaSeconds;
    if (_restRemaining <= 0) {
      _finishRestTimer();
    } else {
      RestTimerNotificationService.instance.scheduleRestComplete(_restRemaining);
      notifyListeners();
    }
  }

  void skipRestTimer() {
    _restTimer?.cancel();
    _restTimer = null;
    _restRemaining = 0;
    RestTimerNotificationService.instance.cancel();
    notifyListeners();
  }

  void _finishRestTimer() {
    _restTimer?.cancel();
    _restTimer = null;
    _restRemaining = 0;
    restJustCompleted = true;
    HapticFeedback.vibrate();

    // Android не всегда сразу замораживает Dart-изолят при сворачивании —
    // этот таймер мог досчитать до нуля в фоне. Отменяем запланированное
    // OS-уведомление только если приложение реально видно пользователю
    // (баннер это покрывает); иначе оставляем уведомление в силе, иначе
    // пользователь не узнает, что отдых закончился.
    final isForeground = WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;
    if (isForeground) {
      RestTimerNotificationService.instance.cancel();
    }
    notifyListeners();

    _completionFlashTimer?.cancel();
    _completionFlashTimer = Timer(const Duration(seconds: 3), () {
      restJustCompleted = false;
      notifyListeners();
    });
  }

  void setDefaultRestDuration(int seconds) {
    restDurationSeconds = seconds;
    DatabaseHelper.instance.setSetting(_restDurationSettingKey, seconds.toString());
    notifyListeners();
  }

  // ---------------------------------------------------------------------
  // Finish workout
  // ---------------------------------------------------------------------

  CompletedWorkout finishWorkout() {
    final durationMinutes = elapsed.inMinutes < 1 ? 1 : elapsed.inMinutes;

    double volume = 0;
    for (final ex in exercises) {
      for (final s in ex.sets) {
        if (s.completed) volume += s.weight * s.reps;
      }
    }

    // PR-и считаем ДО того, как эта тренировка попадёт в историю — иначе
    // она будет сравнивать себя саму с собой.
    var prCount = 0;
    for (final ex in exercises) {
      final sessionBest = _bestE1rmInActiveSets(ex.sets);
      if (sessionBest == null) continue;
      final priorBest = _bestE1rmForExerciseInHistory(ex.exercise.name);
      if (priorBest != null && sessionBest > priorBest) prCount++;
    }

    final muscleGroups = exercises.map((e) => e.exercise.muscleGroup).toSet();
    final name = exercises.isEmpty
        ? 'Workout'
        : (muscleGroups.length == 1 ? '${muscleGroups.first} Day' : 'Full Body Day');

    final completed = CompletedWorkout(
      date: DateTime.now(),
      name: name,
      durationMinutes: durationMinutes,
      volumeKg: volume,
      prCount: prCount,
      exercises: [
        for (final ex in exercises)
          CompletedExercise(
            exerciseName: ex.exercise.name,
            muscleGroup: ex.exercise.muscleGroup,
            sets: [
              for (final s in ex.sets)
                CompletedWorkoutSet(
                  weight: s.weight,
                  reps: s.reps,
                  rpe: s.rpe,
                  toFailure: s.toFailure,
                ),
            ],
          ),
      ],
    );

    history.add(completed);
    DatabaseHelper.instance.insertCompletedWorkout(completed);

    exercises.clear();
    _startedAt = null;
    skipRestTimer();
    notifyListeners();

    return completed;
  }

  /// Последний зафиксированный подход по этому упражнению из истории
  /// (самая недавняя тренировка, в которой оно встречается). `null`,
  /// если упражнение выполняется впервые.
  CompletedWorkoutSet? lastSetFor(String exerciseName) {
    for (var i = history.length - 1; i >= 0; i--) {
      final exercise = history[i].exercises
          .cast<CompletedExercise?>()
          .firstWhere(
            (e) => e!.exerciseName.toLowerCase() == exerciseName.toLowerCase(),
            orElse: () => null,
          );
      if (exercise == null || exercise.sets.isEmpty) continue;
      return exercise.sets.last;
    }
    return null;
  }

  // ---------------------------------------------------------------------
  // Analytics: personal records, weekly volume
  // ---------------------------------------------------------------------

  double _epley(double weight, int reps) => reps <= 1 ? weight : weight * (1 + reps / 30);

  double? _bestE1rmInActiveSets(List<WorkoutSetEntry> sets) {
    double? best;
    for (final s in sets) {
      if (!s.completed || s.weight <= 0 || s.reps <= 0) continue;
      final e1rm = _epley(s.weight, s.reps);
      if (best == null || e1rm > best) best = e1rm;
    }
    return best;
  }

  double? _bestE1rmForExerciseInHistory(String exerciseName) {
    double? best;
    for (final workout in history) {
      for (final ex in workout.exercises) {
        if (ex.exerciseName.toLowerCase() != exerciseName.toLowerCase()) continue;
        for (final s in ex.sets) {
          if (s.weight <= 0 || s.reps <= 0) continue;
          final e1rm = _epley(s.weight, s.reps);
          if (best == null || e1rm > best) best = e1rm;
        }
      }
    }
    return best;
  }

  /// Личные рекорды по упражнениям, встречавшимся минимум в двух разных
  /// тренировках истории — лучший подход (по оценочному 1ПМ) на каждое.
  List<PersonalRecord> get personalRecords {
    final setsByExercise = <String, List<(CompletedWorkoutSet, DateTime)>>{};
    final muscleByExercise = <String, String>{};
    final workoutCountByExercise = <String, int>{};

    for (final workout in history) {
      final seenInThisWorkout = <String>{};
      for (final ex in workout.exercises) {
        final key = ex.exerciseName;
        setsByExercise
            .putIfAbsent(key, () => [])
            .addAll(ex.sets.map((s) => (s, workout.date)));
        muscleByExercise[key] = ex.muscleGroup;
        if (seenInThisWorkout.add(key.toLowerCase())) {
          workoutCountByExercise[key] = (workoutCountByExercise[key] ?? 0) + 1;
        }
      }
    }

    final result = <PersonalRecord>[];
    setsByExercise.forEach((name, entries) {
      if ((workoutCountByExercise[name] ?? 0) < 2) return;

      CompletedWorkoutSet? bestSet;
      DateTime? bestDate;
      double? bestE1rm;
      for (final (s, date) in entries) {
        if (s.weight <= 0 || s.reps <= 0) continue;
        final e1rm = _epley(s.weight, s.reps);
        if (bestE1rm == null || e1rm > bestE1rm) {
          bestE1rm = e1rm;
          bestSet = s;
          bestDate = date;
        }
      }
      if (bestSet == null) return;

      result.add(
        PersonalRecord(
          exerciseName: name,
          muscleGroup: muscleByExercise[name] ?? '',
          weight: bestSet.weight,
          reps: bestSet.reps,
          date: bestDate!,
        ),
      );
    });

    result.sort((a, b) => b.estimated1Rm.compareTo(a.estimated1Rm));
    return result;
  }

  /// Названия упражнений, встречавшихся в истории хотя бы раз — для
  /// выбора упражнения в Strength Progress. Более недавно выполнявшиеся
  /// идут первыми.
  List<String> get exerciseNamesInHistory {
    final lastSeenAt = <String, DateTime>{};
    for (final workout in history) {
      for (final ex in workout.exercises) {
        final current = lastSeenAt[ex.exerciseName];
        if (current == null || workout.date.isAfter(current)) {
          lastSeenAt[ex.exerciseName] = workout.date;
        }
      }
    }
    final names = lastSeenAt.keys.toList()
      ..sort((a, b) => lastSeenAt[b]!.compareTo(lastSeenAt[a]!));
    return names;
  }

  /// Оценочный 1ПМ (формула Эпли) по лучшему подходу за тренировку для
  /// данного упражнения, от старых тренировок к новым.
  List<MapEntry<DateTime, double>> e1rmHistoryFor(String exerciseName) {
    final result = <MapEntry<DateTime, double>>[];
    for (final workout in history) {
      double? best;
      for (final ex in workout.exercises) {
        if (ex.exerciseName.toLowerCase() != exerciseName.toLowerCase()) continue;
        for (final s in ex.sets) {
          if (s.weight <= 0 || s.reps <= 0) continue;
          final e1rm = _epley(s.weight, s.reps);
          if (best == null || e1rm > best) best = e1rm;
        }
      }
      if (best != null) result.add(MapEntry(workout.date, best));
    }
    return result;
  }

  /// Тренировочный объём (вес × повторения по завершённым подходам),
  /// сгруппированный по началу недели (понедельник).
  Map<DateTime, double> get weeklyVolume {
    final result = <DateTime, double>{};
    for (final workout in history) {
      final weekStart = _startOfWeek(workout.date);
      result[weekStart] = (result[weekStart] ?? 0) + workout.volumeKg;
    }
    return result;
  }

  DateTime _startOfWeek(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    return day.subtract(Duration(days: day.weekday - 1));
  }

  @override
  void dispose() {
    _restTimer?.cancel();
    _completionFlashTimer?.cancel();
    super.dispose();
  }
}
