import 'package:flutter/material.dart';

import '../database/database_helper.dart';

const String _themeModeSettingKey = 'theme_mode';

/// Выбор темы (light/dark/system), персистится в `app_settings`. По
/// умолчанию — system, пока пользователь явно не выбрал другое.
class ThemeStore extends ChangeNotifier {
  ThemeMode mode = ThemeMode.system;
  bool isLoaded = false;

  Future<void> loadFromDatabase() async {
    final stored = await DatabaseHelper.instance.getSetting(_themeModeSettingKey);
    mode = _parse(stored) ?? ThemeMode.system;
    isLoaded = true;
    notifyListeners();
  }

  void setMode(ThemeMode value) {
    if (mode == value) return;
    mode = value;
    DatabaseHelper.instance.setSetting(_themeModeSettingKey, _serialize(value));
    notifyListeners();
  }

  static ThemeMode? _parse(String? value) => switch (value) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        'system' => ThemeMode.system,
        _ => null,
      };

  static String _serialize(ThemeMode mode) => switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        ThemeMode.system => 'system',
      };
}
