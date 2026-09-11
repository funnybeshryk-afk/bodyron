import 'package:flutter/material.dart';

import '../../data/training_program_store.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/exercise_content_l10n.dart';
import '../../l10n/muscle_group_l10n.dart';
import '../../l10n/weekday_l10n.dart';
import '../../l10n/workout_name_l10n.dart';
import '../../models/training_program.dart';
import '../../theme/app_palette.dart';

/// Главная карточка Home ("ТРЕНИРОВКА НА СЕГОДНЯ") — визуально самая
/// заметная на экране. Три реальных состояния на основе
/// [TrainingProgramStore] (не мок — см. Phase 1 ТЗ, это чинит старый баг
/// "кнопка не работает"): тренировочный день, день отдыха, нет программы.
class TodayWorkoutCard extends StatelessWidget {
  final TrainingProgramStore trainingProgramStore;
  final void Function(TrainingProgramDay day) onStartProgramDay;
  final VoidCallback onSetupProgram;

  const TodayWorkoutCard({
    super.key,
    required this.trainingProgramStore,
    required this.onStartProgramDay,
    required this.onSetupProgram,
  });

  @override
  Widget build(BuildContext context) {
    final program = trainingProgramStore.activeProgram;
    if (program == null) {
      return _NoProgramCard(onSetupProgram: onSetupProgram);
    }

    final today = trainingProgramStore.todayDay()!;
    if (!today.isRestDay) {
      return _TrainingDayCard(
        program: program,
        day: today,
        onStart: () => onStartProgramDay(today),
        onPickDifferentDay: onStartProgramDay,
      );
    }

    final nextDay = trainingProgramStore.nextTrainingDay();
    return _RestDayCard(
      nextDay: nextDay,
      onStartEarly: nextDay == null ? null : () => onStartProgramDay(nextDay),
    );
  }
}

int _estimateMinutes(TrainingProgramDay day) {
  final totalSets = day.exercises.fold<int>(0, (sum, e) => sum + e.targetSets);
  return ((totalSets * 3) / 5).round() * 5;
}

class _TrainingDayCard extends StatelessWidget {
  final TrainingProgram program;
  final TrainingProgramDay day;
  final VoidCallback onStart;
  final void Function(TrainingProgramDay day) onPickDifferentDay;

  const _TrainingDayCard({
    required this.program,
    required this.day,
    required this.onStart,
    required this.onPickDifferentDay,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [colors.accent, colors.accentDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.todayWorkoutLabel.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            day.dayName.displayWorkoutName(context),
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.todayWorkoutSummary(
              day.muscleGroups.map((m) => m.display(context)).join(' • '),
              day.exercises.length,
              _estimateMinutes(day),
            ),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: onStart,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.todayWorkoutStartButton,
                    style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          Center(
            child: TextButton(
              onPressed: () => _showChangeWorkoutSheet(
                context: context,
                program: program,
                currentDay: day,
                onSelect: onPickDifferentDay,
              ),
              child: Text(
                l10n.todayWorkoutChangeButton,
                style: const TextStyle(fontWeight: FontWeight.w700, color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RestDayCard extends StatelessWidget {
  final TrainingProgramDay? nextDay;
  final VoidCallback? onStartEarly;

  const _RestDayCard({required this.nextDay, required this.onStartEarly});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final next = nextDay;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.card,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.cardBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.restDayTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.restDaySubtitle,
            style: TextStyle(fontSize: 13, color: colors.textMuted),
          ),
          if (next != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: colors.cardAlt,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.restDayNextWorkoutLabel.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.6,
                            color: colors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${next.dayOfWeek.weekdayFullName(context)} · ${next.dayName.displayWorkoutName(context)}',
                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          next.muscleGroups.map((m) => m.display(context)).join(' • '),
                          style: TextStyle(fontSize: 12, color: colors.textMuted),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _showDayPreviewSheet(context, next),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colors.accent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: Text(
                  l10n.restDayViewWorkoutButton,
                  style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.8),
                ),
              ),
            ),
            if (onStartEarly != null) ...[
              const SizedBox(height: 8),
              Center(
                child: TextButton(
                  onPressed: onStartEarly,
                  child: Text(
                    l10n.restDayStartEarlyButton,
                    style: TextStyle(fontWeight: FontWeight.w700, color: colors.textSecondary),
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}

/// Состояние "нет активной программы" — большинство реальных пользователей
/// сегодня (уже есть история, но программу никогда не настраивали) видят
/// именно это. Должно быть не менее заметным, чем [_TrainingDayCard] —
/// иначе, как показало реальное тестирование, его просто не находят.
class _NoProgramCard extends StatelessWidget {
  final VoidCallback onSetupProgram;

  const _NoProgramCard({required this.onSetupProgram});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [colors.accent, colors.accentDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.calendar_month_outlined, color: Colors.white, size: 26),
          const SizedBox(height: 10),
          Text(
            l10n.noProgramTitle,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.noProgramSubtitle,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: onSetupProgram,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l10n.noProgramSetupButton,
                    style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.6),
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

/// "Выбрать другую тренировку" на карточке тренировочного дня — точечная
/// разовая подмена дня программы для ЭТОЙ сессии (см. Phase 1
/// follow-up ТЗ): список всех тренировочных дней активной программы,
/// выбор любого из них вызывает [onSelect] (тот же [onStartProgramDay],
/// что и обычная кнопка "НАЧАТЬ") — расписание на будущие дни/недели не
/// меняется, потому что [WorkoutSessionStore.applyProgramDay] не трогает
/// active_program_json, только текущую активную тренировку.
Future<void> _showChangeWorkoutSheet({
  required BuildContext context,
  required TrainingProgram program,
  required TrainingProgramDay currentDay,
  required void Function(TrainingProgramDay day) onSelect,
}) {
  final colors = context.colors;
  final trainingDays = program.days.where((d) => !d.isRestDay).toList();

  return showModalBottomSheet(
    context: context,
    backgroundColor: colors.card,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      final l10n = AppLocalizations.of(sheetContext)!;

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.changeWorkoutSheetTitle,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 16),
              for (final day in trainingDays)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _DayOptionTile(
                    day: day,
                    isToday: day.dayOfWeek == currentDay.dayOfWeek,
                    onTap: () {
                      Navigator.pop(sheetContext);
                      onSelect(day);
                    },
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

class _DayOptionTile extends StatelessWidget {
  final TrainingProgramDay day;
  final bool isToday;
  final VoidCallback onTap;

  const _DayOptionTile({
    required this.day,
    required this.isToday,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: colors.cardAlt,
          borderRadius: BorderRadius.circular(16),
          border: isToday ? Border.all(color: colors.accent, width: 1.5) : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        day.dayOfWeek.weekdayFullName(context),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: colors.textMuted,
                        ),
                      ),
                      if (isToday) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(
                            color: colors.accent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            l10n.relativeToday,
                            style: const TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    day.dayName.displayWorkoutName(context),
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.todayWorkoutSummary(
                      day.muscleGroups.map((m) => m.display(context)).join(' • '),
                      day.exercises.length,
                      _estimateMinutes(day),
                    ),
                    style: TextStyle(fontSize: 12, color: colors.textMuted),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: colors.textMuted),
          ],
        ),
      ),
    );
  }
}

Future<void> _showDayPreviewSheet(BuildContext context, TrainingProgramDay day) {
  final colors = context.colors;

  return showModalBottomSheet(
    context: context,
    backgroundColor: colors.card,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day.dayName.displayWorkoutName(context),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 2),
            Text(
              day.muscleGroups.map((m) => m.display(context)).join(' • '),
              style: TextStyle(fontSize: 12, color: colors.textMuted),
            ),
            const SizedBox(height: 16),
            for (final exercise in day.exercises)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        exercise.exerciseName.displayExerciseName(context),
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      '${exercise.targetSets} × ${exercise.repsLow}-${exercise.repsHigh}',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: colors.textMuted),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ),
  );
}
