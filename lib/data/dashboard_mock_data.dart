/// Заглушки данных для дашборда.
/// Позже будут заменены выборками из [DatabaseHelper].
class TodayWorkoutPreview {
  final String name;
  final List<String> muscleGroups;
  final int exerciseCount;
  final int estimatedMinutes;

  const TodayWorkoutPreview({
    required this.name,
    required this.muscleGroups,
    required this.exerciseCount,
    required this.estimatedMinutes,
  });
}

class LastWorkoutSummary {
  final String name;
  final String whenLabel;
  final int durationMinutes;
  final double volumeKg;
  final int prCount;

  const LastWorkoutSummary({
    required this.name,
    required this.whenLabel,
    required this.durationMinutes,
    required this.volumeKg,
    required this.prCount,
  });
}

class WeeklyProgressStat {
  final List<String> dayLabels;
  final List<bool> completedDays;
  final int workoutsDone;
  final int workoutsGoal;

  const WeeklyProgressStat({
    required this.dayLabels,
    required this.completedDays,
    required this.workoutsDone,
    required this.workoutsGoal,
  });

  double get progress => workoutsGoal == 0 ? 0 : workoutsDone / workoutsGoal;
}

class DashboardMockData {
  DashboardMockData._();

  static const todayWorkout = TodayWorkoutPreview(
    name: 'Push Day',
    muscleGroups: ['Chest', 'Shoulders', 'Triceps'],
    exerciseCount: 5,
    estimatedMinutes: 55,
  );

  static const lastWorkout = LastWorkoutSummary(
    name: 'Pull Day',
    whenLabel: 'Yesterday',
    durationMinutes: 62,
    volumeKg: 4820,
    prCount: 1,
  );

  static const weeklyProgress = WeeklyProgressStat(
    dayLabels: ['M', 'T', 'W', 'T', 'F', 'S', 'S'],
    completedDays: [true, true, false, true, false, false, false],
    workoutsDone: 3,
    workoutsGoal: 5,
  );
}
