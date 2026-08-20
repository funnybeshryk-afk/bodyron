import 'package:flutter/material.dart';

import '../../data/body_weight_store.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/relative_date_l10n.dart';
import '../../theme/app_palette.dart';
import 'add_body_weight_dialog.dart';

/// Секция Profile: список записей веса тела + кнопка добавления новой.
class BodyWeightSection extends StatelessWidget {
  final BodyWeightStore store;

  const BodyWeightSection({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final colors = context.colors;
        final entries = store.entriesDescending;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (entries.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    l10n.profileBodyWeightEmptyHint,
                    style: TextStyle(color: colors.textMuted, fontSize: 13),
                  ),
                )
              else
                Column(
                  children: [
                    for (final entry in entries.take(5))
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                entry.date.relativeLabel(context),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: colors.textSecondary,
                                ),
                              ),
                            ),
                            Text(
                              l10n.weightKg(entry.weightKg.toStringAsFixed(1)),
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              const SizedBox(height: 4),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => showAddBodyWeightDialog(context: context, store: store),
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(
                    l10n.addWeightEntryButton,
                    style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.6),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.accent,
                    side: BorderSide(color: colors.accent.withValues(alpha: 0.4)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
