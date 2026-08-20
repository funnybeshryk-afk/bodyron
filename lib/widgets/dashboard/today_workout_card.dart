import 'package:flutter/material.dart';

import '../../data/dashboard_mock_data.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/muscle_group_l10n.dart';
import '../../theme/app_palette.dart';

class TodayWorkoutCard extends StatelessWidget {
  final TodayWorkoutPreview workout;

  const TodayWorkoutCard({
    super.key,
    required this.workout,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: colors.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(
              Icons.today_outlined,
              color: colors.accent,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.todayWorkoutLabel,
                  style: TextStyle(
                    fontSize: 10,
                    color: colors.textMuted,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  workout.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  l10n.todayWorkoutSummary(
                    workout.muscleGroups.map((m) => m.display(context)).join(' • '),
                    workout.exerciseCount,
                    workout.estimatedMinutes,
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: colors.textMuted,
          ),
        ],
      ),
    );
  }
}
