import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.appTitle,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.appTagline,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            color: colors.textTertiary,
          ),
        ),
      ],
    );
  }
}
