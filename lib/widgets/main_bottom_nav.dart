import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_palette.dart';

class MainBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  const MainBottomNav({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return NavigationBar(
      backgroundColor: colors.navBackground,
      selectedIndex: currentIndex,
      indicatorColor: colors.accent.withValues(alpha: 0.15),
      onDestinationSelected: onDestinationSelected,
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home_rounded),
          label: l10n.navHome,
        ),
        NavigationDestination(
          icon: const Icon(Icons.fitness_center_outlined),
          selectedIcon: const Icon(Icons.fitness_center),
          label: l10n.navWorkout,
        ),
        NavigationDestination(
          icon: const Icon(Icons.show_chart_outlined),
          selectedIcon: const Icon(Icons.show_chart),
          label: l10n.navProgress,
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline),
          selectedIcon: const Icon(Icons.person),
          label: l10n.navProfile,
        ),
      ],
    );
  }
}
