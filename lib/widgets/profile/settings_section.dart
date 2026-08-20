import 'package:flutter/material.dart';

import '../../data/theme_store.dart';
import '../../data/workout_session_store.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';
import '../workout/rest_duration_sheet.dart';

/// Секция Profile: настройки приложения — дефолтная длительность отдыха,
/// единицы веса (kg сейчас зафиксирован, lb пока неактивен) и тема.
class SettingsSection extends StatelessWidget {
  final WorkoutSessionStore workoutStore;
  final ThemeStore themeStore;

  const SettingsSection({
    super.key,
    required this.workoutStore,
    required this.themeStore,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        children: [
          ListenableBuilder(
            listenable: workoutStore,
            builder: (context, _) {
              return InkWell(
                onTap: () => showRestDurationSheet(context: context, store: workoutStore),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Icon(Icons.timer_outlined, size: 20, color: colors.textSecondary),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          l10n.restDurationSettingTitle,
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        _formatDuration(workoutStore.restDurationSeconds),
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: colors.textMuted,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.chevron_right, size: 18, color: colors.textMuted),
                    ],
                  ),
                ),
              );
            },
          ),
          Divider(height: 1, color: colors.cardBorder, indent: 18, endIndent: 18),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Icon(Icons.scale_outlined, size: 20, color: colors.textFaint),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.weightUnitSettingTitle,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: colors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        l10n.weightUnitComingSoonHint,
                        style: TextStyle(fontSize: 11, color: colors.textFaint),
                      ),
                    ],
                  ),
                ),
                Text(
                  'kg',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: colors.textFaint,
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: colors.cardBorder, indent: 18, endIndent: 18),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.palette_outlined, size: 20, color: colors.textSecondary),
                    const SizedBox(width: 14),
                    Text(
                      l10n.themeSettingTitle,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ListenableBuilder(
                  listenable: themeStore,
                  builder: (context, _) {
                    return SizedBox(
                      width: double.infinity,
                      child: SegmentedButton<ThemeMode>(
                        segments: [
                          ButtonSegment(
                            value: ThemeMode.light,
                            label: Text(l10n.themeModeLight),
                            icon: const Icon(Icons.light_mode_outlined, size: 16),
                          ),
                          ButtonSegment(
                            value: ThemeMode.dark,
                            label: Text(l10n.themeModeDark),
                            icon: const Icon(Icons.dark_mode_outlined, size: 16),
                          ),
                          ButtonSegment(
                            value: ThemeMode.system,
                            label: Text(l10n.themeModeSystem),
                            icon: const Icon(Icons.settings_suggest_outlined, size: 16),
                          ),
                        ],
                        selected: {themeStore.mode},
                        onSelectionChanged: (selection) => themeStore.setMode(selection.first),
                        showSelectedIcon: false,
                        style: SegmentedButton.styleFrom(
                          selectedBackgroundColor: colors.accent,
                          selectedForegroundColor: Colors.white,
                          foregroundColor: colors.textSecondary,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String _formatDuration(int seconds) => seconds < 60
      ? '${seconds}s'
      : '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';
}
