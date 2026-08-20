import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

class StartWorkoutCard extends StatelessWidget {
  final VoidCallback onStart;

  const StartWorkoutCard({
    super.key,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [colors.accent, colors.accentDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.fitness_center, size: 22, color: Colors.white),
          const SizedBox(height: 6),
          Text(
            l10n.startWorkoutEyebrow,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            l10n.startWorkoutHeadline,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 38,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onStart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.startWorkoutButton,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
