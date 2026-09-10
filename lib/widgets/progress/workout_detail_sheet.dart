import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../l10n/exercise_content_l10n.dart';
import '../../l10n/workout_name_l10n.dart';
import '../../models/completed_workout.dart';
import '../../theme/app_palette.dart';

/// Bottom sheet с деталями завершённой тренировки: упражнения и подходы,
/// только просмотр.
Future<void> showWorkoutDetailSheet({
  required BuildContext context,
  required CompletedWorkout workout,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: context.colors.card,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => _WorkoutDetailContent(workout: workout),
  );
}

class _WorkoutDetailContent extends StatelessWidget {
  final CompletedWorkout workout;

  const _WorkoutDetailContent({required this.workout});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.progressWorkoutDetailTitle,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.6,
                            color: colors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          workout.name.displayWorkoutName(context),
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  _MetricChip(
                    icon: Icons.timer_outlined,
                    value: l10n.minutesShort(workout.durationMinutes),
                  ),
                  const SizedBox(width: 10),
                  _MetricChip(
                    icon: Icons.bar_chart_rounded,
                    value: l10n.weightKg(workout.volumeKg.toStringAsFixed(0)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              for (final exercise in workout.exercises)
                Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colors.cardAlt,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.exerciseName.displayExerciseName(context),
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 10),
                        for (var i = 0; i < exercise.sets.length; i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: Text(
                                    l10n.progressSetLabel(i + 1),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: colors.textMuted,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    l10n.weightByReps(
                                      exercise.sets[i].weight.toStringAsFixed(1),
                                      exercise.sets[i].reps,
                                    ),
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                                  ),
                                ),
                                if (exercise.sets[i].toFailure)
                                  Icon(Icons.whatshot, size: 14, color: colors.accent)
                                else if (exercise.sets[i].rpe != null)
                                  Text(
                                    'RPE ${exercise.sets[i].rpe!.toStringAsFixed(exercise.sets[i].rpe! % 1 == 0 ? 0 : 1)}',
                                    style: TextStyle(fontSize: 11, color: colors.textMuted),
                                  ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _MetricChip extends StatelessWidget {
  final IconData icon;
  final String value;

  const _MetricChip({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: colors.cardAlt,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colors.textSecondary),
          const SizedBox(width: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
