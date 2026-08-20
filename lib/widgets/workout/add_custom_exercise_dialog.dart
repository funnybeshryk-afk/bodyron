import 'package:flutter/material.dart';

import '../../data/exercise_library.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/muscle_group_l10n.dart';
import '../../models/exercise_definition.dart';
import '../../data/workout_session_store.dart';
import '../../theme/app_palette.dart';

/// Диалог добавления собственного упражнения: название + опциональная
/// (по умолчанию — текущая) группа мышц. Сохраняется в [WorkoutSessionStore]
/// и становится доступным в общей библиотеке.
Future<ExerciseDefinition?> showAddCustomExerciseDialog({
  required BuildContext context,
  required WorkoutSessionStore store,
  required String initialMuscleGroup,
}) {
  return showDialog<ExerciseDefinition>(
    context: context,
    builder: (context) => _AddCustomExerciseDialog(
      store: store,
      initialMuscleGroup: initialMuscleGroup,
    ),
  );
}

class _AddCustomExerciseDialog extends StatefulWidget {
  final WorkoutSessionStore store;
  final String initialMuscleGroup;

  const _AddCustomExerciseDialog({
    required this.store,
    required this.initialMuscleGroup,
  });

  @override
  State<_AddCustomExerciseDialog> createState() => _AddCustomExerciseDialogState();
}

class _AddCustomExerciseDialogState extends State<_AddCustomExerciseDialog> {
  final _controller = TextEditingController();
  late String _muscleGroup = widget.initialMuscleGroup;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    final definition = widget.store.addCustomExercise(
      name: name,
      muscleGroup: _muscleGroup,
    );
    Navigator.pop(context, definition);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return AlertDialog(
      backgroundColor: colors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        l10n.addCustomExerciseDialogTitle,
        style: const TextStyle(fontWeight: FontWeight.w900),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            autofocus: true,
            style: TextStyle(color: colors.textPrimary),
            decoration: InputDecoration(
              hintText: l10n.exerciseNameHint,
              hintStyle: TextStyle(color: colors.textFaint),
              filled: true,
              fillColor: colors.cardAlt,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
            onSubmitted: (_) => _submit(),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.muscleGroupOptionalLabel,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ExerciseLibrary.muscleGroups.map((group) {
              final active = group == _muscleGroup;

              return ChoiceChip(
                label: Text(group.display(context)),
                selected: active,
                onSelected: (_) => setState(() => _muscleGroup = group),
                selectedColor: colors.accent,
                backgroundColor: colors.cardAlt,
                labelStyle: TextStyle(
                  color: active ? Colors.white : colors.textSecondary,
                  fontWeight: FontWeight.w700,
                ),
              );
            }).toList(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.cancel, style: TextStyle(color: colors.textSecondary)),
        ),
        ElevatedButton(
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.accent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(l10n.add, style: const TextStyle(fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }
}
