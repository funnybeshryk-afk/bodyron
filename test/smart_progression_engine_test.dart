import 'package:bodyron/data/smart_progression_engine.dart';
import 'package:bodyron/models/completed_workout.dart';
import 'package:flutter_test/flutter_test.dart';

CompletedWorkout _workout(
  DateTime date, {
  required String exercise,
  required List<CompletedWorkoutSet> sets,
}) {
  return CompletedWorkout(
    date: date,
    name: 'Session',
    durationMinutes: 45,
    volumeKg: 0,
    exercises: [
      CompletedExercise(exerciseName: exercise, muscleGroup: 'Chest', sets: sets),
    ],
  );
}

void main() {
  const exercise = 'Bench Press';

  test('returns null when there is no history for the exercise', () {
    final result = SmartProgressionEngine.suggestNextTarget(
      exerciseName: exercise,
      history: const [],
    );
    expect(result, isNull);
  });

  test('ignores history for other exercises', () {
    final history = [
      _workout(
        DateTime(2026, 1, 1),
        exercise: 'Squat',
        sets: const [CompletedWorkoutSet(weight: 100, reps: 8)],
      ),
    ];
    final result = SmartProgressionEngine.suggestNextTarget(
      exerciseName: exercise,
      history: history,
    );
    expect(result, isNull);
  });

  test('top of range + to failure => weight increases and reps reset low', () {
    final history = [
      _workout(
        DateTime(2026, 1, 1),
        exercise: exercise,
        sets: const [
          CompletedWorkoutSet(weight: 60, reps: 8),
          CompletedWorkoutSet(weight: 60, reps: 12, toFailure: true),
        ],
      ),
    ];

    final result = SmartProgressionEngine.suggestNextTarget(
      exerciseName: exercise,
      history: history,
    )!;

    expect(result.weight, 62.5);
    expect(result.repsLow, 6);
    expect(result.repsHigh, 8);
    expect(result.isPlateauDetected, isFalse);
  });

  test('top of range but low RPE (not near failure) => mid-range double progression, no weight jump', () {
    final history = [
      _workout(
        DateTime(2026, 1, 1),
        exercise: exercise,
        sets: const [CompletedWorkoutSet(weight: 60, reps: 12, rpe: 7)],
      ),
    ];

    final result = SmartProgressionEngine.suggestNextTarget(
      exerciseName: exercise,
      history: history,
    )!;

    expect(result.weight, 60);
    expect(result.repsLow, 12);
    expect(result.repsHigh, 12);
  });

  test('below bottom of range => retry same weight and default range', () {
    final history = [
      _workout(
        DateTime(2026, 1, 1),
        exercise: exercise,
        sets: const [CompletedWorkoutSet(weight: 80, reps: 4)],
      ),
    ];

    final result = SmartProgressionEngine.suggestNextTarget(
      exerciseName: exercise,
      history: history,
    )!;

    expect(result.weight, 80);
    expect(result.repsLow, SmartProgressionEngine.defaultRepsLow);
    expect(result.repsHigh, SmartProgressionEngine.defaultRepsHigh);
  });

  test('mid-range result => same weight, low bumped by one rep (double progression)', () {
    final history = [
      _workout(
        DateTime(2026, 1, 1),
        exercise: exercise,
        sets: const [CompletedWorkoutSet(weight: 70, reps: 9)],
      ),
    ];

    final result = SmartProgressionEngine.suggestNextTarget(
      exerciseName: exercise,
      history: history,
    )!;

    expect(result.weight, 70);
    expect(result.repsLow, 10);
    expect(result.repsHigh, SmartProgressionEngine.defaultRepsHigh);
  });

  test('detects a plateau after 3 sessions in a row with no improvement', () {
    final history = [
      _workout(DateTime(2026, 1, 1), exercise: exercise, sets: const [CompletedWorkoutSet(weight: 80, reps: 10)]),
      _workout(DateTime(2026, 1, 8), exercise: exercise, sets: const [CompletedWorkoutSet(weight: 80, reps: 9)]),
      _workout(DateTime(2026, 1, 15), exercise: exercise, sets: const [CompletedWorkoutSet(weight: 80, reps: 8)]),
      _workout(DateTime(2026, 1, 22), exercise: exercise, sets: const [CompletedWorkoutSet(weight: 80, reps: 8)]),
    ];

    final result = SmartProgressionEngine.suggestNextTarget(
      exerciseName: exercise,
      history: history,
    )!;

    expect(result.isPlateauDetected, isTrue);
  });

  test('no plateau when weight or reps improved along the way', () {
    final history = [
      _workout(DateTime(2026, 1, 1), exercise: exercise, sets: const [CompletedWorkoutSet(weight: 80, reps: 8)]),
      _workout(DateTime(2026, 1, 8), exercise: exercise, sets: const [CompletedWorkoutSet(weight: 80, reps: 9)]),
      _workout(DateTime(2026, 1, 15), exercise: exercise, sets: const [CompletedWorkoutSet(weight: 80, reps: 9)]),
      _workout(DateTime(2026, 1, 22), exercise: exercise, sets: const [CompletedWorkoutSet(weight: 80, reps: 9)]),
    ];

    final result = SmartProgressionEngine.suggestNextTarget(
      exerciseName: exercise,
      history: history,
    )!;

    expect(result.isPlateauDetected, isFalse);
  });

  test('ignores empty/zero sets when picking the top set', () {
    final history = [
      _workout(
        DateTime(2026, 1, 1),
        exercise: exercise,
        sets: const [
          CompletedWorkoutSet(weight: 0, reps: 0),
          CompletedWorkoutSet(weight: 65, reps: 10),
        ],
      ),
    ];

    final result = SmartProgressionEngine.suggestNextTarget(
      exerciseName: exercise,
      history: history,
    )!;

    expect(result.weight, 65);
    expect(result.repsLow, 11);
  });
}
