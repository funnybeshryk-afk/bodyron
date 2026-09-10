import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

/// Полное локализованное название дня недели по [DateTime.weekday]
/// (1=Monday..7=Sunday) — используется в превью программы (онбординг,
/// Home), где короткие однобуквенные [weekdayMonShort] и т.п. неоднозначны.
extension WeekdayL10n on int {
  String weekdayFullName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case 1:
        return l10n.weekdayMonFull;
      case 2:
        return l10n.weekdayTueFull;
      case 3:
        return l10n.weekdayWedFull;
      case 4:
        return l10n.weekdayThuFull;
      case 5:
        return l10n.weekdayFriFull;
      case 6:
        return l10n.weekdaySatFull;
      case 7:
      default:
        return l10n.weekdaySunFull;
    }
  }
}
