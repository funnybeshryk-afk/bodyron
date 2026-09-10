import '../models/training_program.dart';
import 'program_generator.dart';

/// Одна экспертно составленная PRO-программа: статический контент (не
/// генерируется правилами, в отличие от [ProgramGenerator.generate]) —
/// та же структура [TrainingProgram], что и у бесплатной автогенерации,
/// поэтому применяется через [TrainingProgramStore.applyProgram] и дальше
/// работает как обычная активная программа (Home, Тренировка — без
/// специальной логики). [id] используется только для локализации названия
/// и описания (см. [CuratedProgramL10n]).
class CuratedProgram {
  final String id;
  final TrainingProgram program;

  const CuratedProgram({required this.id, required this.program});
}

class CuratedPrograms {
  CuratedPrograms._();

  static const String strength5x5 = 'strength_5x5';
  static const String pplHypertrophy = 'ppl_hypertrophy';
  static const String upperLowerPower = 'upper_lower_power';
  static const String fullBodyAdvanced = 'full_body_advanced';
  static const String armsShouldersSpecialization = 'arms_shoulders_specialization';

  static const List<CuratedProgram> all = [
    CuratedProgram(
      id: strength5x5,
      program: TrainingProgram(
        goal: ProgramGenerator.goalStrength,
        level: ProgramGenerator.levelIntermediate,
        frequency: 3,
        days: [
          TrainingProgramDay(
            dayOfWeek: 1,
            isRestDay: false,
            dayName: 'Full Body Day',
            muscleGroups: ['Legs', 'Chest', 'Back'],
            exercises: [
              ProgramExercise(exerciseName: 'Squat', targetSets: 5, repsLow: 5, repsHigh: 5),
              ProgramExercise(exerciseName: 'Bench Press', targetSets: 5, repsLow: 5, repsHigh: 5),
              ProgramExercise(exerciseName: 'Barbell Row', targetSets: 5, repsLow: 5, repsHigh: 5),
            ],
          ),
          TrainingProgramDay(dayOfWeek: 2, isRestDay: true),
          TrainingProgramDay(
            dayOfWeek: 3,
            isRestDay: false,
            dayName: 'Full Body Day',
            muscleGroups: ['Legs', 'Shoulders', 'Back'],
            exercises: [
              ProgramExercise(exerciseName: 'Squat', targetSets: 5, repsLow: 5, repsHigh: 5),
              ProgramExercise(exerciseName: 'Overhead Press', targetSets: 5, repsLow: 5, repsHigh: 5),
              ProgramExercise(exerciseName: 'Deadlift', targetSets: 5, repsLow: 5, repsHigh: 5),
            ],
          ),
          TrainingProgramDay(dayOfWeek: 4, isRestDay: true),
          TrainingProgramDay(
            dayOfWeek: 5,
            isRestDay: false,
            dayName: 'Full Body Day',
            muscleGroups: ['Legs', 'Chest', 'Back'],
            exercises: [
              ProgramExercise(exerciseName: 'Squat', targetSets: 5, repsLow: 5, repsHigh: 5),
              ProgramExercise(exerciseName: 'Bench Press', targetSets: 5, repsLow: 5, repsHigh: 5),
              ProgramExercise(exerciseName: 'Barbell Row', targetSets: 5, repsLow: 5, repsHigh: 5),
            ],
          ),
          TrainingProgramDay(dayOfWeek: 6, isRestDay: true),
          TrainingProgramDay(dayOfWeek: 7, isRestDay: true),
        ],
      ),
    ),
    CuratedProgram(
      id: pplHypertrophy,
      program: TrainingProgram(
        goal: ProgramGenerator.goalMuscleGain,
        level: ProgramGenerator.levelIntermediate,
        frequency: 3,
        days: [
          TrainingProgramDay(
            dayOfWeek: 1,
            isRestDay: false,
            dayName: 'Push Day',
            muscleGroups: ['Chest', 'Shoulders', 'Arms'],
            exercises: [
              ProgramExercise(exerciseName: 'Bench Press', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Incline Bench Press', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Dumbbell Fly', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Overhead Press', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Lateral Raise', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Triceps Pushdown', targetSets: 4, repsLow: 8, repsHigh: 12),
            ],
          ),
          TrainingProgramDay(dayOfWeek: 2, isRestDay: true),
          TrainingProgramDay(
            dayOfWeek: 3,
            isRestDay: false,
            dayName: 'Pull Day',
            muscleGroups: ['Back', 'Arms'],
            exercises: [
              ProgramExercise(exerciseName: 'Deadlift', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Pull Up', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Barbell Row', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Lat Pulldown', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Barbell Curl', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Hammer Curl', targetSets: 4, repsLow: 8, repsHigh: 12),
            ],
          ),
          TrainingProgramDay(dayOfWeek: 4, isRestDay: true),
          TrainingProgramDay(
            dayOfWeek: 5,
            isRestDay: false,
            dayName: 'Legs Day',
            muscleGroups: ['Legs', 'Abs'],
            exercises: [
              ProgramExercise(exerciseName: 'Squat', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Leg Press', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Romanian Deadlift', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Walking Lunge', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Hanging Leg Raise', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Cable Crunch', targetSets: 4, repsLow: 8, repsHigh: 12),
            ],
          ),
          TrainingProgramDay(dayOfWeek: 6, isRestDay: true),
          TrainingProgramDay(dayOfWeek: 7, isRestDay: true),
        ],
      ),
    ),
    CuratedProgram(
      id: upperLowerPower,
      program: TrainingProgram(
        goal: ProgramGenerator.goalStrength,
        level: ProgramGenerator.levelIntermediate,
        frequency: 4,
        days: [
          TrainingProgramDay(
            dayOfWeek: 1,
            isRestDay: false,
            dayName: 'Upper Body Day',
            muscleGroups: ['Chest', 'Back', 'Shoulders', 'Arms'],
            exercises: [
              ProgramExercise(exerciseName: 'Bench Press', targetSets: 4, repsLow: 4, repsHigh: 6),
              ProgramExercise(exerciseName: 'Barbell Row', targetSets: 4, repsLow: 4, repsHigh: 6),
              ProgramExercise(exerciseName: 'Overhead Press', targetSets: 3, repsLow: 4, repsHigh: 6),
              ProgramExercise(exerciseName: 'Barbell Curl', targetSets: 3, repsLow: 6, repsHigh: 8),
            ],
          ),
          TrainingProgramDay(
            dayOfWeek: 2,
            isRestDay: false,
            dayName: 'Lower Body Day',
            muscleGroups: ['Legs'],
            exercises: [
              ProgramExercise(exerciseName: 'Squat', targetSets: 4, repsLow: 4, repsHigh: 6),
              ProgramExercise(exerciseName: 'Romanian Deadlift', targetSets: 4, repsLow: 4, repsHigh: 6),
              ProgramExercise(exerciseName: 'Leg Press', targetSets: 3, repsLow: 6, repsHigh: 8),
            ],
          ),
          TrainingProgramDay(dayOfWeek: 3, isRestDay: true),
          TrainingProgramDay(
            dayOfWeek: 4,
            isRestDay: false,
            dayName: 'Upper Body Day',
            muscleGroups: ['Chest', 'Back', 'Shoulders', 'Arms'],
            exercises: [
              ProgramExercise(exerciseName: 'Incline Bench Press', targetSets: 3, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Lat Pulldown', targetSets: 3, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Lateral Raise', targetSets: 3, repsLow: 10, repsHigh: 12),
              ProgramExercise(exerciseName: 'Hammer Curl', targetSets: 3, repsLow: 10, repsHigh: 12),
              ProgramExercise(exerciseName: 'Triceps Pushdown', targetSets: 3, repsLow: 10, repsHigh: 12),
            ],
          ),
          TrainingProgramDay(
            dayOfWeek: 5,
            isRestDay: false,
            dayName: 'Lower Body Day',
            muscleGroups: ['Legs', 'Abs'],
            exercises: [
              ProgramExercise(exerciseName: 'Walking Lunge', targetSets: 3, repsLow: 10, repsHigh: 12),
              ProgramExercise(exerciseName: 'Leg Press', targetSets: 3, repsLow: 10, repsHigh: 12),
              ProgramExercise(exerciseName: 'Hanging Leg Raise', targetSets: 3, repsLow: 12, repsHigh: 15),
            ],
          ),
          TrainingProgramDay(dayOfWeek: 6, isRestDay: true),
          TrainingProgramDay(dayOfWeek: 7, isRestDay: true),
        ],
      ),
    ),
    CuratedProgram(
      id: fullBodyAdvanced,
      program: TrainingProgram(
        goal: ProgramGenerator.goalMuscleGain,
        level: ProgramGenerator.levelAdvanced,
        frequency: 3,
        days: [
          TrainingProgramDay(
            dayOfWeek: 1,
            isRestDay: false,
            dayName: 'Full Body Day',
            muscleGroups: ['Legs', 'Chest', 'Back', 'Shoulders', 'Arms', 'Abs'],
            exercises: [
              ProgramExercise(exerciseName: 'Squat', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Bench Press', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Barbell Row', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Overhead Press', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Romanian Deadlift', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Barbell Curl', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Plank', targetSets: 3, repsLow: 8, repsHigh: 10),
            ],
          ),
          TrainingProgramDay(dayOfWeek: 2, isRestDay: true),
          TrainingProgramDay(
            dayOfWeek: 3,
            isRestDay: false,
            dayName: 'Full Body Day',
            muscleGroups: ['Back', 'Chest', 'Legs', 'Shoulders', 'Arms', 'Abs'],
            exercises: [
              ProgramExercise(exerciseName: 'Deadlift', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Incline Bench Press', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Pull Up', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Leg Press', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Lateral Raise', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Hammer Curl', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Cable Crunch', targetSets: 3, repsLow: 8, repsHigh: 10),
            ],
          ),
          TrainingProgramDay(dayOfWeek: 4, isRestDay: true),
          TrainingProgramDay(
            dayOfWeek: 5,
            isRestDay: false,
            dayName: 'Full Body Day',
            muscleGroups: ['Legs', 'Back', 'Chest', 'Shoulders', 'Arms', 'Abs'],
            exercises: [
              ProgramExercise(exerciseName: 'Walking Lunge', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Lat Pulldown', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Dumbbell Fly', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Face Pull', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Triceps Pushdown', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Romanian Deadlift', targetSets: 3, repsLow: 8, repsHigh: 10),
              ProgramExercise(exerciseName: 'Hanging Leg Raise', targetSets: 3, repsLow: 8, repsHigh: 10),
            ],
          ),
          TrainingProgramDay(dayOfWeek: 6, isRestDay: true),
          TrainingProgramDay(dayOfWeek: 7, isRestDay: true),
        ],
      ),
    ),
    CuratedProgram(
      id: armsShouldersSpecialization,
      program: TrainingProgram(
        goal: ProgramGenerator.goalMuscleGain,
        level: ProgramGenerator.levelIntermediate,
        frequency: 4,
        days: [
          TrainingProgramDay(
            dayOfWeek: 1,
            isRestDay: false,
            dayName: 'Push Day',
            muscleGroups: ['Chest', 'Shoulders', 'Arms'],
            exercises: [
              ProgramExercise(exerciseName: 'Bench Press', targetSets: 3, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Overhead Press', targetSets: 3, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Triceps Pushdown', targetSets: 3, repsLow: 8, repsHigh: 12),
            ],
          ),
          TrainingProgramDay(
            dayOfWeek: 2,
            isRestDay: false,
            dayName: 'Pull Day',
            muscleGroups: ['Back', 'Arms'],
            exercises: [
              ProgramExercise(exerciseName: 'Barbell Row', targetSets: 3, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Lat Pulldown', targetSets: 3, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Barbell Curl', targetSets: 3, repsLow: 8, repsHigh: 12),
            ],
          ),
          TrainingProgramDay(dayOfWeek: 3, isRestDay: true),
          TrainingProgramDay(
            dayOfWeek: 4,
            isRestDay: false,
            dayName: 'Legs Day',
            muscleGroups: ['Legs'],
            exercises: [
              ProgramExercise(exerciseName: 'Squat', targetSets: 3, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Romanian Deadlift', targetSets: 3, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Leg Press', targetSets: 3, repsLow: 8, repsHigh: 12),
            ],
          ),
          TrainingProgramDay(
            dayOfWeek: 5,
            isRestDay: false,
            dayName: 'Shoulders & Arms Day',
            muscleGroups: ['Shoulders', 'Arms'],
            exercises: [
              ProgramExercise(exerciseName: 'Overhead Press', targetSets: 4, repsLow: 8, repsHigh: 12),
              ProgramExercise(exerciseName: 'Lateral Raise', targetSets: 4, repsLow: 12, repsHigh: 15),
              ProgramExercise(exerciseName: 'Face Pull', targetSets: 4, repsLow: 12, repsHigh: 15),
              ProgramExercise(exerciseName: 'Barbell Curl', targetSets: 4, repsLow: 10, repsHigh: 12),
              ProgramExercise(exerciseName: 'Hammer Curl', targetSets: 4, repsLow: 10, repsHigh: 12),
              ProgramExercise(exerciseName: 'Triceps Pushdown', targetSets: 4, repsLow: 10, repsHigh: 12),
            ],
          ),
          TrainingProgramDay(dayOfWeek: 6, isRestDay: true),
          TrainingProgramDay(dayOfWeek: 7, isRestDay: true),
        ],
      ),
    ),
  ];
}
