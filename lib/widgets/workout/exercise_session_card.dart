import 'package:flutter/material.dart';

import '../../models/active_exercise.dart';
import '../../data/entitlement_store.dart';
import '../../data/workout_session_store.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/exercise_content_l10n.dart';
import '../../l10n/muscle_group_l10n.dart';
import '../../theme/app_palette.dart';
import 'current_set_editor.dart';
import 'next_target_card.dart';
import 'set_entry_row.dart';

class ExerciseSessionCard extends StatelessWidget {
  final WorkoutSessionStore store;
  final EntitlementStore entitlementStore;
  final ActiveExercise entry;

  const ExerciseSessionCard({
    super.key,
    required this.store,
    required this.entitlementStore,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.exercise.displayName(context),
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      entry.exercise.muscleGroup.display(context).toUpperCase(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        color: colors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: colors.textMuted, size: 20),
                onPressed: () => store.removeExercise(entry),
                tooltip: l10n.removeExerciseTooltip,
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (entry.sets.every((s) => !s.completed))
            NextTargetCard(
              store: store,
              entitlementStore: entitlementStore,
              exerciseName: entry.exercise.name,
            ),
          if (entry.sets.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                l10n.noSetsYetMessage,
                style: TextStyle(color: colors.textMuted, fontSize: 13),
              ),
            )
          else
            Column(
              children: [
                // Уже выполненные подходы — компактной строкой (см.
                // SetEntryRow); первый невыполненный — крупным фокусным
                // редактором (см. CurrentSetEditor), одно и то же и для
                // подходов, добавленных программой, и вручную. Ещё не
                // дошедшие подходы не показываются — по одному за раз,
                // как того требует пошаговый режим Тренировки.
                for (var i = 0; i < entry.sets.length; i++)
                  if (entry.sets[i].completed)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SetEntryRow(
                        store: store,
                        entry: entry,
                        set: entry.sets[i],
                        index: i,
                      ),
                    ),
                if (entry.sets.any((s) => !s.completed))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: CurrentSetEditor(
                      store: store,
                      entry: entry,
                      set: entry.sets.firstWhere((s) => !s.completed),
                      index: entry.sets.indexWhere((s) => !s.completed),
                    ),
                  ),
              ],
            ),
          const SizedBox(height: 4),
          TextButton.icon(
            onPressed: () => store.addSet(entry),
            icon: Icon(Icons.add, size: 18, color: colors.accent),
            label: Text(
              l10n.addSetButton,
              style: TextStyle(color: colors.accent, fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
