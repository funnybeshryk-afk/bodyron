import 'exercise_definition.dart';
import 'workout_set_entry.dart';

/// Упражнение, добавленное в текущую (активную) тренировку, со своим
/// списком подходов.
class ActiveExercise {
  final ExerciseDefinition exercise;
  final List<WorkoutSetEntry> sets;

  ActiveExercise({
    required this.exercise,
    List<WorkoutSetEntry>? sets,
  }) : sets = sets ?? [];
}
