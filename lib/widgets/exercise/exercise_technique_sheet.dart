import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../l10n/exercise_content_l10n.dart';
import '../../l10n/muscle_group_l10n.dart';
import '../../models/exercise_definition.dart';
import '../../theme/app_palette.dart';
import 'muscle_group_silhouette.dart';

/// Открывает bottom sheet с силуэтом мышечной группы, советами по технике
/// и частой ошибкой для данного упражнения. Ничего не показывает для
/// пользовательских упражнений без советов — вызывающая сторона должна
/// проверить [ExerciseDefinition.tips] перед показом иконки-инфо.
Future<void> showExerciseTechniqueSheet({
  required BuildContext context,
  required ExerciseDefinition exercise,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: context.colors.card,
    isScrollControlled: true,
    builder: (context) => _ExerciseTechniqueSheetContent(exercise: exercise),
  );
}

class _ExerciseTechniqueSheetContent extends StatelessWidget {
  final ExerciseDefinition exercise;

  const _ExerciseTechniqueSheetContent({required this.exercise});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    exercise.displayName(context),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            Text(
              exercise.muscleGroup.display(context),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: colors.textMuted,
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: SizedBox(
                width: 150,
                child: MuscleGroupSilhouette(muscleGroup: exercise.muscleGroup),
              ),
            ),
            const SizedBox(height: 20),
            if (exercise.tips.isNotEmpty) ...[
              Text(
                l10n.exerciseTipsTitle,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                  color: colors.textTertiary,
                ),
              ),
              const SizedBox(height: 10),
              for (final tip in exercise.displayTips(context))
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_circle, size: 16, color: colors.success),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          tip,
                          style: TextStyle(fontSize: 14, height: 1.35, color: colors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
            if (exercise.commonMistake.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                l10n.exerciseCommonMistakeTitle,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                  color: colors.textTertiary,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.error_outline, size: 16, color: colors.accent),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      exercise.displayCommonMistake(context),
                      style: TextStyle(fontSize: 14, height: 1.35, color: colors.textSecondary),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
