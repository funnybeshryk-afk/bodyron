import 'package:flutter/material.dart';

import 'app_palette.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final palette = AppPalette.dark();
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: palette.background,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: palette.accent,
        brightness: Brightness.dark,
      ),
      extensions: [palette],
    );
  }

  static ThemeData get light {
    final palette = AppPalette.light();
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: palette.background,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: palette.accent,
        brightness: Brightness.light,
      ),
      extensions: [palette],
    );
  }
}
