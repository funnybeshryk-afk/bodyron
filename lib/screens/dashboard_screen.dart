import 'package:flutter/material.dart';

import '../data/body_weight_store.dart';
import '../data/dashboard_mock_data.dart';
import '../data/training_program_store.dart';
import '../data/workout_session_store.dart';
import '../l10n/app_localizations.dart';
import '../l10n/dashboard_mock_l10n.dart';
import '../l10n/relative_date_l10n.dart';
import '../l10n/workout_name_l10n.dart';
import '../models/training_program.dart';
import '../widgets/dashboard/body_weight_card.dart';
import '../widgets/dashboard/dashboard_header.dart';
import '../widgets/dashboard/last_workout_card.dart';
import '../widgets/dashboard/learn_card.dart';
import '../widgets/dashboard/today_workout_card.dart';
import '../widgets/dashboard/weekly_progress_card.dart';
import '../widgets/profile/add_body_weight_dialog.dart';
import '../widgets/section_title.dart';
import 'training_articles_screen.dart';

class DashboardScreen extends StatelessWidget {
  final WorkoutSessionStore store;
  final BodyWeightStore bodyWeightStore;
  final TrainingProgramStore trainingProgramStore;
  final void Function(TrainingProgramDay day) onStartProgramDay;
  final VoidCallback onSetupProgram;

  const DashboardScreen({
    super.key,
    required this.store,
    required this.bodyWeightStore,
    required this.trainingProgramStore,
    required this.onStartProgramDay,
    required this.onSetupProgram,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListenableBuilder(
      listenable: Listenable.merge([store, trainingProgramStore]),
      builder: (context, _) {
        final lastCompleted = store.history.isEmpty ? null : store.history.last;
        // Плейсхолдеры "Yesterday"/"Push Day"/"Pull Day" не могут быть
        // частью const-моков — это вывод, а не данные, поэтому локализуются
        // здесь, где есть context.
        final lastWorkout = lastCompleted == null
            ? LastWorkoutSummary(
                name: DashboardMockData.lastWorkout.name.displayMockWorkoutName(context),
                whenLabel: l10n.relativeYesterday,
                durationMinutes: DashboardMockData.lastWorkout.durationMinutes,
                volumeKg: DashboardMockData.lastWorkout.volumeKg,
                prCount: DashboardMockData.lastWorkout.prCount,
              )
            : LastWorkoutSummary(
                name: lastCompleted.name.displayWorkoutName(context),
                whenLabel: lastCompleted.date.relativeLabel(context),
                durationMinutes: lastCompleted.durationMinutes,
                volumeKg: lastCompleted.volumeKg,
                prCount: lastCompleted.prCount,
              );
        // Реальные данные — завершённые тренировки на этой неделе из
        // истории, цель — частота активной программы (см.
        // WorkoutSessionStore.completedDaysInCurrentWeek). Без активной
        // программы цель по умолчанию — 3 тренировки в неделю.
        final completedDays = store.completedDaysInCurrentWeek();
        final weeklyProgress = WeeklyProgressStat(
          dayLabels: [
            l10n.weekdayMonShort,
            l10n.weekdayTueShort,
            l10n.weekdayWedShort,
            l10n.weekdayThuShort,
            l10n.weekdayFriShort,
            l10n.weekdaySatShort,
            l10n.weekdaySunShort,
          ],
          completedDays: completedDays,
          workoutsDone: completedDays.where((done) => done).length,
          workoutsGoal: trainingProgramStore.activeProgram?.frequency ?? 3,
        );

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DashboardHeader(),
                const SizedBox(height: 8),
                SectionTitle(title: l10n.todayWorkoutLabel),
                const SizedBox(height: 6),
                TodayWorkoutCard(
                  trainingProgramStore: trainingProgramStore,
                  onStartProgramDay: onStartProgramDay,
                  onSetupProgram: onSetupProgram,
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
                WeeklyProgressCard(stat: weeklyProgress),
                const SizedBox(height: 6),
                LearnCard(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TrainingArticlesScreen()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
