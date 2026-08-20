import 'package:flutter/material.dart';

import '../../data/body_weight_store.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/relative_date_l10n.dart';
import '../../theme/app_palette.dart';

class BodyWeightCard extends StatelessWidget {
  final BodyWeightStore store;
  final VoidCallback onAddEntry;

  const BodyWeightCard({
    super.key,
    required this.store,
    required this.onAddEntry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        if (!store.hasEntries) {
          return _EmptyBodyWeightCard(onAddEntry: onAddEntry);
        }

        final colors = context.colors;
        final current = store.currentKg!;
        final delta = store.deltaKg;
        final isDown = (delta ?? 0) < 0;
        final isFlat = delta == null || delta == 0;
        final deltaColor = isFlat
            ? colors.textMuted
            : (isDown ? colors.success : colors.accent);

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
                  color: colors.info.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  Icons.monitor_weight_outlined,
                  color: colors.info,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.currentBodyWeightLabel,
                      style: TextStyle(
                        fontSize: 10,
                        color: colors.textMuted,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      l10n.weightKg(current.toStringAsFixed(1)),
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (delta != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isFlat
                              ? Icons.remove
                              : (isDown ? Icons.arrow_downward : Icons.arrow_upward),
                          size: 14,
                          color: deltaColor,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          l10n.weightKg(delta.abs().toStringAsFixed(1)),
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: deltaColor,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 3),
                  Text(
                    store.latest!.date.relativeLabel(context),
                    style: TextStyle(
                      fontSize: 11,
                      color: colors.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyBodyWeightCard extends StatelessWidget {
  final VoidCallback onAddEntry;

  const _EmptyBodyWeightCard({required this.onAddEntry});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return InkWell(
      onTap: onAddEntry,
      borderRadius: BorderRadius.circular(20),
      child: Container(
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
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: colors.info.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(Icons.add, color: colors.info),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                l10n.bodyWeightEmptyMessage,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
            Icon(Icons.chevron_right, color: colors.textMuted),
          ],
        ),
      ),
    );
  }
}
