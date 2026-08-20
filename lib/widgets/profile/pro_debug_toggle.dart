import 'package:flutter/material.dart';

import '../../data/entitlement_store.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

/// Дебажный тумблер PRO-статуса — только для ручного тестирования UI в
/// обоих состояниях (PRO/free). Виден только в debug-сборках (см.
/// `kDebugMode`-гейт в profile_screen.dart) и не персистится в БД, чтобы не
/// путаться с настоящей покупкой из [PurchaseService].
class ProDebugToggle extends StatelessWidget {
  final EntitlementStore store;

  const ProDebugToggle({
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

        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.cardBorder),
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
                child: Icon(Icons.bug_report_outlined, color: colors.accent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.proDebugToggleLabel,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      l10n.proDebugToggleSubtitle,
                      style: TextStyle(fontSize: 12, color: colors.textMuted),
                    ),
                  ],
                ),
              ),
              Switch(
                value: store.isPro,
                onChanged: (_) => store.toggleDebugPro(),
                activeTrackColor: colors.accent,
              ),
            ],
          ),
        );
      },
    );
  }
}
