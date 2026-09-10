import 'package:flutter/material.dart';

import '../data/program_generator.dart';
import '../data/training_program_store.dart';
import '../l10n/app_localizations.dart';
import '../l10n/muscle_group_l10n.dart';
import '../l10n/weekday_l10n.dart';
import '../l10n/workout_name_l10n.dart';
import '../theme/app_palette.dart';

/// Онбординг из Фазы 1 BODYRON 2.0 — 5 экранов: приветствие → цель →
/// частота → уровень → готовая программа. Используется двумя способами
/// (см. [main.dart] и [MainScreen._openProgramSetup]):
/// - обязательный гейт для новых пользователей без истории тренировок;
/// - добровольный вход "Настроить программу" для всех остальных.
/// В обоих случаях по завершении генерирует и персистит программу через
/// [TrainingProgramStore.completeOnboarding], затем вызывает [onFinished] —
/// что делать дальше (открыть Тренировку, закрыть экран) решает вызывающий.
class OnboardingScreen extends StatefulWidget {
  final TrainingProgramStore store;
  final VoidCallback onFinished;

  const OnboardingScreen({
    super.key,
    required this.store,
    required this.onFinished,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _stepCount = 5;

  int _step = 0;
  String? _goal;
  int? _frequency;
  String? _level;

  void _goTo(int step) => setState(() => _step = step);

  Future<void> _finish() async {
    await widget.store.completeOnboarding(
      goal: _goal!,
      frequency: _frequency!,
      level: _level!,
    );
    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 20, 4),
              child: Row(
                children: [
                  SizedBox(
                    width: 44,
                    child: _step > 0
                        ? IconButton(
                            onPressed: () => _goTo(_step - 1),
                            icon: const Icon(Icons.arrow_back),
                          )
                        : null,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        for (var i = 0; i < _stepCount; i++)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3),
                              child: Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  color: i <= _step ? colors.accent : colors.cardBorder,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 44),
                ],
              ),
            ),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: KeyedSubtree(
                  key: ValueKey(_step),
                  child: switch (_step) {
                    0 => _WelcomeStep(onStart: () => _goTo(1)),
                    1 => _GoalStep(
                        selected: _goal,
                        onSelect: (goal) => setState(() => _goal = goal),
                        onContinue: () => _goTo(2),
                      ),
                    2 => _FrequencyStep(
                        selected: _frequency,
                        onSelect: (freq) => setState(() => _frequency = freq),
                        onContinue: () => _goTo(3),
                      ),
                    3 => _LevelStep(
                        selected: _level,
                        onSelect: (level) => setState(() => _level = level),
                        onContinue: () => _goTo(4),
                      ),
                    _ => _ReadyStep(
                        goal: _goal!,
                        frequency: _frequency!,
                        level: _level!,
                        onStart: _finish,
                      ),
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomeStep extends StatelessWidget {
  final VoidCallback onStart;

  const _WelcomeStep({required this.onStart});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 10, 28, 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              color: colors.accent.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.fitness_center, size: 46, color: colors.accent),
          ),
          const SizedBox(height: 28),
          Text(
            l10n.onboardingWelcomeTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 12),
          Text(
            l10n.onboardingWelcomeSubtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, color: colors.textMuted, height: 1.4),
          ),
          const Spacer(flex: 2),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onStart,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                l10n.onboardingStartButton,
                style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GoalStep extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onSelect;
  final VoidCallback onContinue;

  const _GoalStep({
    required this.selected,
    required this.onSelect,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final options = [
      ('💪', ProgramGenerator.goalMuscleGain, l10n.onboardingGoalMuscleGain),
      ('🏋️', ProgramGenerator.goalStrength, l10n.onboardingGoalStrength),
      ('🔥', ProgramGenerator.goalWeightLoss, l10n.onboardingGoalWeightLoss),
      ('⚡', ProgramGenerator.goalMaintenance, l10n.onboardingGoalMaintenance),
    ];

    return _OptionStep(
      title: l10n.onboardingGoalTitle,
      continueLabel: l10n.onboardingContinueButton,
      canContinue: selected != null,
      onContinue: onContinue,
      children: [
        for (final (emoji, value, label) in options)
          _OptionCard(
            emoji: emoji,
            label: label,
            selected: selected == value,
            onTap: () => onSelect(value),
          ),
      ],
    );
  }
}

class _FrequencyStep extends StatelessWidget {
  final int? selected;
  final ValueChanged<int> onSelect;
  final VoidCallback onContinue;

  const _FrequencyStep({
    required this.selected,
    required this.onSelect,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return _OptionStep(
      title: l10n.onboardingFrequencyTitle,
      continueLabel: l10n.onboardingContinueButton,
      canContinue: selected != null,
      onContinue: onContinue,
      children: [
        for (final freq in const [2, 3, 4, 5])
          _OptionCard(
            label: l10n.onboardingFrequencyOptionLabel(freq),
            selected: selected == freq,
            onTap: () => onSelect(freq),
          ),
      ],
    );
  }
}

class _LevelStep extends StatelessWidget {
  final String? selected;
  final ValueChanged<String> onSelect;
  final VoidCallback onContinue;

  const _LevelStep({
    required this.selected,
    required this.onSelect,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final options = [
      ('🌱', ProgramGenerator.levelBeginner, l10n.onboardingLevelBeginner, l10n.onboardingLevelBeginnerHint),
      (
        '🏋️',
        ProgramGenerator.levelIntermediate,
        l10n.onboardingLevelIntermediate,
        l10n.onboardingLevelIntermediateHint,
      ),
      ('🔥', ProgramGenerator.levelAdvanced, l10n.onboardingLevelAdvanced, l10n.onboardingLevelAdvancedHint),
    ];

    return _OptionStep(
      title: l10n.onboardingLevelTitle,
      continueLabel: l10n.onboardingContinueButton,
      canContinue: selected != null,
      onContinue: onContinue,
      children: [
        for (final (emoji, value, label, hint) in options)
          _OptionCard(
            emoji: emoji,
            label: label,
            hint: hint,
            selected: selected == value,
            onTap: () => onSelect(value),
          ),
      ],
    );
  }
}

class _ReadyStep extends StatelessWidget {
  final String goal;
  final int frequency;
  final String level;
  final VoidCallback onStart;

  const _ReadyStep({
    required this.goal,
    required this.frequency,
    required this.level,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final program = ProgramGenerator.generate(goal: goal, frequency: frequency, level: level);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.onboardingReadyTitle,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                for (final day in program.days)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: day.isRestDay ? Colors.transparent : colors.card,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: day.isRestDay ? Colors.transparent : colors.cardBorder,
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 108,
                            child: Text(
                              day.dayOfWeek.weekdayFullName(context),
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w800,
                                color: day.isRestDay ? colors.textFaint : colors.textSecondary,
                              ),
                            ),
                          ),
                          Expanded(
                            child: day.isRestDay
                                ? Text(
                                    l10n.onboardingReadyRestDayLabel,
                                    style: TextStyle(fontSize: 13, color: colors.textFaint),
                                  )
                                : Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        day.dayName.displayWorkoutName(context),
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        day.muscleGroups.map((m) => m.display(context)).join(' • '),
                                        style: TextStyle(fontSize: 11.5, color: colors.textMuted),
                                      ),
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onStart,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                l10n.onboardingReadyStartButton,
                style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Общий каркас для шагов "выбери одну карточку из списка" (цель, частота,
/// уровень) — заголовок, список [_OptionCard], кнопка "Продолжить"
/// активна только когда что-то выбрано.
class _OptionStep extends StatelessWidget {
  final String title;
  final String continueLabel;
  final bool canContinue;
  final VoidCallback onContinue;
  final List<Widget> children;

  const _OptionStep({
    required this.title,
    required this.continueLabel,
    required this.canContinue,
    required this.onContinue,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 20),
          Expanded(child: ListView(children: children)),
          const SizedBox(height: 6),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: canContinue ? onContinue : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.accent,
                disabledBackgroundColor: colors.cardAlt,
                foregroundColor: Colors.white,
                disabledForegroundColor: colors.textFaint,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(
                continueLabel,
                style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String? emoji;
  final String label;
  final String? hint;
  final bool selected;
  final VoidCallback onTap;

  const _OptionCard({
    this.emoji,
    required this.label,
    this.hint,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          decoration: BoxDecoration(
            color: selected ? colors.accent.withValues(alpha: 0.12) : colors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? colors.accent : colors.cardBorder,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              if (emoji != null) ...[
                Text(emoji!, style: const TextStyle(fontSize: 26)),
                const SizedBox(width: 14),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                    if (hint != null) ...[
                      const SizedBox(height: 2),
                      Text(hint!, style: TextStyle(fontSize: 12.5, color: colors.textMuted)),
                    ],
                  ],
                ),
              ),
              if (selected) Icon(Icons.check_circle, color: colors.accent),
            ],
          ),
        ),
      ),
    );
  }
}
