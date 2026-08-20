import 'package:flutter/material.dart';

/// Семантические цвета приложения, зависящие от текущей темы (light/dark).
/// Виджеты читают их через `context.colors.xxx` (см. [AppPaletteX]) вместо
/// захардкоженных значений — единственный способ, которым тема реально
/// меняет вид экранов, а не только цвета стандартных Material-виджетов.
class AppPalette extends ThemeExtension<AppPalette> {
  final Color accent;
  final Color accentDark;
  final Color background;
  final Color card;
  final Color cardAlt;
  final Color navBackground;
  final Color success;
  final Color info;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textMuted;
  final Color textFaint;
  final Color cardBorder;

  const AppPalette({
    required this.accent,
    required this.accentDark,
    required this.background,
    required this.card,
    required this.cardAlt,
    required this.navBackground,
    required this.success,
    required this.info,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textMuted,
    required this.textFaint,
    required this.cardBorder,
  });

  /// Бренд-акцент (красный/оранжевый) одинаков в обеих темах — только фон и
  /// текст меняются местами.
  static const _accent = Color(0xFFFF3B30);
  static const _accentDark = Color(0xFFB71C1C);
  static const _success = Color(0xFF34C759);
  static const _info = Color(0xFF0A84FF);

  factory AppPalette.dark() => AppPalette(
        accent: _accent,
        accentDark: _accentDark,
        background: const Color(0xFF0B0B0D),
        card: const Color(0xFF151518),
        cardAlt: const Color(0xFF202024),
        navBackground: const Color(0xFF111114),
        success: _success,
        info: _info,
        textPrimary: Colors.white,
        textSecondary: Colors.white70,
        textTertiary: Colors.white54,
        textMuted: Colors.white38,
        textFaint: Colors.white24,
        cardBorder: Colors.white.withValues(alpha: 0.06),
      );

  factory AppPalette.light() => AppPalette(
        accent: _accent,
        accentDark: _accentDark,
        background: const Color(0xFFF6F6F8),
        card: Colors.white,
        cardAlt: const Color(0xFFEFEFF2),
        navBackground: Colors.white,
        success: _success,
        info: _info,
        textPrimary: const Color(0xFF15151A),
        textSecondary: Colors.black.withValues(alpha: 0.68),
        textTertiary: Colors.black.withValues(alpha: 0.54),
        textMuted: Colors.black.withValues(alpha: 0.38),
        textFaint: Colors.black.withValues(alpha: 0.24),
        cardBorder: Colors.black.withValues(alpha: 0.08),
      );

  @override
  AppPalette copyWith({
    Color? accent,
    Color? accentDark,
    Color? background,
    Color? card,
    Color? cardAlt,
    Color? navBackground,
    Color? success,
    Color? info,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textMuted,
    Color? textFaint,
    Color? cardBorder,
  }) {
    return AppPalette(
      accent: accent ?? this.accent,
      accentDark: accentDark ?? this.accentDark,
      background: background ?? this.background,
      card: card ?? this.card,
      cardAlt: cardAlt ?? this.cardAlt,
      navBackground: navBackground ?? this.navBackground,
      success: success ?? this.success,
      info: info ?? this.info,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textMuted: textMuted ?? this.textMuted,
      textFaint: textFaint ?? this.textFaint,
      cardBorder: cardBorder ?? this.cardBorder,
    );
  }

  @override
  AppPalette lerp(ThemeExtension<AppPalette>? other, double t) {
    if (other is! AppPalette) return this;
    return AppPalette(
      accent: Color.lerp(accent, other.accent, t)!,
      accentDark: Color.lerp(accentDark, other.accentDark, t)!,
      background: Color.lerp(background, other.background, t)!,
      card: Color.lerp(card, other.card, t)!,
      cardAlt: Color.lerp(cardAlt, other.cardAlt, t)!,
      navBackground: Color.lerp(navBackground, other.navBackground, t)!,
      success: Color.lerp(success, other.success, t)!,
      info: Color.lerp(info, other.info, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      textFaint: Color.lerp(textFaint, other.textFaint, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
    );
  }
}

/// `context.colors.card` вместо `Theme.of(context).extension<AppPalette>()!.card`.
extension AppPaletteX on BuildContext {
  AppPalette get colors => Theme.of(this).extension<AppPalette>()!;
}
