import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/workout_csv_export.dart';
import '../../data/workout_session_store.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

/// Пункт на Profile: экспорт истории тренировок в CSV через системный
/// share sheet. Неактивен, если истории ещё нет.
class ExportHistoryTile extends StatelessWidget {
  final WorkoutSessionStore store;

  const ExportHistoryTile({
    super.key,
    required this.store,
  });

  Future<void> _export(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final messenger = ScaffoldMessenger.of(context);

    try {
      final csv = WorkoutCsvExporter.export(store.history);
      final dir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final file = File('${dir.path}/bodyron_workout_history_$timestamp.csv');
      await file.writeAsString(csv);

      await SharePlus.instance.share(
        ShareParams(
          files: [XFile(file.path, mimeType: 'text/csv')],
          text: l10n.exportHistoryShareText,
        ),
      );
    } catch (_) {
      if (!context.mounted) return;
      messenger.showSnackBar(SnackBar(content: Text(l10n.exportHistoryErrorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final colors = context.colors;
        final hasHistory = store.history.isNotEmpty;

        return InkWell(
          onTap: hasHistory ? () => _export(context) : null,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.cardBorder),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: colors.info.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(Icons.ios_share_outlined, color: colors.info),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.exportHistoryTitle,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: hasHistory ? colors.textPrimary : colors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        hasHistory ? l10n.exportHistorySubtitle : l10n.exportHistoryEmptyHint,
                        style: TextStyle(fontSize: 12, color: colors.textMuted),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: hasHistory ? colors.textMuted : colors.textFaint,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
