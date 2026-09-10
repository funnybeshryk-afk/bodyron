import 'completed_workout.dart';

/// Итог по одному упражнению внутри только что завершённой тренировки —
/// для экрана "Тренировка завершена" (см. [WorkoutFinishSummary]).
class ExerciseFinishResult {
  final String exerciseName;
  final String muscleGroup;

  /// Лучший (по оценочному 1ПМ) выполненный подход этого упражнения за эту
  /// тренировку.
  final CompletedWorkoutSet bestSet;

  /// true, если [bestSet] — новый личный рекорд относительно всей
  /// предыдущей истории.
  final bool isPr;

  /// Разница в кг между [bestSet] и лучшим подходом этого же упражнения в
  /// предыдущей истории. `null`, если упражнение выполняется впервые.
  final double? weightDeltaKg;

  const ExerciseFinishResult({
    required this.exerciseName,
    required this.muscleGroup,
    required this.bestSet,
    required this.isPr,
    this.weightDeltaKg,
  });
}

/// Возвращается [WorkoutSessionStore.finishWorkout] — всё, что нужно экрану
/// завершения тренировки (см. WorkoutCompletionScreen), не пересчитывая
/// историю заново.
class WorkoutFinishSummary {
  final CompletedWorkout workout;
  final List<ExerciseFinishResult> exerciseResults;

  const WorkoutFinishSummary({
    required this.workout,
    required this.exerciseResults,
  });

  bool get hasNewPr => exerciseResults.any((e) => e.isPr);

  /// Упражнение с наибольшим ростом рабочего веса относительно прошлой
  /// тренировки — источник мотивационной строки ("Ты стал сильнее...").
  ExerciseFinishResult? get biggestImprovement {
    ExerciseFinishResult? best;
    for (final result in exerciseResults) {
      final delta = result.weightDeltaKg;
      if (delta == null || delta <= 0) continue;
      if (best == null || delta > (best.weightDeltaKg ?? 0)) best = result;
    }
    return best;
  }
}
