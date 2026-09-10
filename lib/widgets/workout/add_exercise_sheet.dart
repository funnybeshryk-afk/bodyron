import 'package:flutter/material.dart';

import '../../data/exercise_library.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/exercise_content_l10n.dart';
import '../../l10n/muscle_group_l10n.dart';
import '../../models/exercise_definition.dart';
import '../../data/workout_session_store.dart';
import '../../theme/app_palette.dart';
import '../exercise/exercise_technique_sheet.dart';
import 'add_custom_exercise_dialog.dart';

/// Открывает bottom sheet для выбора группы мышц и упражнения —
/// из встроенной библиотеки или добавленного вручную.
Future<void> showAddExerciseSheet({
  required BuildContext context,
  required WorkoutSessionStore store,
  required String initialMuscle,
  required ValueChanged<ExerciseDefinition> onExerciseSelected,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: context.colors.card,
    isScrollControlled: true,
    builder: (context) {
      return _AddExerciseSheetContent(
        store: store,
        initialMuscle: initialMuscle,
        onExerciseSelected: onExerciseSelected,
      );
    },
  );
}

class _AddExerciseSheetContent extends StatefulWidget {
  final WorkoutSessionStore store;
  final String initialMuscle;
  final ValueChanged<ExerciseDefinition> onExerciseSelected;

  const _AddExerciseSheetContent({
    required this.store,
    required this.initialMuscle,
    required this.onExerciseSelected,
  });

  @override
  State<_AddExerciseSheetContent> createState() => _AddExerciseSheetContentState();
}

class _AddExerciseSheetContentState extends State<_AddExerciseSheetContent> {
  late String selectedMuscle = widget.initialMuscle;

  Future<void> _openAddCustomExercise() async {
    final created = await showAddCustomExerciseDialog(
      context: context,
      store: widget.store,
      initialMuscleGroup: selectedMuscle,
    );
    if (created == null) return;
    widget.onExerciseSelected(created);
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return ListenableBuilder(
      listenable: widget.store,
      builder: (context, _) {
        final exercises = widget.store.exercisesByMuscle[selectedMuscle] ?? const [];

        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.addExerciseSheetTitle,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    height: 42,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: ExerciseLibrary.muscleGroups.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (_, index) {
                        final muscle = ExerciseLibrary.muscleGroups[index];
                        final active = muscle == selectedMuscle;

                        return ChoiceChip(
                          label: Text(muscle.display(context)),
                          selected: active,
                          onSelected: (_) => setState(() => selectedMuscle = muscle),
                          selectedColor: colors.accent,
                          backgroundColor: colors.cardAlt,
                          labelStyle: TextStyle(
                            color: active ? Colors.white : colors.textSecondary,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.separated(
                      itemCount: exercises.length + 1,
                      separatorBuilder: (_, _) => const SizedBox(height: 8),
                      itemBuilder: (_, index) {
                        if (index == exercises.length) {
                          return ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: BorderSide(color: colors.cardBorder),
                            ),
                            leading: CircleAvatar(
                              backgroundColor: colors.cardAlt,
                              child: Icon(Icons.add, color: colors.accent, size: 20),
                            ),
                            title: Text(
                              l10n.addYourOwnExerciseTile,
                              style: TextStyle(fontWeight: FontWeight.w700, color: colors.accent),
                            ),
                            onTap: _openAddCustomExercise,
                          );
                        }

                        final exercise = exercises[index];

                        return ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          tileColor: colors.cardAlt,
                          leading: CircleAvatar(
                            backgroundColor: colors.card,
                            child: Icon(
                              exercise.isCustom ? Icons.star_outline : Icons.fitness_center,
                              color: colors.textSecondary,
                              size: 19,
                            ),
                          ),
                          title: Text(
                            exercise.displayName(context),
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Только у встроенных упражнений есть советы по
                              // технике — у пользовательских showExerciseTechniqueSheet
                              // просто нечего показать.
                              if (exercise.tips.isNotEmpty)
                                IconButton(
                                  icon: Icon(Icons.info_outline, color: colors.textMuted),
                                  tooltip: l10n.exerciseTechniqueTooltip,
                                  onPressed: () => showExerciseTechniqueSheet(
                                    context: context,
                                    exercise: exercise,
                                  ),
                                ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () {
                                  widget.onExerciseSelected(exercise);
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
