import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/active_exercise.dart';
import '../../models/workout_set_entry.dart';
import '../../data/workout_session_store.dart';
import '../../theme/app_palette.dart';
import 'intensity_picker_sheet.dart';

/// Кнопка-плашка под подходом, показывающая текущую интенсивность
/// (RPE или "до отказа") и открывающая выбор при нажатии.
class IntensitySelector extends StatelessWidget {
  final WorkoutSessionStore store;
  final ActiveExercise entry;
  final WorkoutSetEntry set;

  const IntensitySelector({
    super.key,
    required this.store,
    required this.entry,
    required this.set,
  });

  static String formatRpe(double value) =>
      value % 1 == 0 ? value.toStringAsFixed(0) : value.toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final active = set.toFailure || set.rpe != null;
    final label = set.toFailure
        ? l10n.toFailureChipLabel
        : (set.rpe != null ? l10n.rpeValue(formatRpe(set.rpe!)) : l10n.addIntensityLabel);

    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () => showIntensityPickerSheet(
        context: context,
        store: store,
        entry: entry,
        set: set,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: active ? colors.accent.withValues(alpha: 0.1) : colors.card,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: active ? colors.accent.withValues(alpha: 0.35) : colors.cardBorder,
          ),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              set.toFailure ? Icons.whatshot : Icons.speed,
              size: 14,
              color: active ? colors.accent : colors.textMuted,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
                color: active ? colors.accent : colors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
