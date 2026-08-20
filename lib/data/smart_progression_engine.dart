import '../models/completed_workout.dart';
import 'plate_calculator.dart';

/// Подсказка по следующей попытке для упражнения: целевой вес и диапазон
/// повторений, плюс флаг плато.
class SuggestedTarget {
  final double weight;
  final int repsLow;
  final int repsHigh;
  final bool isPlateauDetected;

  const SuggestedTarget({
    required this.weight,
    required this.repsLow,
    required this.repsHigh,
    required this.isPlateauDetected,
  });
}

/// Rule-based (без ML/статистики) движок подсказок по прогрессии: double
/// progression — сначала растим повторения в целевом диапазоне, затем вес.
/// Чистая функция от истории — не знает о БД/сторах/виджетах, поэтому легко
/// тестируется синтетическими данными.
class SmartProgressionEngine {
  SmartProgressionEngine._();

  static const int defaultRepsLow = 6;
  static const int defaultRepsHigh = 12;
  static const double defaultWeightStepKg = 2.5;

  /// Кол-во подряд идущих тренировок (без улучшения топ-сета), после
  /// которого считаем прогресс встал на плато.
  static const int _plateauStreak = 3;

  /// `null`, если по упражнению нет ни одной завершённой тренировки в
  /// истории — тогда UI просто не показывает карточку.
  static SuggestedTarget? suggestNextTarget({
    required String exerciseName,
    required List<CompletedWorkout> history,
  }) {
    final sessions = _topSetsForExercise(exerciseName, history);
    if (sessions.isEmpty) return null;

    final last = sessions.last.set;
    final plateau = _detectPlateau(sessions);
    final pushedHard = last.toFailure || (last.rpe != null && last.rpe! >= 9);

    // Верх диапазона с высокой интенсивностью — пора добавить вес и
    // вернуться к низу диапазона повторений.
    if (last.reps >= defaultRepsHigh && pushedHard) {
      return SuggestedTarget(
        weight: _roundToAchievableWeight(last.weight + defaultWeightStepKg),
        repsLow: defaultRepsLow,
        repsHigh: 8,
        isPlateauDetected: plateau,
      );
    }

    // Не дотянули до низа диапазона — пробуем тот же вес с тем же
    // (базовым) целевым диапазоном ещё раз.
    if (last.reps < defaultRepsLow) {
      return SuggestedTarget(
        weight: last.weight,
        repsLow: defaultRepsLow,
        repsHigh: defaultRepsHigh,
        isPlateauDetected: plateau,
      );
    }

    // Середина диапазона — double progression: тот же вес, планка снизу
    // поднимается на 1 повторение от достигнутого результата.
    final nextLow = (last.reps + 1).clamp(defaultRepsLow, defaultRepsHigh);
    return SuggestedTarget(
      weight: last.weight,
      repsLow: nextLow,
      repsHigh: defaultRepsHigh,
      isPlateauDetected: plateau,
    );
  }

  static double _roundToAchievableWeight(double weight) {
    return PlateCalculator.calculate(targetWeight: weight).totalWeight;
  }

  /// Топ-сет (самый тяжёлый выполненный подход; при равенстве веса — с
  /// большим числом повторений) по каждой тренировке, где встречалось это
  /// упражнение, в хронологическом порядке.
  static List<_Session> _topSetsForExercise(
    String exerciseName,
    List<CompletedWorkout> history,
  ) {
    final sessions = <_Session>[];

    for (final workout in history) {
      for (final ex in workout.exercises) {
        if (ex.exerciseName.toLowerCase() != exerciseName.toLowerCase()) continue;

        CompletedWorkoutSet? top;
        for (final s in ex.sets) {
          if (s.weight <= 0 || s.reps <= 0) continue;
          if (top == null || s.weight > top.weight || (s.weight == top.weight && s.reps > top.reps)) {
            top = s;
          }
        }
        if (top != null) sessions.add(_Session(workout.date, top));
      }
    }

    sessions.sort((a, b) => a.date.compareTo(b.date));
    return sessions;
  }

  /// `true`, если последние [_plateauStreak] тренировок подряд топ-сет не
  /// улучшался (ни по весу, ни по повторениям) относительно предыдущей.
  static bool _detectPlateau(List<_Session> sessions) {
    if (sessions.length < _plateauStreak + 1) return false;

    final recent = sessions.sublist(sessions.length - (_plateauStreak + 1));
    for (var i = 1; i < recent.length; i++) {
      final prev = recent[i - 1].set;
      final curr = recent[i].set;
      final improved = curr.weight > prev.weight || curr.reps > prev.reps;
      if (improved) return false;
    }
    return true;
  }
}

class _Session {
  final DateTime date;
  final CompletedWorkoutSet set;

  const _Session(this.date, this.set);
}
