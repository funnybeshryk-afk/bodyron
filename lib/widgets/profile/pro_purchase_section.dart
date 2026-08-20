import 'package:flutter/material.dart';

import '../../data/entitlement_store.dart';
import '../../data/purchase_service.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';
import 'pro_badge.dart';

/// PRO-секция на Profile: если куплено — статус с датой покупки (если
/// известна); если нет — карточка "Upgrade to PRO" с честным описанием и
/// реальной ценой продукта, или "unavailable"-заглушка, пока продукт не
/// сконфигурирован в Play Console.
class ProPurchaseSection extends StatefulWidget {
  final EntitlementStore entitlementStore;
  final PurchaseService purchaseService;

  const ProPurchaseSection({
    super.key,
    required this.entitlementStore,
    required this.purchaseService,
  });

  @override
  State<ProPurchaseSection> createState() => _ProPurchaseSectionState();
}

class _ProPurchaseSectionState extends State<ProPurchaseSection> {
  int _lastHandledErrorEventId = 0;

  @override
  void initState() {
    super.initState();
    _lastHandledErrorEventId = widget.purchaseService.errorEventId;
    widget.purchaseService.addListener(_maybeShowError);
  }

  @override
  void dispose() {
    widget.purchaseService.removeListener(_maybeShowError);
    super.dispose();
  }

  void _maybeShowError() {
    final service = widget.purchaseService;
    if (service.errorEventId == _lastHandledErrorEventId) return;
    _lastHandledErrorEventId = service.errorEventId;

    final kind = service.lastError;
    if (kind == null || !mounted) return;

    final l10n = AppLocalizations.of(context)!;
    final message = switch (kind) {
      PurchaseErrorKind.network => l10n.purchaseErrorNetwork,
      PurchaseErrorKind.itemUnavailable => l10n.purchaseErrorItemUnavailable,
      PurchaseErrorKind.cancelled => l10n.purchaseErrorCancelled,
      PurchaseErrorKind.generic => l10n.purchaseErrorGeneric,
    };

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return ListenableBuilder(
      listenable: Listenable.merge([widget.entitlementStore, widget.purchaseService]),
      builder: (context, _) {
        if (widget.entitlementStore.isPro) {
          return _PurchasedCard(purchasedAt: widget.entitlementStore.purchasedAt);
        }

        final service = widget.purchaseService;

        if (service.availability == PurchaseAvailability.unknown) {
          return const _LoadingCard();
        }

        if (service.availability == PurchaseAvailability.storeUnavailable ||
            service.availability == PurchaseAvailability.productUnavailable) {
          return _UnavailableCard(
            title: l10n.proUnavailableTitle,
            subtitle: l10n.proUnavailableSubtitle,
          );
        }

        final details = service.productDetails;

        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: colors.card,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: colors.accent.withValues(alpha: 0.25)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [colors.accent, colors.accentDark],
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.workspace_premium, size: 20, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      l10n.proUpgradeDescription,
                      style: TextStyle(
                        fontSize: 12.5,
                        color: colors.textSecondary,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: details == null || service.isPurchasing ? null : service.buyPro,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.accent,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: colors.accent.withValues(alpha: 0.4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: service.isPurchasing
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2.4, color: Colors.white),
                        )
                      : Text(
                          details == null ? l10n.proUnavailableTitle : l10n.proUpgradeButtonLabel(details.price),
                          style: const TextStyle(fontWeight: FontWeight.w800),
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

class _PurchasedCard extends StatelessWidget {
  final DateTime? purchasedAt;

  const _PurchasedCard({required this.purchasedAt});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
          ProBadge(label: l10n.proBadgeLabel),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.proPurchasedTitle,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
                if (purchasedAt != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    l10n.proPurchasedOnDate(_formatDate(purchasedAt!)),
                    style: TextStyle(fontSize: 12, color: colors.textMuted),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
}

/// Placeholder for the brief moment before [PurchaseService.init] resolves.
/// Deliberately static (no ticking animation): an indeterminate spinner
/// here would never let `pumpAndSettle()` converge in widget tests, since
/// its ticker keeps re-scheduling frames regardless of how fast the
/// underlying data resolves — and in real usage this state is transitional
/// enough (microtask-scale) that a static placeholder reads fine.
class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      height: 64,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Icon(Icons.workspace_premium_outlined, size: 20, color: colors.textMuted),
    );
  }
}

class _UnavailableCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _UnavailableCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
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
          Icon(Icons.info_outline, size: 20, color: colors.textTertiary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: colors.textMuted, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
