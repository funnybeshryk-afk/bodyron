import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

/// Локализованная относительная метка даты: "Today" / "Yesterday" /
/// "N days ago" / DD.MM.YYYY для более старых дат.
extension RelativeDateL10n on DateTime {
  String relativeLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final dateOnly = DateTime(year, month, day);
    final today = DateTime(now.year, now.month, now.day);
    final diff = today.difference(dateOnly).inDays;

    if (diff == 0) return l10n.relativeToday;
    if (diff == 1) return l10n.relativeYesterday;
    if (diff > 1 && diff < 7) return l10n.relativeDaysAgo(diff);

    String two(int v) => v.toString().padLeft(2, '0');
    return '${two(day)}.${two(month)}.$year';
  }
}
