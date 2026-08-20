import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

class EmptyWorkoutState extends StatelessWidget {
  final VoidCallback onAddExercise;

  const EmptyWorkoutState({
    super.key,
    required this.onAddExercise,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: colors.accent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.fitness_center,
                size: 38,
                color: colors.accent,
              ),
            ),
            const SizedBox(height: 22),
            Text(
              l10n.emptyWorkoutTitle,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.emptyWorkoutSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.textMuted,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: onAddExercise,
                icon: const Icon(Icons.add),
                label: Text(
                  l10n.addExerciseButton,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.accent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
