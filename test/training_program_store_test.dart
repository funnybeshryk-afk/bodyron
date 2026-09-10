import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:bodyron/data/program_generator.dart';
import 'package:bodyron/data/training_program_store.dart';
import 'package:bodyron/database/database_helper.dart';

/// Регрессионный тест на самую важную гарантию Phase 1 ТЗ: существующий
/// пользователь с историей тренировок не должен увидеть принудительный
/// онбординг, а [TrainingProgramStore.onboardingCompleted] должен молча
/// стать true без навязанной программы (см. `main.dart`, где именно эта
/// логика решает, показывать ли [OnboardingScreen]).
void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  Future<void> resetSettings() async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('app_settings');
  }

  test('markOnboardingCompletedWithoutProgram marks onboarding done without forcing a program', () async {
    await resetSettings();

    final store = TrainingProgramStore();
    await store.loadFromDatabase();
    expect(store.onboardingCompleted, isFalse);
    expect(store.activeProgram, isNull);

    await store.markOnboardingCompletedWithoutProgram();
    expect(store.onboardingCompleted, isTrue);
    expect(store.activeProgram, isNull);

    // Персистится, а не только в памяти — перезагружаем свежим инстансом,
    // как это происходит при реальном перезапуске приложения (см. main.dart).
    final reloaded = TrainingProgramStore();
    await reloaded.loadFromDatabase();
    expect(reloaded.onboardingCompleted, isTrue);
    expect(reloaded.activeProgram, isNull);
  });

  test('completeOnboarding generates and persists a real program', () async {
    await resetSettings();

    final store = TrainingProgramStore();
    await store.completeOnboarding(
      goal: ProgramGenerator.goalStrength,
      frequency: 3,
      level: ProgramGenerator.levelBeginner,
    );

    expect(store.onboardingCompleted, isTrue);
    expect(store.activeProgram, isNotNull);
    expect(store.activeProgram!.frequency, 3);
    expect(store.activeProgram!.days, hasLength(7));

    final reloaded = TrainingProgramStore();
    await reloaded.loadFromDatabase();
    expect(reloaded.onboardingCompleted, isTrue);
    expect(reloaded.activeProgram!.goal, ProgramGenerator.goalStrength);
    expect(reloaded.activeProgram!.level, ProgramGenerator.levelBeginner);
  });
}
