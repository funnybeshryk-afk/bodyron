// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'BODYRON';

  @override
  String get appTagline => 'СТРОЙ СВОЁ ТЕЛО';

  @override
  String get startWorkoutEyebrow => 'ГОТОВ ТРЕНИРОВАТЬСЯ?';

  @override
  String get startWorkoutHeadline => 'Начать тренировку';

  @override
  String get startWorkoutButton => 'НАЧАТЬ';

  @override
  String get todayWorkoutLabel => 'ТРЕНИРОВКА НА СЕГОДНЯ';

  @override
  String todayWorkoutSummary(String muscles, int count, int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count упражнения',
      many: '$count упражнений',
      few: '$count упражнения',
      one: '1 упражнение',
    );
    return '$muscles · $_temp0 · ~$minutes мин';
  }

  @override
  String get sectionLastWorkout => 'ПОСЛЕДНЯЯ ТРЕНИРОВКА';

  @override
  String minutesShort(int minutes) {
    return '$minutes мин';
  }

  @override
  String weightKg(String value) {
    return '$value кг';
  }

  @override
  String prCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count PR',
      one: '1 PR',
    );
    return '$_temp0';
  }

  @override
  String get sectionBodyWeight => 'ВЕС ТЕЛА';

  @override
  String get currentBodyWeightLabel => 'ТЕКУЩИЙ ВЕС ТЕЛА';

  @override
  String get weeklyProgressLabel => 'ПРОГРЕСС ЗА НЕДЕЛЮ';

  @override
  String weeklyProgressCount(int done, int goal) {
    return '$done/$goal тренировок';
  }

  @override
  String get navHome => 'Главная';

  @override
  String get navWorkout => 'Тренировка';

  @override
  String get navProgress => 'Прогресс';

  @override
  String get navProfile => 'Профиль';

  @override
  String get workoutScreenEyebrow => 'ТРЕНИРОВКА';

  @override
  String get workoutScreenTitle => 'Новая тренировка';

  @override
  String get restTimerSettingsTooltip => 'Настройки таймера отдыха';

  @override
  String get finishWorkoutDialogTitle => 'Завершить тренировку?';

  @override
  String get finishWorkoutDialogContent =>
      'Сессия сохранится, а экран тренировки сбросится.';

  @override
  String get cancel => 'Отмена';

  @override
  String get finish => 'Завершить';

  @override
  String get workoutSavedMessage => 'Тренировка сохранена';

  @override
  String get addExerciseButton => 'ДОБАВИТЬ УПРАЖНЕНИЕ';

  @override
  String get finishWorkoutButton => 'ЗАВЕРШИТЬ ТРЕНИРОВКУ';

  @override
  String workoutExerciseProgressLabel(int current, int total) {
    return 'УПРАЖНЕНИЕ $current ИЗ $total';
  }

  @override
  String get workoutNextExerciseButton => 'НАЧАТЬ УПРАЖНЕНИЕ';

  @override
  String get workoutAllDoneTitle => 'Все упражнения выполнены';

  @override
  String get emptyWorkoutTitle => 'Составь тренировку';

  @override
  String get emptyWorkoutSubtitle =>
      'Добавь упражнения, чтобы начать вести тренировку.';

  @override
  String get workoutTimeLabel => 'ВРЕМЯ ТРЕНИРОВКИ';

  @override
  String get removeExerciseTooltip => 'Удалить упражнение';

  @override
  String get noSetsYetMessage => 'Подходов пока нет — добавь первый.';

  @override
  String get addSetButton => 'ДОБАВИТЬ ПОДХОД';

  @override
  String lastSetHint(String value, int reps) {
    return 'Прошлый раз: $value кг × $reps';
  }

  @override
  String get setDoneButton => '✓ ГОТОВО';

  @override
  String get setDoneFeedback => '✓ Подход выполнен';

  @override
  String get addExerciseSheetTitle => 'Добавить упражнение';

  @override
  String get addYourOwnExerciseTile => 'Добавить своё упражнение';

  @override
  String get addCustomExerciseDialogTitle => 'Добавить своё упражнение';

  @override
  String get exerciseNameHint => 'Название упражнения';

  @override
  String get muscleGroupOptionalLabel => 'ГРУППА МЫШЦ (НЕОБЯЗАТЕЛЬНО)';

  @override
  String get add => 'Добавить';

  @override
  String get setIntensityTitle => 'Интенсивность подхода';

  @override
  String get rpeLabel => 'RPE';

  @override
  String get toFailureLabel => 'До отказа';

  @override
  String rpeValue(String value) {
    return 'RPE $value';
  }

  @override
  String get toFailureDescription =>
      'Этот подход будет отмечен как выполненный до мышечного отказа.';

  @override
  String get clear => 'Сбросить';

  @override
  String get save => 'Сохранить';

  @override
  String get toFailureChipLabel => 'ДО ОТКАЗА';

  @override
  String get addIntensityLabel => 'ИЗМЕНИТЬ ПОДХОД';

  @override
  String get plateCalculatorTooltip => 'Калькулятор блинов';

  @override
  String get plateCalculatorTitle => 'Калькулятор блинов';

  @override
  String plateCalculatorTargetWeight(String value) {
    return 'Цель: $value кг';
  }

  @override
  String plateCalculatorBarLabel(String value) {
    return 'Гриф: $value кг';
  }

  @override
  String get plateCalculatorPerSideLabel => 'НА КАЖДУЮ СТОРОНУ';

  @override
  String get plateCalculatorNoPlatesMessage =>
      'Одного грифа достаточно или больше — блины не нужны.';

  @override
  String plateCalculatorBelowBarMessage(String value) {
    return 'Цель меньше веса грифа ($value кг).';
  }

  @override
  String plateCalculatorApproxNote(String value) {
    return 'Ближайший доступный вес со стандартными блинами: $value кг';
  }

  @override
  String get defaultRestTimeTitle => 'Время отдыха по умолчанию';

  @override
  String get restCompleteLabel => 'ОТДЫХ ЗАВЕРШЁН';

  @override
  String get restLabel => 'ОТДЫХ';

  @override
  String get skipRestTooltip => 'Пропустить отдых';

  @override
  String get restSkipButton => 'Пропустить';

  @override
  String get restTimerNotificationTitle => 'Отдых окончен';

  @override
  String get restTimerNotificationBody => 'Пора выполнять следующий подход.';

  @override
  String get muscleGroupChest => 'Грудь';

  @override
  String get muscleGroupBack => 'Спина';

  @override
  String get muscleGroupLegs => 'Ноги';

  @override
  String get muscleGroupShoulders => 'Плечи';

  @override
  String get muscleGroupArms => 'Руки';

  @override
  String get muscleGroupAbs => 'Пресс';

  @override
  String get profileScreenTitle => 'Профиль';

  @override
  String get profileDeveloperSection => 'РАЗРАБОТЧИК';

  @override
  String get proDebugToggleLabel => 'PRO — только для отладки';

  @override
  String get proDebugToggleSubtitle =>
      'Имитирует PRO-доступ для проверки интерфейса. Не отображается в релизных сборках.';

  @override
  String get proBadgeLabel => 'PRO';

  @override
  String get proSectionTitle => 'PRO';

  @override
  String get proUpgradeDescription =>
      'Умные рекомендации по прогрессии, продвинутые графики силы и определение плато.';

  @override
  String proUpgradeButtonLabel(String price) {
    return 'Оформить — $price';
  }

  @override
  String get proPurchasedTitle => 'PRO активирован';

  @override
  String proPurchasedOnDate(String date) {
    return 'Куплено $date';
  }

  @override
  String get proUnavailableTitle => 'Покупка PRO недоступна';

  @override
  String get proUnavailableSubtitle =>
      'Магазин пока не настроен. Загляни сюда позже.';

  @override
  String get purchaseErrorNetwork =>
      'Нет подключения к интернету. Проверь сеть и попробуй снова.';

  @override
  String get purchaseErrorItemUnavailable =>
      'Этот товар сейчас недоступен. Попробуй позже.';

  @override
  String get purchaseErrorCancelled => 'Покупка отменена.';

  @override
  String get purchaseErrorGeneric =>
      'Не удалось совершить покупку. Попробуй ещё раз.';

  @override
  String get exportHistorySection => 'ДАННЫЕ';

  @override
  String get exportHistoryTitle => 'Экспорт истории тренировок';

  @override
  String get exportHistorySubtitle =>
      'Поделиться CSV-файлом со всеми завершёнными тренировками';

  @override
  String get exportHistoryEmptyHint =>
      'Сначала заверши тренировку, чтобы экспортировать историю';

  @override
  String get exportHistoryShareText => 'История тренировок BODYRON';

  @override
  String get exportHistoryErrorMessage =>
      'Не удалось экспортировать историю тренировок';

  @override
  String get relativeToday => 'Сегодня';

  @override
  String get relativeYesterday => 'Вчера';

  @override
  String relativeDaysAgo(int days) {
    String _temp0 = intl.Intl.pluralLogic(
      days,
      locale: localeName,
      other: '$days дня назад',
      many: '$days дней назад',
      few: '$days дня назад',
      one: '$days день назад',
    );
    return '$_temp0';
  }

  @override
  String get bodyWeightEmptyTitle => 'Вес ещё не записан';

  @override
  String get bodyWeightEmptyMessage => 'Добавь первую запись веса';

  @override
  String get addWeightEntryButton => 'ДОБАВИТЬ ЗАПИСЬ';

  @override
  String get addWeightEntryDialogTitle => 'Запись веса тела';

  @override
  String get weightFieldLabel => 'Вес (кг)';

  @override
  String get dateFieldLabel => 'Дата';

  @override
  String get weightEntryInvalidMessage => 'Введи вес больше 0';

  @override
  String get profileNameSection => 'ИМЯ';

  @override
  String get profileNameEmpty => 'Добавь своё имя';

  @override
  String get editNameDialogTitle => 'Твоё имя';

  @override
  String get nameFieldHint => 'Введи имя';

  @override
  String get profileBodyWeightSection => 'ВЕС ТЕЛА';

  @override
  String get profileBodyWeightEmptyHint => 'Записей пока нет';

  @override
  String get settingsSection => 'НАСТРОЙКИ';

  @override
  String get restDurationSettingTitle => 'Время отдыха по умолчанию';

  @override
  String get weightUnitSettingTitle => 'Единица веса';

  @override
  String get weightUnitComingSoonHint => 'Другие единицы появятся позже';

  @override
  String appVersionLabel(String version) {
    return 'Версия $version';
  }

  @override
  String get progressEmptyTitle => 'Прогресса пока нет';

  @override
  String get progressEmptyMessage =>
      'Заверши несколько тренировок, чтобы увидеть прогресс здесь.';

  @override
  String get progressWeightChartTitle => 'ВЕС ТЕЛА';

  @override
  String get progressVolumeChartTitle => 'ОБЪЁМ ЗА НЕДЕЛЮ';

  @override
  String get progressPersonalRecordsTitle => 'ЛИЧНЫЕ РЕКОРДЫ';

  @override
  String get progressPersonalRecordsEmptyHint =>
      'Повтори упражнение в двух тренировках, чтобы увидеть здесь PR';

  @override
  String get progressRecentWorkoutsTitle => 'ПОСЛЕДНИЕ ТРЕНИРОВКИ';

  @override
  String get progressWorkoutDetailTitle => 'Детали тренировки';

  @override
  String progressSetLabel(int index) {
    return 'Подход $index';
  }

  @override
  String get progressNoWeightDataHint =>
      'Запиши вес тела, чтобы увидеть график здесь';

  @override
  String get progressNoVolumeDataHint =>
      'Заверши тренировку, чтобы увидеть недельный объём';

  @override
  String weightByReps(String weight, int reps) {
    return '$weight кг × $reps';
  }

  @override
  String get progressScreenTitle => 'Прогресс';

  @override
  String recentWorkoutSummary(String when, int count, String duration) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count упражнения',
      many: '$count упражнений',
      few: '$count упражнения',
      one: '1 упражнение',
    );
    return '$when · $_temp0 · $duration';
  }

  @override
  String get nextTargetLabel => 'СЛЕДУЮЩАЯ ЦЕЛЬ';

  @override
  String nextTargetValue(String weight, int repsLow, int repsHigh) {
    return '$weight кг × $repsLow–$repsHigh';
  }

  @override
  String get plateauBannerTitle => 'Прогресс остановился';

  @override
  String get plateauBannerMessage =>
      'Твой лучший подход не улучшался последние 3 тренировки. Попробуй вариацию упражнения или разгрузочную неделю.';

  @override
  String get smartProgressionTeaserTitle => 'Открой Smart Progression с PRO';

  @override
  String get smartProgressionTeaserSubtitle =>
      'Получай персональные цели по весу и повторениям на основе своей истории.';

  @override
  String get strengthProgressTitle => 'ПРОГРЕСС СИЛЫ';

  @override
  String get strengthProgressTeaserTitle => 'Открой графики силы с PRO';

  @override
  String get strengthProgressTeaserSubtitle =>
      'Отслеживай динамику расчётного 1ПМ по любому упражнению со временем.';

  @override
  String get strengthProgressNoDataHint =>
      'Пока недостаточно истории по этому упражнению.';

  @override
  String get themeSettingTitle => 'Тема';

  @override
  String get themeModeLight => 'Светлая';

  @override
  String get themeModeDark => 'Тёмная';

  @override
  String get themeModeSystem => 'Системная';

  @override
  String get languageSettingTitle => 'Язык';

  @override
  String get weekdayMonShort => 'Пн';

  @override
  String get weekdayTueShort => 'Вт';

  @override
  String get weekdayWedShort => 'Ср';

  @override
  String get weekdayThuShort => 'Чт';

  @override
  String get weekdayFriShort => 'Пт';

  @override
  String get weekdaySatShort => 'Сб';

  @override
  String get weekdaySunShort => 'Вс';

  @override
  String get weekdayMonFull => 'Понедельник';

  @override
  String get weekdayTueFull => 'Вторник';

  @override
  String get weekdayWedFull => 'Среда';

  @override
  String get weekdayThuFull => 'Четверг';

  @override
  String get weekdayFriFull => 'Пятница';

  @override
  String get weekdaySatFull => 'Суббота';

  @override
  String get weekdaySunFull => 'Воскресенье';

  @override
  String get exerciseTechniqueTooltip => 'Техника упражнения';

  @override
  String get exerciseTipsTitle => 'СОВЕТЫ ПО ТЕХНИКЕ';

  @override
  String get exerciseCommonMistakeTitle => 'ЧАСТАЯ ОШИБКА';

  @override
  String get learnCardTitle => 'Изучи основы';

  @override
  String get learnCardSubtitle =>
      'Советы по прогрессии, отдыху, RPE и не только';

  @override
  String get trainingArticlesScreenEyebrow => 'ОБУЧЕНИЕ';

  @override
  String get trainingArticlesScreenTitle => 'Обучающие статьи';

  @override
  String get todayWorkoutStartButton => 'НАЧАТЬ';

  @override
  String get restDayTitle => 'Сегодня отдых 😌';

  @override
  String get restDaySubtitle => 'Ты уже выполнил план на сегодня.';

  @override
  String get restDayNextWorkoutLabel => 'Следующая тренировка';

  @override
  String get restDayViewWorkoutButton => 'ПОСМОТРЕТЬ ТРЕНИРОВКУ';

  @override
  String get restDayStartEarlyButton => 'Начать тренировку раньше';

  @override
  String get noProgramTitle => 'Настрой свою программу тренировок за 30 секунд';

  @override
  String get noProgramSubtitle =>
      'Дальше приложение само будет предлагать тренировку на каждый день.';

  @override
  String get noProgramSetupButton => 'Настроить программу';

  @override
  String get onboardingWelcomeTitle => 'Добро пожаловать в BODYRON';

  @override
  String get onboardingWelcomeSubtitle =>
      'Тренируйся. Записывай. Становись сильнее.';

  @override
  String get onboardingStartButton => 'НАЧАТЬ';

  @override
  String get onboardingGoalTitle => 'Какая у тебя цель?';

  @override
  String get onboardingGoalMuscleGain => 'Набрать мышечную массу';

  @override
  String get onboardingGoalStrength => 'Стать сильнее';

  @override
  String get onboardingGoalWeightLoss => 'Снизить вес';

  @override
  String get onboardingGoalMaintenance => 'Поддерживать форму';

  @override
  String get onboardingContinueButton => 'ПРОДОЛЖИТЬ';

  @override
  String get onboardingFrequencyTitle =>
      'Сколько раз в неделю ты тренируешься?';

  @override
  String onboardingFrequencyOptionLabel(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count раза в неделю',
      many: '$count раз в неделю',
      few: '$count раза в неделю',
      one: '$count раз в неделю',
    );
    return '$_temp0';
  }

  @override
  String get onboardingLevelTitle => 'Какой у тебя уровень?';

  @override
  String get onboardingLevelBeginner => 'Новичок';

  @override
  String get onboardingLevelBeginnerHint => 'До 6 месяцев';

  @override
  String get onboardingLevelIntermediate => 'Средний';

  @override
  String get onboardingLevelIntermediateHint => '6 месяцев – 2 года';

  @override
  String get onboardingLevelAdvanced => 'Опытный';

  @override
  String get onboardingLevelAdvancedHint => '2+ года';

  @override
  String get onboardingReadyTitle => 'Твоя программа готова';

  @override
  String get onboardingReadyRestDayLabel => 'Отдых';

  @override
  String get onboardingReadyStartButton => 'НАЧАТЬ ПЕРВУЮ ТРЕНИРОВКУ';

  @override
  String get completionTitle => 'ТРЕНИРОВКА ЗАВЕРШЕНА 🔥';

  @override
  String get completionSubtitle => 'Отличная работа!';

  @override
  String get completionDurationLabel => 'ВРЕМЯ';

  @override
  String get completionVolumeLabel => 'ОБЪЁМ';

  @override
  String get completionSetsLabel => 'ПОДХОДЫ';

  @override
  String get completionNewPrBadge => '🏆 Новый PR';

  @override
  String completionMotivationLine(String exercise, String delta) {
    return 'Ты стал сильнее. Твой рабочий вес в упражнении «$exercise» вырос на $delta кг.';
  }

  @override
  String get completionDoneButton => 'ГОТОВО';

  @override
  String get myProgramSection => 'МОЯ ПРОГРАММА';

  @override
  String get myProgramCurrentLabel => 'ТЕКУЩАЯ ПРОГРАММА';

  @override
  String get myProgramNoneLabel => 'Не настроена';

  @override
  String get myProgramChangeButton => 'Изменить программу';

  @override
  String get programPickerTitle => 'Выбери программу';

  @override
  String get programPickerPersonalTitle => 'Персональная (авто)';

  @override
  String get programPickerPersonalSubtitle =>
      'Быстрый квиз из 3 вопросов — и программа готова';

  @override
  String get programPickerProSectionTitle => 'PRO-ПРОГРАММЫ';

  @override
  String get programPickerAppliedMessage => 'Программа обновлена';

  @override
  String get programPickerLockedHint =>
      'Оформи PRO выше, чтобы открыть эту программу.';

  @override
  String get curatedProgram5x5Name => '5×5 Сила';

  @override
  String get curatedProgram5x5Description =>
      'Базовые многосуставные упражнения, 5 подходов по 5 — для роста силы.';

  @override
  String get curatedProgramPplName => 'PPL Гипертрофия';

  @override
  String get curatedProgramPplDescription =>
      'Push/Pull/Legs с высоким объёмом на 8–12 повторений — для роста мышц.';

  @override
  String get curatedProgramUpperLowerName => 'Верх/Низ Мощность';

  @override
  String get curatedProgramUpperLowerDescription =>
      '4 дня в неделю: сила и масса в одном сплите.';

  @override
  String get curatedProgramFullBodyName => 'Full Body Продвинутый';

  @override
  String get curatedProgramFullBodyDescription =>
      'Больше упражнений за тренировку — для опытных, кто тренируется эффективно.';

  @override
  String get curatedProgramArmsName => 'Руки/Плечи Специализация';

  @override
  String get curatedProgramArmsDescription =>
      'Базовый сплит плюс отдельный день на отстающие руки и плечи.';

  @override
  String get todayWorkoutChangeButton => 'Выбрать другую тренировку';

  @override
  String get changeWorkoutSheetTitle => 'Выбери тренировку';
}
