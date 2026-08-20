import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'entitlement_store.dart';

/// In-app product id for the lifetime PRO unlock (one-time purchase, not a
/// subscription). Must be created manually in Google Play Console as a
/// "one-time product" with exactly this id — this constant only references
/// it, it doesn't create it.
const String kProLifetimeProductId = 'bodyron_pro_lifetime';

enum PurchaseErrorKind {
  /// Похоже на отсутствие сети (billing service unavailable и т.п.).
  network,

  /// Продукт недоступен именно в момент покупки (не путать с
  /// [PurchaseAvailability.productUnavailable] — это про queryProductDetails).
  itemUnavailable,

  /// Пользователь сам отменил покупку — не настоящая ошибка.
  cancelled,

  /// Всё остальное — покупка не стартовала или платформа вернула error.
  generic,
}

enum PurchaseAvailability {
  /// Ещё не проверяли (до первого [PurchaseService.init]).
  unknown,

  /// Google Play доступен, продукт найден — можно показывать кнопку покупки.
  available,

  /// Google Play доступен, но продукт не сконфигурирован в Play Console
  /// (или временно недоступен) — см. `productDetails.notFoundIDs`.
  productUnavailable,

  /// `InAppPurchase.instance.isAvailable()` вернул false — биллинг вообще
  /// недоступен на этом устройстве/сборке.
  storeUnavailable,
}

/// Обёртка над `package:in_app_purchase` для единственного PRO-продукта
/// (разовая покупка, lifetime). Владеет [EntitlementStore] и обновляет его
/// при подтверждённой покупке или восстановлении.
class PurchaseService extends ChangeNotifier {
  final EntitlementStore entitlementStore;
  final InAppPurchase? _injectedIap;

  PurchaseService({required this.entitlementStore, InAppPurchase? inAppPurchase})
      : _injectedIap = inAppPurchase;

  // Touching `InAppPurchase.instance` reaches into the platform plugin, so
  // it's deferred to first real use (init()/buyPro()) rather than done in
  // the constructor — constructing this service (e.g. as part of building
  // an IndexedStack of screens) must stay cheap and side-effect-free.
  InAppPurchase get _iap => _injectedIap ?? InAppPurchase.instance;

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  PurchaseAvailability availability = PurchaseAvailability.unknown;
  ProductDetails? productDetails;
  bool isPurchasing = false;

  /// Категория последней ошибки/отмены покупки — UI сам подбирает
  /// локализованный текст под неё. [errorEventId] увеличивается при каждом
  /// новом событии, чтобы UI мог отличить повторную ошибку от уже показанной
  /// (даже если категория совпадает с предыдущей).
  PurchaseErrorKind? lastError;
  int errorEventId = 0;

  Future<void> init() async {
    // Billing is mobile-only. Off Android/iOS (desktop/web/CI/widget-test
    // hosts) the platform channel has no native side to answer at all, so
    // even querying isAvailable() can hang indefinitely rather than error —
    // skip touching the plugin entirely instead of racing that.
    if (kIsWeb || !(Platform.isAndroid || Platform.isIOS)) {
      debugPrint('PurchaseService: billing is only supported on Android/iOS — skipping init.');
      availability = PurchaseAvailability.storeUnavailable;
      notifyListeners();
      return;
    }

    bool storeAvailable;
    try {
      // Guards against environments with no billing platform channel at all
      // (e.g. the plain-Dart widget-test host) where the call would
      // otherwise hang instead of failing fast.
      storeAvailable = await _iap.isAvailable().timeout(
            const Duration(seconds: 5),
            onTimeout: () => false,
          );
    } catch (error) {
      debugPrint('PurchaseService: isAvailable() failed: $error');
      storeAvailable = false;
    }

    if (!storeAvailable) {
      debugPrint('PurchaseService: store is unavailable on this device/build.');
      availability = PurchaseAvailability.storeUnavailable;
      notifyListeners();
      return;
    }

    _subscription = _iap.purchaseStream.listen(
      _onPurchaseUpdate,
      onError: (Object error) {
        debugPrint('PurchaseService: purchaseStream error: $error');
      },
    );

    await _queryProduct();

    // Переустановка/новое устройство под тем же аккаунтом Google — если там
    // уже есть покупка, purchaseStream пришлёт её со статусом restored.
    if (availability == PurchaseAvailability.available) {
      await _iap.restorePurchases();
    }
  }

  Future<void> _queryProduct() async {
    final response = await _iap.queryProductDetails({kProLifetimeProductId});

    if (response.error != null) {
      debugPrint('PurchaseService: queryProductDetails error: ${response.error}');
    }

    if (response.notFoundIDs.contains(kProLifetimeProductId) || response.productDetails.isEmpty) {
      // Ожидаемо, пока продукт "$kProLifetimeProductId" не создан в Google
      // Play Console как one-time product — это конфигурация, не баг кода.
      debugPrint(
        'PurchaseService: product "$kProLifetimeProductId" not found. '
        'Create it in Play Console as a one-time product with this exact id.',
      );
      availability = PurchaseAvailability.productUnavailable;
      notifyListeners();
      return;
    }

    productDetails = response.productDetails.first;
    availability = PurchaseAvailability.available;
    notifyListeners();
  }

  Future<void> buyPro() async {
    final details = productDetails;
    if (details == null || isPurchasing) return;

    isPurchasing = true;
    notifyListeners();

    final param = PurchaseParam(productDetails: details);
    final started = await _iap.buyNonConsumable(purchaseParam: param);
    if (!started) {
      isPurchasing = false;
      _emitError(PurchaseErrorKind.generic);
    }
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      if (purchase.productID != kProLifetimeProductId) continue;

      switch (purchase.status) {
        case PurchaseStatus.pending:
          isPurchasing = true;
          notifyListeners();
          break;

        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          isPurchasing = false;
          entitlementStore.grantProFromPurchase(purchasedAt: _parseTransactionDate(purchase));
          notifyListeners();
          if (purchase.pendingCompletePurchase) {
            _iap.completePurchase(purchase);
          }
          break;

        case PurchaseStatus.canceled:
          isPurchasing = false;
          _emitError(PurchaseErrorKind.cancelled);
          break;

        case PurchaseStatus.error:
          isPurchasing = false;
          _emitError(_classifyError(purchase.error));
          break;
      }
    }
  }

  DateTime? _parseTransactionDate(PurchaseDetails purchase) {
    final raw = purchase.transactionDate;
    if (raw == null) return null;
    final millis = int.tryParse(raw);
    return millis == null ? null : DateTime.fromMillisecondsSinceEpoch(millis);
  }

  PurchaseErrorKind _classifyError(IAPError? error) {
    if (error == null) return PurchaseErrorKind.generic;

    final haystack = '${error.code} ${error.message}'.toLowerCase();
    if (haystack.contains('network') || haystack.contains('service_unavailable')) {
      return PurchaseErrorKind.network;
    }
    if (haystack.contains('item') || haystack.contains('unavailable')) {
      return PurchaseErrorKind.itemUnavailable;
    }
    return PurchaseErrorKind.generic;
  }

  void _emitError(PurchaseErrorKind kind) {
    lastError = kind;
    errorEventId++;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
