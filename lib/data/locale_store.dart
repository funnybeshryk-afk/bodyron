import 'package:flutter/material.dart';

import '../database/database_helper.dart';

const String _localeSettingKey = 'app_locale';

/// Выбор языка интерфейса, персистится в `app_settings`. `null` — системный
/// язык устройства (использован по умолчанию, пока пользователь не выберет
/// конкретный явно).
class LocaleStore extends ChangeNotifier {
  Locale? locale;
  bool isLoaded = false;

  Future<void> loadFromDatabase() async {
    final stored = await DatabaseHelper.instance.getSetting(_localeSettingKey);
    locale = _parse(stored);
    isLoaded = true;
    notifyListeners();
  }

  void setLocale(Locale? value) {
    if (locale == value) return;
    locale = value;
    DatabaseHelper.instance.setSetting(_localeSettingKey, _serialize(value));
    notifyListeners();
  }

  static Locale? _parse(String? value) => switch (value) {
        'en' => const Locale('en'),
        'ru' => const Locale('ru'),
        'uz' => const Locale('uz'),
        _ => null,
      };

  static String _serialize(Locale? locale) => locale?.languageCode ?? 'system';
}
