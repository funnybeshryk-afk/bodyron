import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../l10n/exercise_content_l10n.dart';
import '../models/workout_finish_summary.dart';
import '../theme/app_palette.dart';

/// Экран "Тренировка завершена" из Phase 1 ТЗ (п.5) — показывается сразу
/// после [WorkoutSessionStore.finishWorkout] вместо старого SnackBar.
/// Строго read-only отображение уже посчитанного [WorkoutFinishSummary] —
/// история и подходы для неё уже пересчитаны и сохранены до открытия этого
/// экрана.
class WorkoutCompletionScreen extends StatelessWidget {
  final WorkoutFinishSummary summary;
  final VoidCallback onDone;

  const WorkoutCompletionScreen({
    super.key,
    required this.summary,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final workout = summary.workout;
    final prResults = summary.exerciseResults.where((e) => e.isPr).toList();
    final improvement = summary.biggestImprovement;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.completionTitle,
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.completionSubtitle,
                style: TextStyle(fontSize: 15, color: colors.textMuted),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  _StatTile(
                    label: l10n.completionDurationLabel,
                    value: l10n.minutesShort(workout.durationMinutes),
                  ),
                  _StatTile(
                    label: l10n.completionVolumeLabel,
                    value: l10n.weightKg(workout.volumeKg.toStringAsFixed(0)),
                  ),
                  _StatTile(
                    label: l10n.completionSetsLabel,
                    value: '${workout.exercises.fold<int>(0, (sum, e) => sum + e.sets.length)}',
                  ),
                ],
              ),
              if (prResults.isNotEmpty) ...[
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: colors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: colors.accent.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.completionNewPrBadge,
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                      ),
                      for (final pr in prResults)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            '${pr.exerciseName.displayExerciseName(context)} — '
                            '${l10n.weightByReps(_formatWeight(pr.bestSet.weight), pr.bestSet.reps)}',
                            style: TextStyle(fontSize: 13, color: colors.textSecondary),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
              if (improvement != null) ...[
                const SizedBox(height: 14),
                Text(
                  l10n.completionMotivationLine(
                    improvement.exerciseName.displayExerciseName(context),
                    _formatWeight(improvement.weightDeltaKg!),
                  ),
                  style: TextStyle(fontSize: 13.5, color: colors.textSecondary, height: 1.4),
                ),
              ],
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    for (final result in summary.exerciseResults)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                result.exerciseName.displayExerciseName(context),
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                            ),
                            if (result.isPr) ...[
                              Icon(Icons.emoji_events, size: 14, color: colors.accent),
                              const SizedBox(width: 4),
                            ],
                            Text(
                              l10n.weightByReps(
                                _formatWeight(result.bestSet.weight),
                                result.bestSet.reps,
                              ),
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: colors.textMuted),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onDone,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.accent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    l10n.completionDoneButton,
                    style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;

  const _StatTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
        ],
      ),
    );
  }
}

String _formatWeight(double value) =>
    value % 1 == 0 ? value.toStringAsFixed(0) : value.toStringAsFixed(2);
