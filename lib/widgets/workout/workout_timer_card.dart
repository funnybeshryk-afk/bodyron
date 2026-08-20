import 'package:flutter/material.dart';

import '../../data/workout_session_store.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';
import 'elapsed_time_text.dart';

class WorkoutTimerCard extends StatelessWidget {
  final WorkoutSessionStore store;

  const WorkoutTimerCard({
    super.key,
    required this.store,
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
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: colors.accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              Icons.timer_outlined,
              color: colors.accent,
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.workoutTimeLabel,
                style: TextStyle(
                  fontSize: 10,
                  color: colors.textMuted,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              ElapsedTimeText(store: store),
            ],
          ),
        ],
      ),
    );
  }
}
