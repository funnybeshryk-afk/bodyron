import '../models/exercise_definition.dart';

/// Встроенная библиотека популярных упражнений по группам мышц.
/// Пользовательские упражнения хранятся отдельно в [WorkoutSessionStore]
/// и объединяются с этим списком при отображении.
class ExerciseLibrary {
  ExerciseLibrary._();

  static const List<String> muscleGroups = [
    'Chest',
    'Back',
    'Legs',
    'Shoulders',
    'Arms',
    'Abs',
  ];

  static const List<ExerciseDefinition> builtIn = [
    ExerciseDefinition(name: 'Bench Press', muscleGroup: 'Chest'),
    ExerciseDefinition(name: 'Incline Bench Press', muscleGroup: 'Chest'),
    ExerciseDefinition(name: 'Dumbbell Fly', muscleGroup: 'Chest'),

    ExerciseDefinition(name: 'Deadlift', muscleGroup: 'Back'),
    ExerciseDefinition(name: 'Pull Up', muscleGroup: 'Back'),
    ExerciseDefinition(name: 'Barbell Row', muscleGroup: 'Back'),
    ExerciseDefinition(name: 'Lat Pulldown', muscleGroup: 'Back'),

    ExerciseDefinition(name: 'Squat', muscleGroup: 'Legs'),
    ExerciseDefinition(name: 'Leg Press', muscleGroup: 'Legs'),
    ExerciseDefinition(name: 'Romanian Deadlift', muscleGroup: 'Legs'),
    ExerciseDefinition(name: 'Walking Lunge', muscleGroup: 'Legs'),

    ExerciseDefinition(name: 'Overhead Press', muscleGroup: 'Shoulders'),
    ExerciseDefinition(name: 'Lateral Raise', muscleGroup: 'Shoulders'),
    ExerciseDefinition(name: 'Face Pull', muscleGroup: 'Shoulders'),

    ExerciseDefinition(name: 'Barbell Curl', muscleGroup: 'Arms'),
    ExerciseDefinition(name: 'Hammer Curl', muscleGroup: 'Arms'),
    ExerciseDefinition(name: 'Triceps Pushdown', muscleGroup: 'Arms'),

    ExerciseDefinition(name: 'Plank', muscleGroup: 'Abs'),
    ExerciseDefinition(name: 'Hanging Leg Raise', muscleGroup: 'Abs'),
    ExerciseDefinition(name: 'Cable Crunch', muscleGroup: 'Abs'),
  ];
}
