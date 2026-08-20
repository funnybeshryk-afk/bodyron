import 'package:flutter/material.dart';

import '../../data/entitlement_store.dart';
import '../../data/smart_progression_engine.dart';
import '../../data/workout_session_store.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';
import '../pro_teaser_card.dart';

/// Показывается перед первым подходом упражнения: PRO-подсказка по
/// следующей цели (вес × диапазон повторений), опционально с баннером
/// плато. Не-PRO пользователям вместо неё показывается тизер.
class NextTargetCard extends StatelessWidget {
  final WorkoutSessionStore store;
  final EntitlementStore entitlementStore;
  final String exerciseName;

  const NextTargetCard({
    super.key,
    required this.store,
    required this.entitlementStore,
    required this.exerciseName,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    if (!entitlementStore.isPro) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ProTeaserCard(
          title: l10n.smartProgressionTeaserTitle,
          subtitle: l10n.smartProgressionTeaserSubtitle,
          icon: Icons.trending_up,
        ),
      );
    }

    final target = SmartProgressionEngine.suggestNextTarget(
      exerciseName: exerciseName,
      history: store.history,
    );
    if (target == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: colors.accent.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: colors.accent.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.bolt, size: 18, color: colors.accent),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.nextTargetLabel,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                          color: colors.textMuted,
                        ),
                      ),
                      Text(
                        l10n.nextTargetValue(_formatWeight(target.weight), target.repsLow, target.repsHigh),
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (target.isPlateauDetected) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: colors.cardAlt,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: colors.cardBorder),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, size: 16, color: colors.textTertiary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.plateauBannerTitle,
                          style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l10n.plateauBannerMessage,
                          style: TextStyle(fontSize: 11.5, color: colors.textMuted, height: 1.35),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

String _formatWeight(double value) =>
    value % 1 == 0 ? value.toStringAsFixed(0) : value.toStringAsFixed(2);
