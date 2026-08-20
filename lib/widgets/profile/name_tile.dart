import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

/// Строка с локальным именем пользователя (или заглушкой) и кнопкой правки.
class NameTile extends StatelessWidget {
  final String? name;
  final VoidCallback onTap;

  const NameTile({
    super.key,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final hasName = name != null && name!.trim().isNotEmpty;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
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
                color: colors.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(Icons.person_outline, color: colors.accent),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                hasName ? name! : l10n.profileNameEmpty,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: hasName ? colors.textPrimary : colors.textMuted,
                ),
              ),
            ),
            Icon(Icons.edit_outlined, size: 18, color: colors.textMuted),
          ],
        ),
      ),
    );
  }
}
