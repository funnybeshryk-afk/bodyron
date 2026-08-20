import 'package:flutter/material.dart';

import '../data/body_weight_store.dart';
import '../data/dashboard_mock_data.dart';
import '../data/workout_session_store.dart';
import '../l10n/app_localizations.dart';
import '../l10n/relative_date_l10n.dart';
import '../widgets/dashboard/body_weight_card.dart';
import '../widgets/dashboard/dashboard_header.dart';
import '../widgets/dashboard/last_workout_card.dart';
import '../widgets/dashboard/start_workout_card.dart';
import '../widgets/dashboard/today_workout_card.dart';
import '../widgets/dashboard/weekly_progress_card.dart';
import '../widgets/profile/add_body_weight_dialog.dart';
import '../widgets/section_title.dart';

class DashboardScreen extends StatelessWidget {
  final WorkoutSessionStore store;
  final BodyWeightStore bodyWeightStore;
  final VoidCallback onStartWorkout;

  const DashboardScreen({
    super.key,
    required this.store,
    required this.bodyWeightStore,
    required this.onStartWorkout,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final lastCompleted = store.history.isEmpty ? null : store.history.last;
        final lastWorkout = lastCompleted == null
            ? DashboardMockData.lastWorkout
            : LastWorkoutSummary(
                name: lastCompleted.name,
                whenLabel: lastCompleted.date.relativeLabel(context),
                durationMinutes: lastCompleted.durationMinutes,
                volumeKg: lastCompleted.volumeKg,
                prCount: lastCompleted.prCount,
              );

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DashboardHeader(),
                const SizedBox(height: 8),
                StartWorkoutCard(onStart: onStartWorkout),
                const SizedBox(height: 8),
                SectionTitle(title: l10n.todayWorkoutLabel),
                const SizedBox(height: 6),
                const TodayWorkoutCard(
                  workout: DashboardMockData.todayWorkout,
                ),
                const SizedBox(height: 8),
                SectionTitle(title: l10n.sectionLastWorkout),
                const SizedBox(height: 6),
                LastWorkoutCard(workout: lastWorkout),
                const SizedBox(height: 8),
                SectionTitle(title: l10n.sectionBodyWeight),
                const SizedBox(height: 6),
                BodyWeightCard(
                  store: bodyWeightStore,
                  onAddEntry: () => showAddBodyWeightDialog(
                    context: context,
                    store: bodyWeightStore,
                  ),
                ),
                const SizedBox(height: 8),
                SectionTitle(title: l10n.weeklyProgressLabel),
                const SizedBox(height: 6),
                const WeeklyProgressCard(
                  stat: DashboardMockData.weeklyProgress,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
