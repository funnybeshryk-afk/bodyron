// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'BODYRON';

  @override
  String get appTagline => 'BUILD YOUR BODY';

  @override
  String get startWorkoutEyebrow => 'READY TO TRAIN?';

  @override
  String get startWorkoutHeadline => 'Start Workout';

  @override
  String get startWorkoutButton => 'START';

  @override
  String get todayWorkoutLabel => 'TODAY\'S WORKOUT';

  @override
  String todayWorkoutSummary(String muscles, int count, int minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count exercises',
      one: '1 exercise',
    );
    return '$muscles · $_temp0 · ~$minutes min';
  }

  @override
  String get sectionLastWorkout => 'LAST WORKOUT';

  @override
  String minutesShort(int minutes) {
    return '$minutes min';
  }

  @override
  String weightKg(String value) {
    return '$value kg';
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
  String get sectionBodyWeight => 'BODY WEIGHT';

  @override
  String get currentBodyWeightLabel => 'CURRENT BODY WEIGHT';

  @override
  String get weeklyProgressLabel => 'WEEKLY PROGRESS';

  @override
  String weeklyProgressCount(int done, int goal) {
    return '$done/$goal workouts';
  }

  @override
  String get navHome => 'Home';

  @override
  String get navWorkout => 'Workout';

  @override
  String get navProgress => 'Progress';

  @override
  String get navProfile => 'Profile';

  @override
  String get workoutScreenEyebrow => 'WORKOUT';

  @override
  String get workoutScreenTitle => 'New Workout';

  @override
  String get restTimerSettingsTooltip => 'Rest timer settings';

  @override
  String get finishWorkoutDialogTitle => 'Finish workout?';

  @override
  String get finishWorkoutDialogContent =>
      'This saves your session and resets the workout screen.';

  @override
  String get cancel => 'Cancel';

  @override
  String get finish => 'Finish';

  @override
  String get workoutSavedMessage => 'Workout saved';

  @override
  String get addExerciseButton => 'ADD EXERCISE';

  @override
  String get finishWorkoutButton => 'FINISH WORKOUT';

  @override
  String get emptyWorkoutTitle => 'Build Your Workout';

  @override
  String get emptyWorkoutSubtitle =>
      'Add exercises to start tracking your workout.';

  @override
  String get workoutTimeLabel => 'WORKOUT TIME';

  @override
  String get removeExerciseTooltip => 'Remove exercise';

  @override
  String get noSetsYetMessage => 'No sets yet — add your first one.';

  @override
  String get addSetButton => 'ADD SET';

  @override
  String lastSetHint(String value, int reps) {
    return 'Last: $value kg × $reps';
  }

  @override
  String get addExerciseSheetTitle => 'Add Exercise';

  @override
  String get addYourOwnExerciseTile => 'Add your own exercise';

  @override
  String get addCustomExerciseDialogTitle => 'Add Your Own Exercise';

  @override
  String get exerciseNameHint => 'Exercise name';

  @override
  String get muscleGroupOptionalLabel => 'MUSCLE GROUP (OPTIONAL)';

  @override
  String get add => 'Add';

  @override
  String get setIntensityTitle => 'Set Intensity';

  @override
  String get rpeLabel => 'RPE';

  @override
  String get toFailureLabel => 'To Failure';

  @override
  String rpeValue(String value) {
    return 'RPE $value';
  }

  @override
  String get toFailureDescription =>
      'This set will be marked as taken to muscular failure.';

  @override
  String get clear => 'Clear';

  @override
  String get save => 'Save';

  @override
  String get toFailureChipLabel => 'TO FAILURE';

  @override
  String get addIntensityLabel => 'ADD INTENSITY';

  @override
  String get plateCalculatorTooltip => 'Plate calculator';

  @override
  String get plateCalculatorTitle => 'Plate Calculator';

  @override
  String plateCalculatorTargetWeight(String value) {
    return 'Target: $value kg';
  }

  @override
  String plateCalculatorBarLabel(String value) {
    return 'Bar: $value kg';
  }

  @override
  String get plateCalculatorPerSideLabel => 'PER SIDE';

  @override
  String get plateCalculatorNoPlatesMessage =>
      'The bar alone matches or exceeds this weight — no plates needed.';

  @override
  String plateCalculatorBelowBarMessage(String value) {
    return 'Target is below the bar weight ($value kg).';
  }

  @override
  String plateCalculatorApproxNote(String value) {
    return 'Closest achievable with standard plates: $value kg';
  }

  @override
  String get defaultRestTimeTitle => 'Default Rest Time';

  @override
  String get restCompleteLabel => 'REST COMPLETE';

  @override
  String get restLabel => 'REST';

  @override
  String get skipRestTooltip => 'Skip rest';

  @override
  String get restTimerNotificationTitle => 'Rest complete';

  @override
  String get restTimerNotificationBody => 'Time for your next set.';

  @override
  String get muscleGroupChest => 'Chest';

  @override
  String get muscleGroupBack => 'Back';

  @override
  String get muscleGroupLegs => 'Legs';

  @override
  String get muscleGroupShoulders => 'Shoulders';

  @override
  String get muscleGroupArms => 'Arms';

  @override
  String get muscleGroupAbs => 'Abs';

  @override
  String get profileScreenTitle => 'Profile';

  @override
  String get profileDeveloperSection => 'DEVELOPER';

  @override
  String get proDebugToggleLabel => 'PRO — Debug Only';

  @override
  String get proDebugToggleSubtitle =>
      'Simulate Pro entitlement to test gated UI. Not shown in release builds.';

  @override
  String get proBadgeLabel => 'PRO';

  @override
  String get proSectionTitle => 'PRO';

  @override
  String get proUpgradeDescription =>
      'Smart Progression suggestions, advanced strength charts, and plateau detection.';

  @override
  String proUpgradeButtonLabel(String price) {
    return 'Upgrade — $price';
  }

  @override
  String get proPurchasedTitle => 'PRO unlocked';

  @override
  String proPurchasedOnDate(String date) {
    return 'Purchased on $date';
  }

  @override
  String get proUnavailableTitle => 'PRO purchase unavailable';

  @override
  String get proUnavailableSubtitle =>
      'The store isn\'t set up for this yet. Please check back later.';

  @override
  String get purchaseErrorNetwork =>
      'No internet connection. Check your network and try again.';

  @override
  String get purchaseErrorItemUnavailable =>
      'This item is currently unavailable. Please try again later.';

  @override
  String get purchaseErrorCancelled => 'Purchase cancelled.';

  @override
  String get purchaseErrorGeneric => 'Purchase failed. Please try again.';

  @override
  String get exportHistorySection => 'DATA';

  @override
  String get exportHistoryTitle => 'Export Workout History';

  @override
  String get exportHistorySubtitle =>
      'Share a CSV file of all completed workouts';

  @override
  String get exportHistoryEmptyHint =>
      'Complete a workout first to export history';

  @override
  String get exportHistoryShareText => 'BODYRON workout history';

  @override
  String get exportHistoryErrorMessage => 'Couldn\'t export workout history';

  @override
  String get relativeToday => 'Today';

  @override
  String get relativeYesterday => 'Yesterday';

  @override
  String relativeDaysAgo(int days) {
    return '$days days ago';
  }

  @override
  String get bodyWeightEmptyTitle => 'No weight logged yet';

  @override
  String get bodyWeightEmptyMessage => 'Add your first weight entry';

  @override
  String get addWeightEntryButton => 'ADD ENTRY';

  @override
  String get addWeightEntryDialogTitle => 'Log Body Weight';

  @override
  String get weightFieldLabel => 'Weight (kg)';

  @override
  String get dateFieldLabel => 'Date';

  @override
  String get weightEntryInvalidMessage => 'Enter a weight greater than 0';

  @override
  String get profileNameSection => 'NAME';

  @override
  String get profileNameEmpty => 'Add your name';

  @override
  String get editNameDialogTitle => 'Your Name';

  @override
  String get nameFieldHint => 'Enter your name';

  @override
  String get profileBodyWeightSection => 'BODY WEIGHT';

  @override
  String get profileBodyWeightEmptyHint => 'No entries yet';

  @override
  String get settingsSection => 'SETTINGS';

  @override
  String get restDurationSettingTitle => 'Default Rest Time';

  @override
  String get weightUnitSettingTitle => 'Weight Unit';

  @override
  String get weightUnitComingSoonHint => 'More units coming soon';

  @override
  String appVersionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get progressEmptyTitle => 'No progress yet';

  @override
  String get progressEmptyMessage =>
      'Complete a few workouts to see your progress here.';

  @override
  String get progressWeightChartTitle => 'BODY WEIGHT';

  @override
  String get progressVolumeChartTitle => 'WEEKLY VOLUME';

  @override
  String get progressPersonalRecordsTitle => 'PERSONAL RECORDS';

  @override
  String get progressPersonalRecordsEmptyHint =>
      'Repeat an exercise across two workouts to see a PR here';

  @override
  String get progressRecentWorkoutsTitle => 'RECENT WORKOUTS';

  @override
  String get progressWorkoutDetailTitle => 'Workout Details';

  @override
  String progressSetLabel(int index) {
    return 'Set $index';
  }

  @override
  String get progressNoWeightDataHint =>
      'Log your body weight to see a chart here';

  @override
  String get progressNoVolumeDataHint =>
      'Finish a workout to see your weekly volume';

  @override
  String weightByReps(String weight, int reps) {
    return '$weight kg × $reps';
  }

  @override
  String get progressScreenTitle => 'Progress';

  @override
  String recentWorkoutSummary(String when, int count, String duration) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count exercises',
      one: '1 exercise',
    );
    return '$when · $_temp0 · $duration';
  }

  @override
  String get nextTargetLabel => 'NEXT TARGET';

  @override
  String nextTargetValue(String weight, int repsLow, int repsHigh) {
    return '$weight kg × $repsLow–$repsHigh';
  }

  @override
  String get plateauBannerTitle => 'Progress has plateaued';

  @override
  String get plateauBannerMessage =>
      'Your top set hasn\'t improved in the last 3 sessions. Consider an exercise variation or a deload week.';

  @override
  String get smartProgressionTeaserTitle => 'Unlock Smart Progression with PRO';

  @override
  String get smartProgressionTeaserSubtitle =>
      'Get personalized weight and rep targets based on your history.';

  @override
  String get strengthProgressTitle => 'STRENGTH PROGRESS';

  @override
  String get strengthProgressTeaserTitle => 'Unlock Strength Charts with PRO';

  @override
  String get strengthProgressTeaserSubtitle =>
      'See your estimated 1RM trend over time for any exercise.';

  @override
  String get strengthProgressNoDataHint =>
      'Not enough history for this exercise yet.';

  @override
  String get themeSettingTitle => 'Theme';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get themeModeSystem => 'System';
}
