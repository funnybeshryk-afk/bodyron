import 'package:flutter/material.dart';

import '../data/entitlement_store.dart';
import '../data/exercise_library.dart';
import '../data/workout_session_store.dart';
import '../l10n/app_localizations.dart';
import '../l10n/exercise_content_l10n.dart';
import '../theme/app_palette.dart';
import '../widgets/workout/add_exercise_sheet.dart';
import '../widgets/workout/empty_workout_state.dart';
import '../widgets/workout/exercise_session_card.dart';
import '../widgets/workout/rest_duration_sheet.dart';
import '../widgets/workout/rest_timer_focus_card.dart';
import '../widgets/workout/workout_timer_card.dart';
import 'workout_completion_screen.dart';

/// Пошаговый режим Тренировки (Phase 1 ТЗ, п.4) — фокус на одном
/// упражнении за раз, а не список всех сразу. Открывается либо с уже
/// предзаполненными упражнениями программы (см.
/// [WorkoutSessionStore.applyProgramDay] — вызывается на Home, до перехода
/// на эту вкладку), либо пустой, с ручным добавлением упражнений — в обоих
/// случаях UI ниже одинаковый, так как это чисто отображение
/// [WorkoutSessionStore.exercises] с фокусом на
/// [WorkoutSessionStore.currentExerciseIndex].
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

    final summary = widget.store.finishWorkout();
    if (!mounted) return;

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => WorkoutCompletionScreen(
          summary: summary,
          onDone: () {
            Navigator.of(context).pop();
            widget.onFinished();
          },
        ),
      ),
    );
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
                return _buildFocusMode(context, l10n, colors);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFocusMode(BuildContext context, AppLocalizations l10n, AppPalette colors) {
    final store = widget.store;
    final total = store.exercises.length;
    final index = store.currentExerciseIndex >= total ? total - 1 : store.currentExerciseIndex;
    final entry = store.exercises[index];
    final allSetsDone = entry.sets.isNotEmpty && entry.sets.every((s) => s.completed);
    final isLastExercise = index == total - 1;

    Widget content;
    if (store.isResting) {
      content = RestTimerFocusCard(store: store);
    } else if (allSetsDone && isLastExercise) {
      content = _AllExercisesDoneCard(onFinish: _finishWorkout);
    } else if (allSetsDone) {
      content = _ExerciseDoneCard(
        exerciseName: entry.exercise.displayName(context),
        onNext: store.advanceToNextExercise,
      );
    } else {
      content = ExerciseSessionCard(
        store: store,
        entitlementStore: widget.entitlementStore,
        entry: entry,
      );
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
      children: [
        WorkoutTimerCard(store: store),
        const SizedBox(height: 16),
        Text(
          l10n.workoutExerciseProgressLabel(index + 1, total),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
            color: colors.textMuted,
          ),
        ),
        const SizedBox(height: 8),
        content,
        const SizedBox(height: 16),
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
        if (!(allSetsDone && isLastExercise)) ...[
          const SizedBox(height: 10),
          Center(
            child: TextButton(
              onPressed: _finishWorkout,
              child: Text(
                l10n.finishWorkoutButton,
                style: TextStyle(fontWeight: FontWeight.w800, color: colors.textSecondary),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _ExerciseDoneCard extends StatelessWidget {
  final String exerciseName;
  final VoidCallback onNext;

  const _ExerciseDoneCard({required this.exerciseName, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        children: [
          Icon(Icons.check_circle, color: colors.success, size: 36),
          const SizedBox(height: 12),
          Text(
            '$exerciseName ✓',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.workoutNextExerciseButton,
                    style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.8),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AllExercisesDoneCard extends StatelessWidget {
  final VoidCallback onFinish;

  const _AllExercisesDoneCard({required this.onFinish});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        children: [
          Icon(Icons.celebration, color: colors.accent, size: 36),
          const SizedBox(height: 12),
          Text(
            l10n.workoutAllDoneTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: onFinish,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                l10n.finishWorkoutButton,
                style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
