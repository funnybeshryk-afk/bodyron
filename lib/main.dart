import 'package:flutter/material.dart';

import 'data/locale_store.dart';
import 'data/theme_store.dart';
import 'data/training_program_store.dart';
import 'database/database_helper.dart';
import 'l10n/app_localizations.dart';
import 'screens/main_screen.dart';
import 'screens/onboarding_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Открывает (и при необходимости создаёт/мигрирует) БД до первого кадра,
  // чтобы стораджи могли грузить сохранённые данные сразу после старта.
  await DatabaseHelper.instance.database;

  // Грузим сохранённый выбор темы и языка до первого кадра, чтобы не
  // мелькнуть системными значениями перед тем, как применятся сохранённые.
  final themeStore = ThemeStore();
  await themeStore.loadFromDatabase();
  final localeStore = LocaleStore();
  await localeStore.loadFromDatabase();

  // Онбординг показывается только реальным новым пользователям — у кого
  // нет ни одной записи в истории тренировок И онбординг ещё не пройден.
  // У существующих пользователей (уже с историей, обновившихся со старой
  // версии) он молча помечается пройденным здесь же, без показа UI —
  // Главный экран сам предложит настроить программу по желанию.
  final trainingProgramStore = TrainingProgramStore();
  await trainingProgramStore.loadFromDatabase();

  var showOnboarding = false;
  if (!trainingProgramStore.onboardingCompleted) {
    final hasHistory = (await DatabaseHelper.instance.getWorkoutHistory()).isNotEmpty;
    if (hasHistory) {
      await trainingProgramStore.markOnboardingCompletedWithoutProgram();
    } else {
      showOnboarding = true;
    }
  }

  runApp(BodyronApp(
    themeStore: themeStore,
    localeStore: localeStore,
    trainingProgramStore: trainingProgramStore,
    showOnboarding: showOnboarding,
  ));
}

class BodyronApp extends StatelessWidget {
  final ThemeStore themeStore;
  final LocaleStore localeStore;
  final TrainingProgramStore trainingProgramStore;
  final bool showOnboarding;

  const BodyronApp({
    super.key,
    required this.themeStore,
    required this.localeStore,
    required this.trainingProgramStore,
    required this.showOnboarding,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([themeStore, localeStore]),
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BODYRON',
          theme: AppTheme.light,
          darkTheme: AppTheme.dark,
          themeMode: themeStore.mode,
          locale: localeStore.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: _RootScreen(
            themeStore: themeStore,
            localeStore: localeStore,
            trainingProgramStore: trainingProgramStore,
            showOnboardingInitially: showOnboarding,
          ),
        );
      },
    );
  }
}

/// Переключает между обязательным онбордингом и обычным [MainScreen] без
/// Navigator — на этом уровне (значение `home:` внутри [MaterialApp.build])
/// ещё нет предка-Navigator, чтобы им пользоваться (см. баг, пойманный на
/// реальном устройстве: `Navigator.of(context)` в [BodyronApp.build] брал
/// context ИЗ-ПОД [MaterialApp], а не из-под его собственного Navigator).
/// Простой локальный [setState] и для этого разового переключения, и для
/// того, что нужно передать дальше в [MainScreen] (сразу открыть первую
/// тренировку), надёжнее.
class _RootScreen extends StatefulWidget {
  final ThemeStore themeStore;
  final LocaleStore localeStore;
  final TrainingProgramStore trainingProgramStore;
  final bool showOnboardingInitially;

  const _RootScreen({
    required this.themeStore,
    required this.localeStore,
    required this.trainingProgramStore,
    required this.showOnboardingInitially,
  });

  @override
  State<_RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<_RootScreen> {
  late bool _showOnboarding = widget.showOnboardingInitially;

  @override
  Widget build(BuildContext context) {
    if (_showOnboarding) {
      return OnboardingScreen(
        store: widget.trainingProgramStore,
        onFinished: () => setState(() => _showOnboarding = false),
      );
    }

    return MainScreen(
      themeStore: widget.themeStore,
      localeStore: widget.localeStore,
      trainingProgramStore: widget.trainingProgramStore,
      startWorkoutOnLaunch: widget.showOnboardingInitially,
    );
  }
}
