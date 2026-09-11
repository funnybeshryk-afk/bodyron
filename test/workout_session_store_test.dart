import 'package:bodyron/data/workout_session_store.dart';
import 'package:bodyron/models/completed_workout.dart';
import 'package:flutter_test/flutter_test.dart';

/// Регрессионный тест на "Прогресс за неделю" (см. Phase 1 follow-up #2
/// ТЗ) — этот блок раньше брал completedDays из статического мока
/// независимо от реальной истории. [WorkoutSessionStore.history] — плейн
/// список в памяти, БД тут не нужна.
CompletedWorkout _workoutOn(DateTime date) {
  return CompletedWorkout(
    date: date,
    name: 'Session',
    durationMinutes: 45,
    volumeKg: 100,
    exercises: const [],
  );
}

void main() {
  test('completedDaysInCurrentWeek is all false with no history', () {
    final store = WorkoutSessionStore();
    expect(store.completedDaysInCurrentWeek(), List.filled(7, false));
  });

  test('marks only the weekday a workout happened on, within this week', () {
    final store = WorkoutSessionStore();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    store.history.add(_workoutOn(today));

    final result = store.completedDaysInCurrentWeek();
    expect(result[today.weekday - 1], isTrue);
    expect(result.where((d) => d).length, 1);
  });

  test('does not count a workout from last week', () {
    final store = WorkoutSessionStore();
    final now = DateTime.now();
    final lastWeek = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 8));

    store.history.add(_workoutOn(lastWeek));

    expect(store.completedDaysInCurrentWeek(), List.filled(7, false));
  });

  test('two workouts on the same day still count as one completed day', () {
    final store = WorkoutSessionStore();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    store.history.add(_workoutOn(today));
    store.history.add(_workoutOn(today.add(const Duration(hours: 3))));

    final result = store.completedDaysInCurrentWeek();
    expect(result.where((d) => d).length, 1);
  });
}
