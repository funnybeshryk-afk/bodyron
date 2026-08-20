import 'package:flutter/material.dart';

import '../data/body_weight_store.dart';
import '../data/entitlement_store.dart';
import '../data/workout_session_store.dart';
import '../l10n/app_localizations.dart';
import '../widgets/progress/body_weight_chart.dart';
import '../widgets/progress/personal_records_section.dart';
import '../widgets/progress/progress_empty_state.dart';
import '../widgets/progress/recent_workouts_section.dart';
import '../widgets/progress/strength_progress_section.dart';
import '../widgets/progress/weekly_volume_chart.dart';
import '../widgets/section_title.dart';

class ProgressScreen extends StatelessWidget {
  final WorkoutSessionStore store;
  final BodyWeightStore bodyWeightStore;
  final EntitlementStore entitlementStore;

  const ProgressScreen({
    super.key,
    required this.store,
    required this.bodyWeightStore,
    required this.entitlementStore,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: ListenableBuilder(
        listenable: Listenable.merge([store, entitlementStore]),
        builder: (context, _) {
          if (store.history.length < 2) {
            return const ProgressEmptyState();
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.progressScreenTitle,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 28),
                BodyWeightChart(store: bodyWeightStore),
                const SizedBox(height: 20),
                WeeklyVolumeChart(store: store),
                const SizedBox(height: 20),
                StrengthProgressSection(store: store, entitlementStore: entitlementStore),
                const SizedBox(height: 28),
                SectionTitle(title: l10n.progressPersonalRecordsTitle),
                const SizedBox(height: 14),
                PersonalRecordsSection(store: store),
                const SizedBox(height: 28),
                SectionTitle(title: l10n.progressRecentWorkoutsTitle),
                const SizedBox(height: 14),
                RecentWorkoutsSection(store: store),
              ],
            ),
          );
        },
      ),
    );
  }
}
