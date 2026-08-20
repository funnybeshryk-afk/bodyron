import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/active_exercise.dart';
import '../../models/workout_set_entry.dart';
import '../../data/workout_session_store.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';
import 'intensity_selector.dart';
import 'number_stepper.dart';
import 'plate_calculator_sheet.dart';

/// Строка одного подхода: вес/повторы со степперами, интенсивность,
/// отметка "выполнено". Долгое нажатие удаляет подход.
class SetEntryRow extends StatelessWidget {
  final WorkoutSessionStore store;
  final ActiveExercise entry;
  final WorkoutSetEntry set;
  final int index;

  const SetEntryRow({
    super.key,
    required this.store,
    required this.entry,
    required this.set,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final completed = set.completed;

    // "Last: X kg × Y" — только над первым подходом, только если это
    // упражнение уже выполнялось раньше (иначе не показываем ничего).
    final lastSet = index == 0 ? store.lastSetFor(entry.exercise.name) : null;

    return GestureDetector(
      onLongPress: () {
        HapticFeedback.mediumImpact();
        store.removeSet(entry, set);
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: completed ? colors.success.withValues(alpha: 0.08) : colors.cardAlt,
          borderRadius: BorderRadius.circular(14),
          border: completed
              ? Border.all(color: colors.success.withValues(alpha: 0.4))
              : null,
        ),
        child: Column(
          children: [
            if (lastSet != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    l10n.lastSetHint(_formatWeight(lastSet.weight), lastSet.reps),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: colors.textMuted,
                    ),
                  ),
                ),
              ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                  child: Text(
                    '${index + 1}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: colors.textTertiary,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                NumberStepper(
                  value: set.weight,
                  step: 1.25,
                  enabled: !completed,
                  onChanged: (v) => store.updateSetWeight(entry, set, v),
                ),
                _PlateCalculatorButton(weight: set.weight),
                const SizedBox(width: 2),
                NumberStepper(
                  value: set.reps.toDouble(),
                  step: 1,
                  decimals: 0,
                  enabled: !completed,
                  onChanged: (v) => store.updateSetReps(entry, set, v.round()),
                ),
                const Spacer(),
                _CompleteButton(
                  completed: completed,
                  onTap: () => store.toggleSetCompleted(entry, set),
                ),
              ],
            ),
            const SizedBox(height: 8),
            IntensitySelector(store: store, entry: entry, set: set),
          ],
        ),
      ),
    );
  }
}

String _formatWeight(double value) =>
    value % 1 == 0 ? value.toStringAsFixed(0) : value.toStringAsFixed(2);

class _PlateCalculatorButton extends StatelessWidget {
  final double weight;

  const _PlateCalculatorButton({required this.weight});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return IconButton(
      onPressed: weight <= 0
          ? null
          : () => showPlateCalculatorSheet(context: context, targetWeight: weight),
      icon: const Icon(Icons.calculate_outlined, size: 16),
      color: colors.textSecondary,
      disabledColor: colors.textFaint,
      tooltip: l10n.plateCalculatorTooltip,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 26, minHeight: 26),
    );
  }
}

class _CompleteButton extends StatelessWidget {
  final bool completed;
  final VoidCallback onTap;

  const _CompleteButton({
    required this.completed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: completed ? colors.success : colors.card,
          shape: BoxShape.circle,
          border: completed ? null : Border.all(color: colors.cardBorder),
        ),
        child: Icon(
          Icons.check,
          size: 18,
          color: completed ? Colors.white : colors.textFaint,
        ),
      ),
    );
  }
}
