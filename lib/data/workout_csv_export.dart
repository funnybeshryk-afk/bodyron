import '../models/completed_workout.dart';

/// Строит CSV из истории завершённых тренировок:
/// дата, тренировка, упражнение, подход, вес, повторения, интенсивность.
class WorkoutCsvExporter {
  WorkoutCsvExporter._();

  static String export(List<CompletedWorkout> history) {
    final buffer = StringBuffer();
    buffer.writeln('Date,Workout,Exercise,Set,Weight (kg),Reps,Intensity');

    for (final workout in history) {
      final date = _formatDate(workout.date);

      for (final exercise in workout.exercises) {
        for (var i = 0; i < exercise.sets.length; i++) {
          final set = exercise.sets[i];
          final intensity = set.toFailure
              ? 'To Failure'
              : (set.rpe != null ? 'RPE ${_formatDecimal(set.rpe!)}' : '');

          buffer.writeln(
            [
              date,
              workout.name,
              exercise.exerciseName,
              '${i + 1}',
              _formatDecimal(set.weight),
              '${set.reps}',
              intensity,
            ].map(_csvField).join(','),
          );
        }
      }
    }

    return buffer.toString();
  }

  static String _csvField(String value) {
    if (value.contains(',') || value.contains('"') || value.contains('\n')) {
      return '"${value.replaceAll('"', '""')}"';
    }
    return value;
  }

  static String _formatDate(DateTime date) {
    String two(int v) => v.toString().padLeft(2, '0');
    return '${date.year}-${two(date.month)}-${two(date.day)} ${two(date.hour)}:${two(date.minute)}';
  }

  static String _formatDecimal(double value) =>
      value % 1 == 0 ? value.toStringAsFixed(0) : value.toStringAsFixed(2);
}
