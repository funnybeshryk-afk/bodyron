import 'package:flutter/foundation.dart';

import '../database/database_helper.dart';

const String _isProSettingKey = 'entitlement_is_pro';
const String _purchasedAtSettingKey = 'entitlement_purchased_at';

/// Доступ к PRO-функциям (Smart Progression, расширенные графики и т.д.).
/// Источник правды — покупка в Google Play (см. [PurchaseService]); сюда
/// она попадает через [grantProFromPurchase] и персистится в
/// `app_settings`, чтобы PRO не терялся до следующего restorePurchases при
/// холодном старте. [setPro]/[toggleDebugPro] — только для debug-тумблера
/// на Profile (см. [kDebugMode]-гейт в UI), в БД не пишутся.
class EntitlementStore extends ChangeNotifier {
  bool _isPro = false;
  DateTime? _purchasedAt;
  bool isLoaded = false;

  bool get isPro => _isPro;

  /// Дата настоящей покупки (если известна) — для "Purchased on {date}".
  /// `null` для debug-переключений или если дата недоступна.
  DateTime? get purchasedAt => _purchasedAt;

  Future<void> loadFromDatabase() async {
    final db = DatabaseHelper.instance;
    final storedIsPro = await db.getSetting(_isProSettingKey);
    final storedPurchasedAt = await db.getSetting(_purchasedAtSettingKey);

    _isPro = storedIsPro == '1';
    _purchasedAt = storedPurchasedAt == null ? null : DateTime.tryParse(storedPurchasedAt);

    isLoaded = true;
    notifyListeners();
  }

  /// Вызывается [PurchaseService] при подтверждённой покупке (или
  /// restorePurchases) — обновляет и персистит состояние.
  void grantProFromPurchase({DateTime? purchasedAt}) {
    _isPro = true;
    _purchasedAt = purchasedAt ?? _purchasedAt;

    final db = DatabaseHelper.instance;
    db.setSetting(_isProSettingKey, '1');
    if (_purchasedAt != null) {
      db.setSetting(_purchasedAtSettingKey, _purchasedAt!.toIso8601String());
    }

    notifyListeners();
  }

  void setPro(bool value) {
    if (_isPro == value) return;
    _isPro = value;
    notifyListeners();
  }

  void toggleDebugPro() => setPro(!_isPro);
}
