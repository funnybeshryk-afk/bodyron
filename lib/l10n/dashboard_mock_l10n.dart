import 'package:flutter/widgets.dart';

/// Локализация названий из [DashboardMockData] — это демо-плейсхолдеры,
/// которые дашборд показывает до того, как появится реальная история
/// тренировок (см. dashboard_screen.dart). Названия используют ту же
/// терминологию, что и одноимённые готовые программы в [ProgramL10n]
/// ('Толкающий день' / 'Тянущий день').
const Map<String, String> _ruMockWorkoutName = {
  'Push Day': 'Жимовой день',
  'Pull Day': 'Тяговый день',
};

const Map<String, String> _uzMockWorkoutName = {
  'Push Day': 'Ko‘krak va yelka kuni',
  'Pull Day': 'Tortish mashqlari kuni',
};

extension MockWorkoutNameL10n on String {
  /// Локализованное название демо-тренировки на дашборде. Строка должна
  /// быть одним из канонических английских ключей выше ('Push Day',
  /// 'Pull Day'); для остального возвращается исходная строка без изменений.
  String displayMockWorkoutName(BuildContext context) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'ru':
        return _ruMockWorkoutName[this] ?? this;
      case 'uz':
        return _uzMockWorkoutName[this] ?? this;
      default:
        return this;
    }
  }
}
