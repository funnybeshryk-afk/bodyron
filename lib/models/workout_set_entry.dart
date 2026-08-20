/// Один подход упражнения в активной тренировке.
/// Интенсивность фиксируется либо через [rpe] (1-10), либо через
/// [toFailure] ("до отказа") — одновременно оба не используются.
class WorkoutSetEntry {
  final int id;
  final double weight;
  final int reps;
  final double? rpe;
  final bool toFailure;
  final bool completed;

  const WorkoutSetEntry({
    required this.id,
    this.weight = 0,
    this.reps = 0,
    this.rpe,
    this.toFailure = false,
    this.completed = false,
  });

  bool get hasIntensity => rpe != null || toFailure;

  WorkoutSetEntry copyWith({
    double? weight,
    int? reps,
    bool? completed,
  }) {
    return WorkoutSetEntry(
      id: id,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      rpe: rpe,
      toFailure: toFailure,
      completed: completed ?? this.completed,
    );
  }

  WorkoutSetEntry withRpe(double value) => WorkoutSetEntry(
    id: id,
    weight: weight,
    reps: reps,
    rpe: value,
    toFailure: false,
    completed: completed,
  );

  WorkoutSetEntry withToFailure() => WorkoutSetEntry(
    id: id,
    weight: weight,
    reps: reps,
    rpe: null,
    toFailure: true,
    completed: completed,
  );

  WorkoutSetEntry withoutIntensity() => WorkoutSetEntry(
    id: id,
    weight: weight,
    reps: reps,
    rpe: null,
    toFailure: false,
    completed: completed,
  );
}
