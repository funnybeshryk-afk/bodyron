import 'package:flutter/material.dart';

import '../data/body_weight_store.dart';
import '../data/entitlement_store.dart';
import '../data/locale_store.dart';
import '../data/purchase_service.dart';
import '../data/theme_store.dart';
import '../data/training_program_store.dart';
import '../data/user_profile_store.dart';
import '../data/workout_session_store.dart';
import '../models/training_program.dart';
import '../widgets/main_bottom_nav.dart';
import '../widgets/workout/rest_timer_banner.dart';
import 'dashboard_screen.dart';
import 'onboarding_screen.dart';
import 'profile_screen.dart';
import 'progress_screen.dart';
import 'workout_screen.dart';

class MainScreen extends StatefulWidget {
  final ThemeStore themeStore;
  final LocaleStore localeStore;
  final TrainingProgramStore trainingProgramStore;

  /// true только сразу после обязательного онбординга нового пользователя —
  /// открывает вкладку Тренировки с уже применённым первым днём программы
  /// (см. [_MainScreenState.initState]).
  final bool startWorkoutOnLaunch;

  const MainScreen({
    super.key,
    required this.themeStore,
    required this.localeStore,
    required this.trainingProgramStore,
    this.startWorkoutOnLaunch = false,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  final WorkoutSessionStore workoutStore = WorkoutSessionStore();
  final EntitlementStore entitlementStore = EntitlementStore();
  final BodyWeightStore bodyWeightStore = BodyWeightStore();
  final UserProfileStore userProfileStore = UserProfileStore();
  late final PurchaseService purchaseService = PurchaseService(entitlementStore: entitlementStore);

  late final pages = [
    DashboardScreen(
      store: workoutStore,
      bodyWeightStore: bodyWeightStore,
      trainingProgramStore: widget.trainingProgramStore,
      onStartProgramDay: _startProgramDay,
      onSetupProgram: _openProgramSetup,
    ),
    WorkoutScreen(
      store: workoutStore,
      entitlementStore: entitlementStore,
      onFinished: () => _goToTab(0),
    ),
    ProgressScreen(
      store: workoutStore,
      bodyWeightStore: bodyWeightStore,
      entitlementStore: entitlementStore,
    ),
    ProfileScreen(
      entitlementStore: entitlementStore,
      purchaseService: purchaseService,
      workoutStore: workoutStore,
      bodyWeightStore: bodyWeightStore,
      userProfileStore: userProfileStore,
      trainingProgramStore: widget.trainingProgramStore,
      themeStore: widget.themeStore,
      localeStore: widget.localeStore,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Персистентное хранилище (SQLite) — грузим один раз при старте,
    // каждый store сам вызовет notifyListeners() по готовности.
    workoutStore.loadFromDatabase();
    bodyWeightStore.loadFromDatabase();
    userProfileStore.loadFromDatabase();
    widget.trainingProgramStore.loadFromDatabase().then((_) {
      if (!widget.startWorkoutOnLaunch || !mounted) return;
      final day = widget.trainingProgramStore.nextTrainingDay();
      if (day != null) _startProgramDay(day);
    });
    // Локальное значение читаем сразу для мгновенного UI, но источником
    // правды остаётся restorePurchases — он может только подтвердить/выдать
    // PRO, не отобрать, поэтому запускаем его уже после локальной загрузки.
    entitlementStore.loadFromDatabase().then((_) => purchaseService.init());
  }

  void _goToTab(int index) {
    setState(() => currentIndex = index);
  }

  /// Заполняет активную тренировку выбранным днём программы (сегодняшним
  /// или следующим — см. [TrainingProgramDay]) и открывает вкладку
  /// Тренировки. Используется и Home-карточкой ("НАЧАТЬ"/"Начать
  /// тренировку раньше"), и первым запуском после онбординга.
  void _startProgramDay(TrainingProgramDay day) {
    workoutStore.applyProgramDay(day);
    _goToTab(1);
  }

  Future<void> _openProgramSetup() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OnboardingScreen(
          store: widget.trainingProgramStore,
          onFinished: () {
            Navigator.of(context).pop();
            final day = widget.trainingProgramStore.nextTrainingDay();
            if (day != null) _startProgramDay(day);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    workoutStore.dispose();
    entitlementStore.dispose();
    purchaseService.dispose();
    bodyWeightStore.dispose();
    userProfileStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: currentIndex,
            children: pages,
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: RestTimerBanner(store: workoutStore),
          ),
        ],
      ),
      bottomNavigationBar: MainBottomNav(
        currentIndex: currentIndex,
        onDestinationSelected: _goToTab,
      ),
    );
  }
}
