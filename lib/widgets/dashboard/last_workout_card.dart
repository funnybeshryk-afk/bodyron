import 'package:flutter/material.dart';

import '../../data/dashboard_mock_data.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

class LastWorkoutCard extends StatelessWidget {
  final LastWorkoutSummary workout;

  const LastWorkoutCard({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  workout.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                workout.whenLabel,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: colors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Чипы гибкие: при большом объёме (пятизначные кг), крупном
          // системном шрифте или узком экране они ужимаются, а не рвут вёрстку.
          Row(
            children: [
              Flexible(
                child: _MetricChip(
                  icon: Icons.timer_outlined,
                  value: l10n.minutesShort(workout.durationMinutes),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: _MetricChip(
                  icon: Icons.bar_chart_rounded,
                  value: l10n.weightKg(workout.volumeKg.toStringAsFixed(0)),
                ),
              ),
              if (workout.prCount > 0) ...[
                const SizedBox(width: 8),
                Flexible(
                  child: _MetricChip(
                    icon: Icons.emoji_events_outlined,
                    value: l10n.prCount(workout.prCount),
                    color: colors.accent,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color? color;

  const _MetricChip({
    required this.icon,
    required this.value,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final chipColor = color ?? colors.textSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: colors.cardAlt,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: chipColor),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              value,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: chipColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
