/// Одно целевое упражнение внутри дня автосгенерированной программы:
/// сколько подходов и в каком диапазоне повторений. [exerciseName] должен
/// совпадать с именем из [ExerciseLibrary.builtIn] — так
/// [WorkoutSessionStore.applyProgramDay] может найти нужное
/// [ExerciseDefinition] без создания нового.
class ProgramExercise {
  final String exerciseName;
  final int targetSets;
  final int repsLow;
  final int repsHigh;

  const ProgramExercise({
    required this.exerciseName,
    required this.targetSets,
    required this.repsLow,
    required this.repsHigh,
  });

  Map<String, Object?> toJson() => {
        'exerciseName': exerciseName,
        'targetSets': targetSets,
        'repsLow': repsLow,
        'repsHigh': repsHigh,
      };

  factory ProgramExercise.fromJson(Map<String, Object?> json) => ProgramExercise(
        exerciseName: json['exerciseName'] as String,
        targetSets: json['targetSets'] as int,
        repsLow: json['repsLow'] as int,
        repsHigh: json['repsHigh'] as int,
      );
}

/// Один день недели автосгенерированной программы. [dayKey] — канонический
/// английский ключ ('push', 'chest', 'upper', ...), локализуется тем же
/// паттерном, что и остальной статический контент приложения (см.
/// [WorkoutNameL10n] — [dayName] использует те же ключи, что и авто-названия
/// завершённых тренировок, например 'Push Day'/'Chest Day').
class TrainingProgramDay {
  /// 1 (Monday) .. 7 (Sunday), см. [DateTime.weekday].
  final int dayOfWeek;
  final bool isRestDay;

  /// Канонический английский ключ дня ('Push Day', 'Chest Day', ...) — пусто
  /// для дней отдыха.
  final String dayName;
  final List<String> muscleGroups;
  final List<ProgramExercise> exercises;

  const TrainingProgramDay({
    required this.dayOfWeek,
    required this.isRestDay,
    this.dayName = '',
    this.muscleGroups = const [],
    this.exercises = const [],
  });

  Map<String, Object?> toJson() => {
        'dayOfWeek': dayOfWeek,
        'isRestDay': isRestDay,
        'dayName': dayName,
        'muscleGroups': muscleGroups,
        'exercises': [for (final e in exercises) e.toJson()],
      };

  factory TrainingProgramDay.fromJson(Map<String, Object?> json) => TrainingProgramDay(
        dayOfWeek: json['dayOfWeek'] as int,
        isRestDay: json['isRestDay'] as bool,
        dayName: json['dayName'] as String? ?? '',
        muscleGroups: [for (final m in (json['muscleGroups'] as List? ?? const [])) m as String],
        exercises: [
          for (final e in (json['exercises'] as List? ?? const []))
            ProgramExercise.fromJson(e as Map<String, Object?>),
        ],
      );
}

/// Автосгенерированная (rule-based, без ML) программа тренировок — см.
/// [ProgramGenerator.generate]. Хранится целиком как один JSON-блок в
/// `app_settings` под ключом `active_program_json` (см.
/// [TrainingProgramStore]) — не требует изменений схемы БД.
class TrainingProgram {
  final String goal;
  final String level;
  final int frequency;

  /// Ровно 7 элементов, индекс 0 = Monday .. 6 = Sunday (см.
  /// [TrainingProgramDay.dayOfWeek]).
  final List<TrainingProgramDay> days;

  const TrainingProgram({
    required this.goal,
    required this.level,
    required this.frequency,
    required this.days,
  });

  TrainingProgramDay dayFor(int weekday) => days.firstWhere((d) => d.dayOfWeek == weekday);

  /// Следующий тренировочный (не отдых) день, начиная со дня после [from]
  /// и оборачиваясь по неделе. `null`, если в программе нет тренировочных
  /// дней (не должно происходить при frequency >= 1).
  TrainingProgramDay? nextTrainingDayAfter(int from) {
    for (var i = 1; i <= 7; i++) {
      final day = dayFor(((from - 1 + i) % 7) + 1);
      if (!day.isRestDay) return day;
    }
    return null;
  }

  Map<String, Object?> toJson() => {
        'goal': goal,
        'level': level,
        'frequency': frequency,
        'days': [for (final d in days) d.toJson()],
      };

  factory TrainingProgram.fromJson(Map<String, Object?> json) => TrainingProgram(
        goal: json['goal'] as String,
        level: json['level'] as String,
        frequency: json['frequency'] as int,
        days: [
          for (final d in (json['days'] as List))
            TrainingProgramDay.fromJson(d as Map<String, Object?>),
        ],
      );
}
