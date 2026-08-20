import 'package:flutter/foundation.dart';

import '../database/database_helper.dart';

const String _userNameSettingKey = 'user_name';

/// Локальное (без авторизации/бэкенда) имя пользователя. Персистится в
/// SQLite через [DatabaseHelper].
class UserProfileStore extends ChangeNotifier {
  String? userName;
  bool isLoaded = false;

  Future<void> loadFromDatabase() async {
    final stored = await DatabaseHelper.instance.getSetting(_userNameSettingKey);
    userName = (stored == null || stored.isEmpty) ? null : stored;
    isLoaded = true;
    notifyListeners();
  }

  void setName(String? name) {
    final trimmed = name?.trim();
    userName = (trimmed == null || trimmed.isEmpty) ? null : trimmed;
    DatabaseHelper.instance.setSetting(_userNameSettingKey, userName ?? '');
    notifyListeners();
  }
}
