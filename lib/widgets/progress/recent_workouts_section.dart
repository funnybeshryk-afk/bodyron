import 'package:flutter/material.dart';

import '../../data/workout_session_store.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/relative_date_l10n.dart';
import '../../l10n/workout_name_l10n.dart';
import '../../theme/app_palette.dart';
import 'workout_detail_sheet.dart';

/// Список последних завершённых тренировок с возможностью открыть детали.
class RecentWorkoutsSection extends StatelessWidget {
  final WorkoutSessionStore store;

  const RecentWorkoutsSection({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final workouts = store.history.reversed.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final workout in workouts)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: () => showWorkoutDetailSheet(context: context, workout: workout),
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.card,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: colors.cardBorder),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workout.name.displayWorkoutName(context),
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            l10n.recentWorkoutSummary(
                              workout.date.relativeLabel(context),
                              workout.exercises.length,
                              l10n.minutesShort(workout.durationMinutes),
                            ),
                            style: TextStyle(fontSize: 12, color: colors.textMuted),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      l10n.weightKg(workout.volumeKg.toStringAsFixed(0)),
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(width: 6),
                    Icon(Icons.chevron_right, size: 18, color: colors.textMuted),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
