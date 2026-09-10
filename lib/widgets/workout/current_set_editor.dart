import 'package:flutter/material.dart';

import '../../data/workout_session_store.dart';
import '../../l10n/app_localizations.dart';
import '../../models/active_exercise.dart';
import '../../models/workout_set_entry.dart';
import '../../theme/app_palette.dart';
import 'intensity_selector.dart';
import 'number_stepper.dart';

/// Крупный редактор ТЕКУЩЕГО (первого невыполненного) подхода — сердце
/// пошагового режима Тренировки (см. Phase 1 ТЗ, п.4): большие степперы
/// веса/повторений, значения по умолчанию уже подставлены из истории (см.
/// [WorkoutSessionStore.addSet]), большая кнопка "✓ ГОТОВО" завершает
/// подход и запускает таймер отдыха (см. [WorkoutSessionStore.toggleSetCompleted]).
class CurrentSetEditor extends StatelessWidget {
  final WorkoutSessionStore store;
  final ActiveExercise entry;
  final WorkoutSetEntry set;
  final int index;

  const CurrentSetEditor({
    super.key,
    required this.store,
    required this.entry,
    required this.set,
    required this.index,
  });

  void _markDone(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    store.toggleSetCompleted(entry, set);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.setDoneFeedback), duration: const Duration(seconds: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final lastSet = index == 0 ? store.lastSetFor(entry.exercise.name) : null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.accent.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.progressSetLabel(index + 1),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
              color: colors.textMuted,
            ),
          ),
          if (lastSet != null) ...[
            const SizedBox(height: 2),
            Text(
              l10n.lastSetHint(_formatWeight(lastSet.weight), lastSet.reps),
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: colors.textMuted),
            ),
          ],
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NumberStepper(
                value: set.weight,
                step: 1.25,
                large: true,
                onChanged: (v) => store.updateSetWeight(entry, set, v),
              ),
              NumberStepper(
                value: set.reps.toDouble(),
                step: 1,
                decimals: 0,
                large: true,
                onChanged: (v) => store.updateSetReps(entry, set, v.round()),
              ),
            ],
          ),
          const SizedBox(height: 14),
          IntensitySelector(store: store, entry: entry, set: set),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => _markDone(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                l10n.setDoneButton,
                style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.8, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String _formatWeight(double value) =>
    value % 1 == 0 ? value.toStringAsFixed(0) : value.toStringAsFixed(2);
