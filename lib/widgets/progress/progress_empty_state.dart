import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

class ProgressEmptyState extends StatelessWidget {
  const ProgressEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                color: colors.accent.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.show_chart, size: 38, color: colors.accent),
            ),
            const SizedBox(height: 22),
            Text(
              l10n.progressEmptyTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.progressEmptyMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: colors.textMuted, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
