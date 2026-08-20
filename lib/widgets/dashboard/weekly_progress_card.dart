import 'package:flutter/material.dart';

import '../../data/dashboard_mock_data.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

class WeeklyProgressCard extends StatelessWidget {
  final WeeklyProgressStat stat;

  const WeeklyProgressCard({
    super.key,
    required this.stat,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.weeklyProgressLabel,
                style: TextStyle(
                  fontSize: 10,
                  color: colors.textMuted,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                l10n.weeklyProgressCount(stat.workoutsDone, stat.workoutsGoal),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: stat.progress.clamp(0, 1),
              minHeight: 8,
              backgroundColor: colors.cardAlt,
              valueColor: AlwaysStoppedAnimation(colors.accent),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(stat.dayLabels.length, (index) {
              final done = stat.completedDays[index];

              return Column(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: done ? colors.accent : colors.cardAlt,
                      shape: BoxShape.circle,
                    ),
                    child: done
                        ? const Icon(
                            Icons.check,
                            size: 13,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stat.dayLabels[index],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: colors.textMuted,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
