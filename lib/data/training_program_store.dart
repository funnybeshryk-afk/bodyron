import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../database/database_helper.dart';
import '../models/training_program.dart';
import 'program_generator.dart';

const String _activeProgramSettingKey = 'active_program_json';
const String _onboardingCompletedSettingKey = 'onboarding_completed';
const String _onboardingGoalSettingKey = 'onboarding_goal';
const String _onboardingFrequencySettingKey = 'onboarding_frequency';
const String _onboardingLevelSettingKey = 'onboarding_level';

/// Активная автосгенерированная программа тренировок и статус онбординга.
/// Персистится в уже существующей таблице `app_settings` (см.
/// [DatabaseHelper]) — программа целиком как один JSON-блок под
/// [_activeProgramSettingKey], без изменений схемы БД. Живёт на уровне
/// [main] (как [ThemeStore]/[LocaleStore]) — и до, и после [MainScreen],
/// потому что решение "показывать онбординг или нет" принимается ещё до
/// того, как [MainScreen] существует.
class TrainingProgramStore extends ChangeNotifier {
  TrainingProgram? activeProgram;
  bool onboardingCompleted = false;
  String? goal;
  int? frequency;
  String? level;
  bool isLoaded = false;

  Future<void> loadFromDatabase() async {
    final db = DatabaseHelper.instance;

    final storedProgram = await db.getSetting(_activeProgramSettingKey);
    final storedCompleted = await db.getSetting(_onboardingCompletedSettingKey);
    final storedGoal = await db.getSetting(_onboardingGoalSettingKey);
    final storedFrequency = await db.getSetting(_onboardingFrequencySettingKey);
    final storedLevel = await db.getSetting(_onboardingLevelSettingKey);

    activeProgram = storedProgram == null
        ? null
        : TrainingProgram.fromJson(jsonDecode(storedProgram) as Map<String, Object?>);
    onboardingCompleted = storedCompleted == '1';
    goal = storedGoal;
    frequency = storedFrequency == null ? null : int.tryParse(storedFrequency);
    level = storedLevel;

    isLoaded = true;
    notifyListeners();
  }

  /// Завершает онбординг с реальными ответами пользователя — генерирует
  /// программу ([ProgramGenerator.generate]) и персистит всё разом.
  /// Используется и обязательным гейтом для новых пользователей, и
  /// добровольным входом "Настроить программу" для существующих (см.
  /// [applyProgram] — тот же путь персистенции, но без квиза, для готовых
  /// PRO-программ из [CuratedPrograms]).
  Future<void> completeOnboarding({
    required String goal,
    required int frequency,
    required String level,
  }) async {
    final program = ProgramGenerator.generate(goal: goal, frequency: frequency, level: level);
    await applyProgram(program);
  }

  /// Делает [program] активным — та же персистенция, что и после квиза
  /// онбординга, просто без генерации: используется для готовых PRO-
  /// программ, выбранных на экране "Изменить программу" (см.
  /// [CuratedPrograms]). После этого Home и Тренировка работают с ней как с
  /// любой другой активной программой.
  Future<void> applyProgram(TrainingProgram program) async {
    final db = DatabaseHelper.instance;

    goal = program.goal;
    frequency = program.frequency;
    level = program.level;
    activeProgram = program;
    onboardingCompleted = true;

    await db.setSetting(_activeProgramSettingKey, jsonEncode(program.toJson()));
    await db.setSetting(_onboardingGoalSettingKey, program.goal);
    await db.setSetting(_onboardingFrequencySettingKey, program.frequency.toString());
    await db.setSetting(_onboardingLevelSettingKey, program.level);
    await db.setSetting(_onboardingCompletedSettingKey, '1');

    notifyListeners();
  }

  /// Существующий пользователь с историей тренировок — онбординг помечается
  /// пройденным без показа UI и без навязанной программы (см. Phase 1 ТЗ:
  /// принудительный онбординг не должен показываться тем, у кого уже есть
  /// история).
  Future<void> markOnboardingCompletedWithoutProgram() async {
    onboardingCompleted = true;
    await DatabaseHelper.instance.setSetting(_onboardingCompletedSettingKey, '1');
    notifyListeners();
  }

  TrainingProgramDay? todayDay() {
    final program = activeProgram;
    if (program == null) return null;
    return program.dayFor(DateTime.now().weekday);
  }

  TrainingProgramDay? nextTrainingDay() {
    final program = activeProgram;
    if (program == null) return null;
    final today = program.dayFor(DateTime.now().weekday);
    if (!today.isRestDay) return today;
    return program.nextTrainingDayAfter(DateTime.now().weekday);
  }
}
