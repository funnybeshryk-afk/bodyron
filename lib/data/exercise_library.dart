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
    ExerciseDefinition(
      name: 'Bench Press',
      muscleGroup: 'Chest',
      tips: [
        'Keep your shoulder blades pulled back and down throughout the lift.',
        "Lower the bar to your mid-chest with control, don't bounce it off your chest.",
        'Keep a slight arch in your lower back and feet flat on the floor.',
      ],
      commonMistake:
          'Flaring the elbows out to 90°, which stresses the shoulders — keep them closer to a 45-75° angle.',
    ),
    ExerciseDefinition(
      name: 'Incline Bench Press',
      muscleGroup: 'Chest',
      tips: [
        'Set the bench to a 15-30° incline — steeper turns it into a shoulder press.',
        'Lower the bar to your upper chest, just below the collarbone.',
        'Keep your wrists stacked directly over your elbows.',
      ],
      commonMistake:
          'Setting the incline too steep, which shifts the work to the front delts instead of the upper chest.',
    ),
    ExerciseDefinition(
      name: 'Dumbbell Fly',
      muscleGroup: 'Chest',
      tips: [
        'Keep a slight, fixed bend in your elbows throughout the movement.',
        'Lower the dumbbells in a wide arc until you feel a stretch across your chest.',
        'Squeeze your chest to bring the dumbbells back together over your chest, not your face.',
      ],
      commonMistake:
          'Bending and straightening the elbows during the rep, which turns it into a press instead of a fly.',
    ),
    ExerciseDefinition(
      name: 'Deadlift',
      muscleGroup: 'Back',
      tips: [
        'Keep the bar close to your shins and thighs throughout the pull.',
        "Brace your core and keep your spine neutral — don't round your lower back.",
        'Push the floor away with your legs before pulling with your back.',
        "Stand tall at the top by squeezing your glutes, don't hyperextend.",
      ],
      commonMistake:
          'Letting the bar drift forward away from the body, which turns the lift into a lower-back-dominant grind.',
    ),
    ExerciseDefinition(
      name: 'Pull Up',
      muscleGroup: 'Back',
      tips: [
        'Start from a full dead hang with your shoulder blades relaxed.',
        'Pull your chest toward the bar by driving your elbows down and back.',
        'Control the descent instead of dropping.',
      ],
      commonMistake:
          'Using momentum (kipping) instead of strict control, which shortcuts the range of motion.',
    ),
    ExerciseDefinition(
      name: 'Barbell Row',
      muscleGroup: 'Back',
      tips: [
        'Hinge at the hips with a flat back, roughly 45° to the floor.',
        'Pull the bar toward your lower ribs, not your chin.',
        "Keep your core braced so your torso doesn't rock with each rep.",
      ],
      commonMistake:
          'Standing too upright and turning the row into a shrug instead of a back exercise.',
    ),
    ExerciseDefinition(
      name: 'Lat Pulldown',
      muscleGroup: 'Back',
      tips: [
        'Grip slightly wider than shoulder-width and lean back only slightly.',
        'Pull the bar to your upper chest, leading with your elbows.',
        'Avoid using body momentum to yank the weight down.',
      ],
      commonMistake:
          'Pulling the bar behind the neck, which strains the shoulders for no extra benefit.',
    ),
    ExerciseDefinition(
      name: 'Squat',
      muscleGroup: 'Legs',
      tips: [
        'Keep your chest up and core braced throughout the descent.',
        'Push your knees out in line with your toes.',
        'Squat to at least parallel, where your hip crease drops below your knee.',
        'Drive through your whole foot, not just your heels or toes.',
      ],
      commonMistake:
          'Letting the knees cave inward under load, which increases knee strain.',
    ),
    ExerciseDefinition(
      name: 'Leg Press',
      muscleGroup: 'Legs',
      tips: [
        "Keep your lower back flat against the pad — don't let your hips round off it.",
        'Lower the sled until your knees reach about 90°, not past a comfortable range.',
        'Press through your whole foot, not just your toes.',
      ],
      commonMistake:
          'Going too deep and letting the lower back round off the pad, which shifts load to the spine.',
    ),
    ExerciseDefinition(
      name: 'Romanian Deadlift',
      muscleGroup: 'Legs',
      tips: [
        'Start with a slight bend in the knees and keep it fixed through the movement.',
        'Push your hips back, not down, as you lower the bar.',
        'Keep the bar close to your legs — it should almost brush your shins.',
        'Stop when you feel a strong hamstring stretch, usually mid-shin.',
      ],
      commonMistake:
          'Rounding the lower back to reach further down instead of stopping where the hamstrings allow.',
    ),
    ExerciseDefinition(
      name: 'Walking Lunge',
      muscleGroup: 'Legs',
      tips: [
        'Take a step long enough that your front knee stays behind your toes.',
        'Lower until your back knee lightly touches or hovers just above the floor.',
        'Keep your torso upright throughout each step.',
      ],
      commonMistake:
          'Taking too short a step, which pushes the front knee far past the toes and overloads it.',
    ),
    ExerciseDefinition(
      name: 'Overhead Press',
      muscleGroup: 'Shoulders',
      tips: [
        'Brace your core and squeeze your glutes to avoid arching your lower back.',
        'Press the bar in a straight line, moving your head back slightly to let it pass.',
        'Finish with the bar directly over your shoulders, not in front.',
      ],
      commonMistake:
          'Overarching the lower back to help the bar clear the face, which turns it into a lower-back exercise.',
    ),
    ExerciseDefinition(
      name: 'Lateral Raise',
      muscleGroup: 'Shoulders',
      tips: [
        'Raise the dumbbells to roughly shoulder height, no higher.',
        'Lead with your elbows, keeping a slight bend throughout.',
        "Use a lighter weight than feels 'strict' — this exercise doesn't reward momentum.",
      ],
      commonMistake:
          'Swinging the weight up using the hips and traps instead of the side delts.',
    ),
    ExerciseDefinition(
      name: 'Face Pull',
      muscleGroup: 'Shoulders',
      tips: [
        'Pull the rope toward your face, aiming for eye level.',
        'Flare your elbows out wide and rotate your hands so your thumbs point back.',
        'Squeeze your shoulder blades together at the end of each rep.',
      ],
      commonMistake:
          'Using too much weight, which turns it into a low row instead of a rear-delt and rotator-cuff exercise.',
    ),
    ExerciseDefinition(
      name: 'Barbell Curl',
      muscleGroup: 'Arms',
      tips: [
        'Keep your elbows pinned to your sides throughout the curl.',
        'Curl the bar up without swinging your torso or hips.',
        'Lower the bar under control through the full range of motion.',
      ],
      commonMistake:
          'Using body momentum (swinging) to heave the weight up instead of curling it strictly.',
    ),
    ExerciseDefinition(
      name: 'Hammer Curl',
      muscleGroup: 'Arms',
      tips: [
        'Keep your palms facing each other (neutral grip) throughout the movement.',
        'Keep your elbows close to your torso and stationary.',
        "Control the lowering phase — don't just let the weight drop.",
      ],
      commonMistake:
          'Letting the elbows drift forward, which turns the curl into a front raise.',
    ),
    ExerciseDefinition(
      name: 'Triceps Pushdown',
      muscleGroup: 'Arms',
      tips: [
        'Keep your elbows pinned to your sides throughout the set.',
        'Extend your arms fully at the bottom without locking out aggressively.',
        "Control the return — don't let the bar snap back up.",
      ],
      commonMistake:
          'Letting the elbows drift away from the body, which recruits the shoulders instead of the triceps.',
    ),
    ExerciseDefinition(
      name: 'Plank',
      muscleGroup: 'Abs',
      tips: [
        'Keep a straight line from your shoulders to your ankles.',
        "Brace your core like you're about to be poked in the stomach.",
        'Keep your glutes engaged to avoid sagging hips.',
      ],
      commonMistake:
          'Letting the hips sag or pike up, which takes tension off the core and onto the lower back.',
    ),
    ExerciseDefinition(
      name: 'Hanging Leg Raise',
      muscleGroup: 'Abs',
      tips: [
        'Hang with a full grip and avoid excessive swinging.',
        'Curl your pelvis up as you raise your legs, rather than just swinging them.',
        'Lower your legs under control instead of letting them drop.',
      ],
      commonMistake:
          'Using momentum to swing the legs up instead of controlling the movement with the abs.',
    ),
    ExerciseDefinition(
      name: 'Cable Crunch',
      muscleGroup: 'Abs',
      tips: [
        'Kneel far enough from the pulley to keep constant tension on the rope.',
        'Crunch by curling your spine, not by pulling with your arms or hips.',
        'Keep your hips relatively still — this is a spinal flexion movement, not a hip hinge.',
      ],
      commonMistake:
          'Pulling with the arms and bending at the hips instead of curling the spine.',
    ),
  ];
}
