/// Один подход, зафиксированный в завершённой тренировке (для истории/экспорта).
class CompletedWorkoutSet {
  final double weight;
  final int reps;
  final double? rpe;
  final bool toFailure;

  const CompletedWorkoutSet({
    required this.weight,
    required this.reps,
    this.rpe,
    this.toFailure = false,
  });

  factory CompletedWorkoutSet.fromMap(Map<String, Object?> map) {
    return CompletedWorkoutSet(
      weight: (map['weight'] as num).toDouble(),
      reps: map['reps'] as int,
      rpe: (map['rpe'] as num?)?.toDouble(),
      toFailure: (map['to_failure'] as int) == 1,
    );
  }
}

/// Упражнение внутри завершённой тренировки со своими подходами.
class CompletedExercise {
  final String exerciseName;
  final String muscleGroup;
  final List<CompletedWorkoutSet> sets;

  const CompletedExercise({
    required this.exerciseName,
    required this.muscleGroup,
    required this.sets,
  });
}

/// Завершённая тренировка. In-memory история — живёт только в рамках
/// текущей сессии приложения, без БД.
class CompletedWorkout {
  final DateTime date;
  final String name;
  final int durationMinutes;
  final double volumeKg;
  final int prCount;
  final List<CompletedExercise> exercises;

  const CompletedWorkout({
    required this.date,
    required this.name,
    required this.durationMinutes,
    required this.volumeKg,
    this.prCount = 0,
    required this.exercises,
  });
}
