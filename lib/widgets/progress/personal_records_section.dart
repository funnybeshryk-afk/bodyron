import 'package:flutter/material.dart';

import '../../data/workout_session_store.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/exercise_content_l10n.dart';
import '../../l10n/muscle_group_l10n.dart';
import '../../theme/app_palette.dart';

/// Список личных рекордов по упражнениям (минимум 2 тренировки с ним).
class PersonalRecordsSection extends StatelessWidget {
  final WorkoutSessionStore store;

  const PersonalRecordsSection({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final records = store.personalRecords;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.progressPersonalRecordsTitle,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 14),
          if (records.isEmpty)
            Text(
              l10n.progressPersonalRecordsEmptyHint,
              style: TextStyle(color: colors.textMuted, fontSize: 13),
            )
          else
            Column(
              children: [
                for (final record in records)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: colors.accent.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Icon(
                            Icons.emoji_events_outlined,
                            size: 18,
                            color: colors.accent,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                record.exerciseName.displayExerciseName(context),
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                record.muscleGroup.display(context),
                                style: TextStyle(fontSize: 11, color: colors.textMuted),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          l10n.weightByReps(record.weight.toStringAsFixed(1), record.reps),
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
