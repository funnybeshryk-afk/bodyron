import '../models/training_program.dart';

/// Rule-based (без ML) генератор недельной программы тренировок — Фаза 1
/// BODYRON 2.0. Полностью бесплатная функция (без [EntitlementStore]-гейта).
/// Сплит выбирается по частоте тренировок в неделю, упражнения — из уже
/// существующей встроенной библиотеки ([ExerciseLibrary.builtIn]), сеты и
/// диапазон повторений — по цели пользователя.
class ProgramGenerator {
  ProgramGenerator._();

  static const String goalMuscleGain = 'muscle_gain';
  static const String goalStrength = 'strength';
  static const String goalWeightLoss = 'weight_loss';
  static const String goalMaintenance = 'maintenance';

  static const String levelBeginner = 'beginner';
  static const String levelIntermediate = 'intermediate';
  static const String levelAdvanced = 'advanced';

  // --- Дни-архетипы: канонический ключ названия, группы мышц, упражнения --

  static const _upper = _DayTemplate(
    dayName: 'Upper Body Day',
    muscleGroups: ['Chest', 'Back', 'Shoulders', 'Arms'],
    exerciseNames: ['Bench Press', 'Barbell Row', 'Overhead Press', 'Lat Pulldown', 'Barbell Curl'],
  );
  static const _lower = _DayTemplate(
    dayName: 'Lower Body Day',
    muscleGroups: ['Legs', 'Abs'],
    exerciseNames: ['Squat', 'Romanian Deadlift', 'Leg Press', 'Walking Lunge', 'Hanging Leg Raise'],
  );

  static const _push = _DayTemplate(
    dayName: 'Push Day',
    muscleGroups: ['Chest', 'Shoulders', 'Arms'],
    exerciseNames: ['Bench Press', 'Incline Bench Press', 'Overhead Press', 'Lateral Raise', 'Triceps Pushdown'],
  );
  static const _pull = _DayTemplate(
    dayName: 'Pull Day',
    muscleGroups: ['Back', 'Arms'],
    exerciseNames: ['Deadlift', 'Pull Up', 'Barbell Row', 'Lat Pulldown', 'Barbell Curl'],
  );
  static const _legs = _DayTemplate(
    dayName: 'Legs Day',
    muscleGroups: ['Legs'],
    exerciseNames: ['Squat', 'Leg Press', 'Romanian Deadlift', 'Walking Lunge', 'Hanging Leg Raise'],
  );

  static const _chest = _DayTemplate(
    dayName: 'Chest Day',
    muscleGroups: ['Chest'],
    exerciseNames: ['Bench Press', 'Incline Bench Press', 'Dumbbell Fly'],
  );
  static const _back = _DayTemplate(
    dayName: 'Back Day',
    muscleGroups: ['Back'],
    exerciseNames: ['Deadlift', 'Pull Up', 'Barbell Row', 'Lat Pulldown'],
  );
  static const _legsFull = _DayTemplate(
    dayName: 'Legs Day',
    muscleGroups: ['Legs'],
    exerciseNames: ['Squat', 'Leg Press', 'Romanian Deadlift', 'Walking Lunge'],
  );
  static const _shoulders = _DayTemplate(
    dayName: 'Shoulders Day',
    muscleGroups: ['Shoulders'],
    exerciseNames: ['Overhead Press', 'Lateral Raise', 'Face Pull'],
  );
  static const _shouldersArms = _DayTemplate(
    dayName: 'Shoulders & Arms Day',
    muscleGroups: ['Shoulders', 'Arms'],
    exerciseNames: ['Overhead Press', 'Lateral Raise', 'Barbell Curl', 'Triceps Pushdown'],
  );
  static const _armsAbs = _DayTemplate(
    dayName: 'Arms & Abs Day',
    muscleGroups: ['Arms', 'Abs'],
    exerciseNames: ['Barbell Curl', 'Hammer Curl', 'Triceps Pushdown', 'Plank', 'Hanging Leg Raise'],
  );

  /// Слоты дней недели (1=Monday..7=Sunday) и сплит-шаблон по каждой
  /// поддерживаемой частоте тренировок в неделю. Остальные дни недели —
  /// отдых.
  static const Map<int, List<(int, _DayTemplate)>> _splitsByFrequency = {
    2: [(1, _upper), (4, _lower)],
    3: [(1, _push), (3, _pull), (5, _legs)],
    4: [(1, _chest), (2, _back), (4, _legsFull), (5, _shouldersArms)],
    5: [(1, _chest), (2, _back), (3, _legsFull), (4, _shoulders), (5, _armsAbs)],
  };

  static TrainingProgram generate({
    required String goal,
    required int frequency,
    required String level,
  }) {
    final split = _splitsByFrequency[frequency] ?? _splitsByFrequency[3]!;
    final (setsPerExercise, repsLow, repsHigh) = _setsAndRepsFor(goal);
    final slotByWeekday = {for (final (weekday, template) in split) weekday: template};

    final days = [
      for (var weekday = 1; weekday <= 7; weekday++)
        if (slotByWeekday[weekday] case final template?)
          TrainingProgramDay(
            dayOfWeek: weekday,
            isRestDay: false,
            dayName: template.dayName,
            muscleGroups: template.muscleGroups,
            exercises: [
              for (final exerciseName in template.exerciseNames)
                ProgramExercise(
                  exerciseName: exerciseName,
                  targetSets: setsPerExercise,
                  repsLow: repsLow,
                  repsHigh: repsHigh,
                ),
            ],
          )
        else
          TrainingProgramDay(dayOfWeek: weekday, isRestDay: true),
    ];

    return TrainingProgram(goal: goal, level: level, frequency: frequency, days: days);
  }

  static (int, int, int) _setsAndRepsFor(String goal) {
    switch (goal) {
      case goalStrength:
        return (3, 4, 6);
      case goalWeightLoss:
        return (3, 12, 15);
      case goalMaintenance:
        return (3, 10, 12);
      case goalMuscleGain:
      default:
        return (3, 8, 12);
    }
  }
}

class _DayTemplate {
  final String dayName;
  final List<String> muscleGroups;
  final List<String> exerciseNames;

  const _DayTemplate({
    required this.dayName,
    required this.muscleGroups,
    required this.exerciseNames,
  });
}
