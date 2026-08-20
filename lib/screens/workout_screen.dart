import 'package:flutter/material.dart';

import '../data/entitlement_store.dart';
import '../data/exercise_library.dart';
import '../data/workout_session_store.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_palette.dart';
import '../widgets/workout/add_exercise_sheet.dart';
import '../widgets/workout/empty_workout_state.dart';
import '../widgets/workout/exercise_session_card.dart';
import '../widgets/workout/rest_duration_sheet.dart';
import '../widgets/workout/workout_timer_card.dart';

class WorkoutScreen extends StatefulWidget {
  final WorkoutSessionStore store;
  final EntitlementStore entitlementStore;
  final VoidCallback onFinished;

  const WorkoutScreen({
    super.key,
    required this.store,
    required this.entitlementStore,
    required this.onFinished,
  });

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  String selectedMuscle = ExerciseLibrary.muscleGroups.first;

  void _addExercise() {
    showAddExerciseSheet(
      context: context,
      store: widget.store,
      initialMuscle: selectedMuscle,
      onExerciseSelected: (exercise) {
        setState(() => selectedMuscle = exercise.muscleGroup);
        widget.store.addExercise(exercise);
      },
    );
  }

  void _openRestSettings() {
    showRestDurationSheet(context: context, store: widget.store);
  }

  Future<void> _finishWorkout() async {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.card,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(l10n.finishWorkoutDialogTitle, style: const TextStyle(fontWeight: FontWeight.w900)),
        content: Text(
          l10n.finishWorkoutDialogContent,
          style: TextStyle(color: colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel, style: TextStyle(color: colors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.accent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(l10n.finish, style: const TextStyle(fontWeight: FontWeight.w800)),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    widget.store.finishWorkout();
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.workoutSavedMessage)),
    );
    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 12, 15),
            child: Row(
              children: [
                if (Navigator.canPop(context))
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.workoutScreenEyebrow,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                          color: colors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.workoutScreenTitle,
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _openRestSettings,
                  icon: const Icon(Icons.more_vert),
                  tooltip: l10n.restTimerSettingsTooltip,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListenableBuilder(
              listenable: Listenable.merge([widget.store, widget.entitlementStore]),
              builder: (context, _) {
                if (widget.store.exercises.isEmpty) {
                  return EmptyWorkoutState(onAddExercise: _addExercise);
                }

                return ListView(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
                  children: [
                    WorkoutTimerCard(store: widget.store),
                    const SizedBox(height: 20),
                    ...widget.store.exercises.map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: ExerciseSessionCard(
                          store: widget.store,
                          entitlementStore: widget.entitlementStore,
                          entry: entry,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    OutlinedButton.icon(
                      onPressed: _addExercise,
                      icon: const Icon(Icons.add),
                      label: Text(
                        l10n.addExerciseButton,
                        style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.8),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colors.textPrimary,
                        side: BorderSide(color: colors.cardBorder),
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: _finishWorkout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.accent,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 54),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        l10n.finishWorkoutButton,
                        style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
