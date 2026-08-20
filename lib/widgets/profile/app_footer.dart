import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

/// Простой footer внизу Profile: логотип BODYRON + версия приложения.
class AppFooter extends StatefulWidget {
  const AppFooter({super.key});

  @override
  State<AppFooter> createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter> {
  String? _version;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((info) {
      if (mounted) setState(() => _version = info.version);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset('icon.png', width: 40, height: 40),
        ),
        const SizedBox(height: 10),
        Text(
          l10n.appTitle,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
            color: colors.textSecondary,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          l10n.appVersionLabel(_version ?? '—'),
          style: TextStyle(fontSize: 11, color: colors.textFaint),
        ),
      ],
    );
  }
}
