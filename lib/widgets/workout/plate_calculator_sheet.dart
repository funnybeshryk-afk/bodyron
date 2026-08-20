import 'package:flutter/material.dart';

import '../../data/plate_calculator.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

/// Компактный bottom sheet: какие блины повесить с каждой стороны штанги
/// для введённого веса подхода.
Future<void> showPlateCalculatorSheet({
  required BuildContext context,
  required double targetWeight,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: context.colors.card,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => _PlateCalculatorContent(targetWeight: targetWeight),
  );
}

String _formatKg(double value) =>
    value % 1 == 0 ? value.toStringAsFixed(0) : value.toStringAsFixed(2);

class _PlateCalculatorContent extends StatelessWidget {
  final double targetWeight;

  const _PlateCalculatorContent({required this.targetWeight});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final breakdown = PlateCalculator.calculate(targetWeight: targetWeight);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: colors.accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(Icons.calculate_outlined, color: colors.accent),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.plateCalculatorTitle,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      '${l10n.plateCalculatorTargetWeight(_formatKg(targetWeight))} · '
                      '${l10n.plateCalculatorBarLabel(_formatKg(PlateCalculator.defaultBarWeightKg))}',
                      style: TextStyle(fontSize: 12, color: colors.textMuted),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (breakdown.belowBar)
              Text(
                l10n.plateCalculatorBelowBarMessage(
                  _formatKg(PlateCalculator.defaultBarWeightKg),
                ),
                style: TextStyle(color: colors.textSecondary, fontSize: 14),
              )
            else if (breakdown.platesPerSide.isEmpty)
              Text(
                l10n.plateCalculatorNoPlatesMessage,
                style: TextStyle(color: colors.textSecondary, fontSize: 14),
              )
            else ...[
              Text(
                l10n.plateCalculatorPerSideLabel,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: colors.textMuted,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  for (final plate in breakdown.platesPerSide) _PlateChip(weightKg: plate),
                ],
              ),
              if (!breakdown.isExact) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.accent.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    l10n.plateCalculatorApproxNote(_formatKg(breakdown.totalWeight)),
                    style: TextStyle(fontSize: 12.5, color: colors.accent, height: 1.35),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _PlateChip extends StatelessWidget {
  final double weightKg;

  const _PlateChip({required this.weightKg});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final size = 40.0 + (weightKg / PlateCalculator.availablePlatesKg.first) * 26;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.cardAlt,
        border: Border.all(color: colors.accent.withValues(alpha: 0.5), width: 2),
      ),
      child: Text(
        _formatKg(weightKg),
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900),
      ),
    );
  }
}
