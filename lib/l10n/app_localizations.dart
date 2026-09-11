import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uz'),
  ];

  /// App name shown on the Dashboard header
  ///
  /// In en, this message translates to:
  /// **'BODYRON'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'BUILD YOUR BODY'**
  String get appTagline;

  /// No description provided for @startWorkoutEyebrow.
  ///
  /// In en, this message translates to:
  /// **'READY TO TRAIN?'**
  String get startWorkoutEyebrow;

  /// No description provided for @startWorkoutHeadline.
  ///
  /// In en, this message translates to:
  /// **'Start Workout'**
  String get startWorkoutHeadline;

  /// No description provided for @startWorkoutButton.
  ///
  /// In en, this message translates to:
  /// **'START'**
  String get startWorkoutButton;

  /// No description provided for @todayWorkoutLabel.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S WORKOUT'**
  String get todayWorkoutLabel;

  /// No description provided for @todayWorkoutSummary.
  ///
  /// In en, this message translates to:
  /// **'{muscles} · {count, plural, one{1 exercise} other{{count} exercises}} · ~{minutes} min'**
  String todayWorkoutSummary(String muscles, int count, int minutes);

  /// No description provided for @sectionLastWorkout.
  ///
  /// In en, this message translates to:
  /// **'LAST WORKOUT'**
  String get sectionLastWorkout;

  /// No description provided for @minutesShort.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String minutesShort(int minutes);

  /// No description provided for @weightKg.
  ///
  /// In en, this message translates to:
  /// **'{value} kg'**
  String weightKg(String value);

  /// No description provided for @prCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 PR} other{{count} PR}}'**
  String prCount(int count);

  /// No description provided for @sectionBodyWeight.
  ///
  /// In en, this message translates to:
  /// **'BODY WEIGHT'**
  String get sectionBodyWeight;

  /// No description provided for @currentBodyWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'CURRENT BODY WEIGHT'**
  String get currentBodyWeightLabel;

  /// No description provided for @weeklyProgressLabel.
  ///
  /// In en, this message translates to:
  /// **'WEEKLY PROGRESS'**
  String get weeklyProgressLabel;

  /// No description provided for @weeklyProgressCount.
  ///
  /// In en, this message translates to:
  /// **'{done}/{goal} workouts'**
  String weeklyProgressCount(int done, int goal);

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navWorkout.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get navWorkout;

  /// No description provided for @navProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @workoutScreenEyebrow.
  ///
  /// In en, this message translates to:
  /// **'WORKOUT'**
  String get workoutScreenEyebrow;

  /// No description provided for @workoutScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'New Workout'**
  String get workoutScreenTitle;

  /// No description provided for @restTimerSettingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Rest timer settings'**
  String get restTimerSettingsTooltip;

  /// No description provided for @finishWorkoutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Finish workout?'**
  String get finishWorkoutDialogTitle;

  /// No description provided for @finishWorkoutDialogContent.
  ///
  /// In en, this message translates to:
  /// **'This saves your session and resets the workout screen.'**
  String get finishWorkoutDialogContent;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @workoutSavedMessage.
  ///
  /// In en, this message translates to:
  /// **'Workout saved'**
  String get workoutSavedMessage;

  /// No description provided for @addExerciseButton.
  ///
  /// In en, this message translates to:
  /// **'ADD EXERCISE'**
  String get addExerciseButton;

  /// No description provided for @finishWorkoutButton.
  ///
  /// In en, this message translates to:
  /// **'FINISH WORKOUT'**
  String get finishWorkoutButton;

  /// No description provided for @workoutExerciseProgressLabel.
  ///
  /// In en, this message translates to:
  /// **'EXERCISE {current} OF {total}'**
  String workoutExerciseProgressLabel(int current, int total);

  /// No description provided for @workoutNextExerciseButton.
  ///
  /// In en, this message translates to:
  /// **'START NEXT EXERCISE'**
  String get workoutNextExerciseButton;

  /// No description provided for @workoutAllDoneTitle.
  ///
  /// In en, this message translates to:
  /// **'All exercises done'**
  String get workoutAllDoneTitle;

  /// No description provided for @emptyWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Build Your Workout'**
  String get emptyWorkoutTitle;

  /// No description provided for @emptyWorkoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add exercises to start tracking your workout.'**
  String get emptyWorkoutSubtitle;

  /// No description provided for @workoutTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'WORKOUT TIME'**
  String get workoutTimeLabel;

  /// No description provided for @removeExerciseTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove exercise'**
  String get removeExerciseTooltip;

  /// No description provided for @noSetsYetMessage.
  ///
  /// In en, this message translates to:
  /// **'No sets yet — add your first one.'**
  String get noSetsYetMessage;

  /// No description provided for @addSetButton.
  ///
  /// In en, this message translates to:
  /// **'ADD SET'**
  String get addSetButton;

  /// No description provided for @lastSetHint.
  ///
  /// In en, this message translates to:
  /// **'Last: {value} kg × {reps}'**
  String lastSetHint(String value, int reps);

  /// No description provided for @setDoneButton.
  ///
  /// In en, this message translates to:
  /// **'✓ DONE'**
  String get setDoneButton;

  /// No description provided for @setDoneFeedback.
  ///
  /// In en, this message translates to:
  /// **'✓ Set complete'**
  String get setDoneFeedback;

  /// No description provided for @addExerciseSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Exercise'**
  String get addExerciseSheetTitle;

  /// No description provided for @addYourOwnExerciseTile.
  ///
  /// In en, this message translates to:
  /// **'Add your own exercise'**
  String get addYourOwnExerciseTile;

  /// No description provided for @addCustomExerciseDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Your Own Exercise'**
  String get addCustomExerciseDialogTitle;

  /// No description provided for @exerciseNameHint.
  ///
  /// In en, this message translates to:
  /// **'Exercise name'**
  String get exerciseNameHint;

  /// No description provided for @muscleGroupOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'MUSCLE GROUP (OPTIONAL)'**
  String get muscleGroupOptionalLabel;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @setIntensityTitle.
  ///
  /// In en, this message translates to:
  /// **'Set Intensity'**
  String get setIntensityTitle;

  /// No description provided for @rpeLabel.
  ///
  /// In en, this message translates to:
  /// **'RPE'**
  String get rpeLabel;

  /// No description provided for @toFailureLabel.
  ///
  /// In en, this message translates to:
  /// **'To Failure'**
  String get toFailureLabel;

  /// No description provided for @rpeValue.
  ///
  /// In en, this message translates to:
  /// **'RPE {value}'**
  String rpeValue(String value);

  /// No description provided for @toFailureDescription.
  ///
  /// In en, this message translates to:
  /// **'This set will be marked as taken to muscular failure.'**
  String get toFailureDescription;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @toFailureChipLabel.
  ///
  /// In en, this message translates to:
  /// **'TO FAILURE'**
  String get toFailureChipLabel;

  /// No description provided for @addIntensityLabel.
  ///
  /// In en, this message translates to:
  /// **'EDIT SET'**
  String get addIntensityLabel;

  /// No description provided for @plateCalculatorTooltip.
  ///
  /// In en, this message translates to:
  /// **'Plate calculator'**
  String get plateCalculatorTooltip;

  /// No description provided for @plateCalculatorTitle.
  ///
  /// In en, this message translates to:
  /// **'Plate Calculator'**
  String get plateCalculatorTitle;

  /// No description provided for @plateCalculatorTargetWeight.
  ///
  /// In en, this message translates to:
  /// **'Target: {value} kg'**
  String plateCalculatorTargetWeight(String value);

  /// No description provided for @plateCalculatorBarLabel.
  ///
  /// In en, this message translates to:
  /// **'Bar: {value} kg'**
  String plateCalculatorBarLabel(String value);

  /// No description provided for @plateCalculatorPerSideLabel.
  ///
  /// In en, this message translates to:
  /// **'PER SIDE'**
  String get plateCalculatorPerSideLabel;

  /// No description provided for @plateCalculatorNoPlatesMessage.
  ///
  /// In en, this message translates to:
  /// **'The bar alone matches or exceeds this weight — no plates needed.'**
  String get plateCalculatorNoPlatesMessage;

  /// No description provided for @plateCalculatorBelowBarMessage.
  ///
  /// In en, this message translates to:
  /// **'Target is below the bar weight ({value} kg).'**
  String plateCalculatorBelowBarMessage(String value);

  /// No description provided for @plateCalculatorApproxNote.
  ///
  /// In en, this message translates to:
  /// **'Closest achievable with standard plates: {value} kg'**
  String plateCalculatorApproxNote(String value);

  /// No description provided for @defaultRestTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Default Rest Time'**
  String get defaultRestTimeTitle;

  /// No description provided for @restCompleteLabel.
  ///
  /// In en, this message translates to:
  /// **'REST COMPLETE'**
  String get restCompleteLabel;

  /// No description provided for @restLabel.
  ///
  /// In en, this message translates to:
  /// **'REST'**
  String get restLabel;

  /// No description provided for @skipRestTooltip.
  ///
  /// In en, this message translates to:
  /// **'Skip rest'**
  String get skipRestTooltip;

  /// No description provided for @restSkipButton.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get restSkipButton;

  /// No description provided for @restTimerNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Rest complete'**
  String get restTimerNotificationTitle;

  /// No description provided for @restTimerNotificationBody.
  ///
  /// In en, this message translates to:
  /// **'Time for your next set.'**
  String get restTimerNotificationBody;

  /// No description provided for @muscleGroupChest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get muscleGroupChest;

  /// No description provided for @muscleGroupBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get muscleGroupBack;

  /// No description provided for @muscleGroupLegs.
  ///
  /// In en, this message translates to:
  /// **'Legs'**
  String get muscleGroupLegs;

  /// No description provided for @muscleGroupShoulders.
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get muscleGroupShoulders;

  /// No description provided for @muscleGroupArms.
  ///
  /// In en, this message translates to:
  /// **'Arms'**
  String get muscleGroupArms;

  /// No description provided for @muscleGroupAbs.
  ///
  /// In en, this message translates to:
  /// **'Abs'**
  String get muscleGroupAbs;

  /// No description provided for @profileScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileScreenTitle;

  /// No description provided for @profileDeveloperSection.
  ///
  /// In en, this message translates to:
  /// **'DEVELOPER'**
  String get profileDeveloperSection;

  /// No description provided for @proDebugToggleLabel.
  ///
  /// In en, this message translates to:
  /// **'PRO — Debug Only'**
  String get proDebugToggleLabel;

  /// No description provided for @proDebugToggleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Simulate Pro entitlement to test gated UI. Not shown in release builds.'**
  String get proDebugToggleSubtitle;

  /// No description provided for @proBadgeLabel.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get proBadgeLabel;

  /// No description provided for @proSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'PRO'**
  String get proSectionTitle;

  /// No description provided for @proUpgradeDescription.
  ///
  /// In en, this message translates to:
  /// **'Smart Progression suggestions, advanced strength charts, and plateau detection.'**
  String get proUpgradeDescription;

  /// No description provided for @proUpgradeButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Upgrade — {price}'**
  String proUpgradeButtonLabel(String price);

  /// No description provided for @proPurchasedTitle.
  ///
  /// In en, this message translates to:
  /// **'PRO unlocked'**
  String get proPurchasedTitle;

  /// No description provided for @proPurchasedOnDate.
  ///
  /// In en, this message translates to:
  /// **'Purchased on {date}'**
  String proPurchasedOnDate(String date);

  /// No description provided for @proUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'PRO purchase unavailable'**
  String get proUnavailableTitle;

  /// No description provided for @proUnavailableSubtitle.
  ///
  /// In en, this message translates to:
  /// **'The store isn\'t set up for this yet. Please check back later.'**
  String get proUnavailableSubtitle;

  /// No description provided for @purchaseErrorNetwork.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Check your network and try again.'**
  String get purchaseErrorNetwork;

  /// No description provided for @purchaseErrorItemUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This item is currently unavailable. Please try again later.'**
  String get purchaseErrorItemUnavailable;

  /// No description provided for @purchaseErrorCancelled.
  ///
  /// In en, this message translates to:
  /// **'Purchase cancelled.'**
  String get purchaseErrorCancelled;

  /// No description provided for @purchaseErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Purchase failed. Please try again.'**
  String get purchaseErrorGeneric;

  /// No description provided for @exportHistorySection.
  ///
  /// In en, this message translates to:
  /// **'DATA'**
  String get exportHistorySection;

  /// No description provided for @exportHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Export Workout History'**
  String get exportHistoryTitle;

  /// No description provided for @exportHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share a CSV file of all completed workouts'**
  String get exportHistorySubtitle;

  /// No description provided for @exportHistoryEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Complete a workout first to export history'**
  String get exportHistoryEmptyHint;

  /// No description provided for @exportHistoryShareText.
  ///
  /// In en, this message translates to:
  /// **'BODYRON workout history'**
  String get exportHistoryShareText;

  /// No description provided for @exportHistoryErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t export workout history'**
  String get exportHistoryErrorMessage;

  /// No description provided for @relativeToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get relativeToday;

  /// No description provided for @relativeYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get relativeYesterday;

  /// No description provided for @relativeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String relativeDaysAgo(int days);

  /// No description provided for @bodyWeightEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No weight logged yet'**
  String get bodyWeightEmptyTitle;

  /// No description provided for @bodyWeightEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Add your first weight entry'**
  String get bodyWeightEmptyMessage;

  /// No description provided for @addWeightEntryButton.
  ///
  /// In en, this message translates to:
  /// **'ADD ENTRY'**
  String get addWeightEntryButton;

  /// No description provided for @addWeightEntryDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Log Body Weight'**
  String get addWeightEntryDialogTitle;

  /// No description provided for @weightFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weightFieldLabel;

  /// No description provided for @dateFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateFieldLabel;

  /// No description provided for @weightEntryInvalidMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter a weight greater than 0'**
  String get weightEntryInvalidMessage;

  /// No description provided for @profileNameSection.
  ///
  /// In en, this message translates to:
  /// **'NAME'**
  String get profileNameSection;

  /// No description provided for @profileNameEmpty.
  ///
  /// In en, this message translates to:
  /// **'Add your name'**
  String get profileNameEmpty;

  /// No description provided for @editNameDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Name'**
  String get editNameDialogTitle;

  /// No description provided for @nameFieldHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get nameFieldHint;

  /// No description provided for @profileBodyWeightSection.
  ///
  /// In en, this message translates to:
  /// **'BODY WEIGHT'**
  String get profileBodyWeightSection;

  /// No description provided for @profileBodyWeightEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'No entries yet'**
  String get profileBodyWeightEmptyHint;

  /// No description provided for @settingsSection.
  ///
  /// In en, this message translates to:
  /// **'SETTINGS'**
  String get settingsSection;

  /// No description provided for @restDurationSettingTitle.
  ///
  /// In en, this message translates to:
  /// **'Default Rest Time'**
  String get restDurationSettingTitle;

  /// No description provided for @weightUnitSettingTitle.
  ///
  /// In en, this message translates to:
  /// **'Weight Unit'**
  String get weightUnitSettingTitle;

  /// No description provided for @weightUnitComingSoonHint.
  ///
  /// In en, this message translates to:
  /// **'More units coming soon'**
  String get weightUnitComingSoonHint;

  /// No description provided for @appVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String appVersionLabel(String version);

  /// No description provided for @progressEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No progress yet'**
  String get progressEmptyTitle;

  /// No description provided for @progressEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Complete a few workouts to see your progress here.'**
  String get progressEmptyMessage;

  /// No description provided for @progressWeightChartTitle.
  ///
  /// In en, this message translates to:
  /// **'BODY WEIGHT'**
  String get progressWeightChartTitle;

  /// No description provided for @progressVolumeChartTitle.
  ///
  /// In en, this message translates to:
  /// **'WEEKLY VOLUME'**
  String get progressVolumeChartTitle;

  /// No description provided for @progressPersonalRecordsTitle.
  ///
  /// In en, this message translates to:
  /// **'PERSONAL RECORDS'**
  String get progressPersonalRecordsTitle;

  /// No description provided for @progressPersonalRecordsEmptyHint.
  ///
  /// In en, this message translates to:
  /// **'Repeat an exercise across two workouts to see a PR here'**
  String get progressPersonalRecordsEmptyHint;

  /// No description provided for @progressRecentWorkoutsTitle.
  ///
  /// In en, this message translates to:
  /// **'RECENT WORKOUTS'**
  String get progressRecentWorkoutsTitle;

  /// No description provided for @progressWorkoutDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Workout Details'**
  String get progressWorkoutDetailTitle;

  /// No description provided for @progressSetLabel.
  ///
  /// In en, this message translates to:
  /// **'Set {index}'**
  String progressSetLabel(int index);

  /// No description provided for @progressNoWeightDataHint.
  ///
  /// In en, this message translates to:
  /// **'Log your body weight to see a chart here'**
  String get progressNoWeightDataHint;

  /// No description provided for @progressNoVolumeDataHint.
  ///
  /// In en, this message translates to:
  /// **'Finish a workout to see your weekly volume'**
  String get progressNoVolumeDataHint;

  /// No description provided for @weightByReps.
  ///
  /// In en, this message translates to:
  /// **'{weight} kg × {reps}'**
  String weightByReps(String weight, int reps);

  /// No description provided for @progressScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progressScreenTitle;

  /// No description provided for @recentWorkoutSummary.
  ///
  /// In en, this message translates to:
  /// **'{when} · {count, plural, one{1 exercise} other{{count} exercises}} · {duration}'**
  String recentWorkoutSummary(String when, int count, String duration);

  /// No description provided for @nextTargetLabel.
  ///
  /// In en, this message translates to:
  /// **'NEXT TARGET'**
  String get nextTargetLabel;

  /// No description provided for @nextTargetValue.
  ///
  /// In en, this message translates to:
  /// **'{weight} kg × {repsLow}–{repsHigh}'**
  String nextTargetValue(String weight, int repsLow, int repsHigh);

  /// No description provided for @plateauBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress has plateaued'**
  String get plateauBannerTitle;

  /// No description provided for @plateauBannerMessage.
  ///
  /// In en, this message translates to:
  /// **'Your top set hasn\'t improved in the last 3 sessions. Consider an exercise variation or a deload week.'**
  String get plateauBannerMessage;

  /// No description provided for @smartProgressionTeaserTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock Smart Progression with PRO'**
  String get smartProgressionTeaserTitle;

  /// No description provided for @smartProgressionTeaserSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Get personalized weight and rep targets based on your history.'**
  String get smartProgressionTeaserSubtitle;

  /// No description provided for @strengthProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'STRENGTH PROGRESS'**
  String get strengthProgressTitle;

  /// No description provided for @strengthProgressTeaserTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlock Strength Charts with PRO'**
  String get strengthProgressTeaserTitle;

  /// No description provided for @strengthProgressTeaserSubtitle.
  ///
  /// In en, this message translates to:
  /// **'See your estimated 1RM trend over time for any exercise.'**
  String get strengthProgressTeaserSubtitle;

  /// No description provided for @strengthProgressNoDataHint.
  ///
  /// In en, this message translates to:
  /// **'Not enough history for this exercise yet.'**
  String get strengthProgressNoDataHint;

  /// No description provided for @themeSettingTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeSettingTitle;

  /// No description provided for @themeModeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeModeLight;

  /// No description provided for @themeModeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeModeDark;

  /// No description provided for @themeModeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeModeSystem;

  /// No description provided for @languageSettingTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSettingTitle;

  /// No description provided for @weekdayMonShort.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get weekdayMonShort;

  /// No description provided for @weekdayTueShort.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get weekdayTueShort;

  /// No description provided for @weekdayWedShort.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get weekdayWedShort;

  /// No description provided for @weekdayThuShort.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get weekdayThuShort;

  /// No description provided for @weekdayFriShort.
  ///
  /// In en, this message translates to:
  /// **'F'**
  String get weekdayFriShort;

  /// No description provided for @weekdaySatShort.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get weekdaySatShort;

  /// No description provided for @weekdaySunShort.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get weekdaySunShort;

  /// No description provided for @weekdayMonFull.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get weekdayMonFull;

  /// No description provided for @weekdayTueFull.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get weekdayTueFull;

  /// No description provided for @weekdayWedFull.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get weekdayWedFull;

  /// No description provided for @weekdayThuFull.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get weekdayThuFull;

  /// No description provided for @weekdayFriFull.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get weekdayFriFull;

  /// No description provided for @weekdaySatFull.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get weekdaySatFull;

  /// No description provided for @weekdaySunFull.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get weekdaySunFull;

  /// No description provided for @exerciseTechniqueTooltip.
  ///
  /// In en, this message translates to:
  /// **'Exercise technique'**
  String get exerciseTechniqueTooltip;

  /// No description provided for @exerciseTipsTitle.
  ///
  /// In en, this message translates to:
  /// **'TECHNIQUE TIPS'**
  String get exerciseTipsTitle;

  /// No description provided for @exerciseCommonMistakeTitle.
  ///
  /// In en, this message translates to:
  /// **'COMMON MISTAKE'**
  String get exerciseCommonMistakeTitle;

  /// No description provided for @learnCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn the Basics'**
  String get learnCardTitle;

  /// No description provided for @learnCardSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tips on progression, rest, RPE and more'**
  String get learnCardSubtitle;

  /// No description provided for @trainingArticlesScreenEyebrow.
  ///
  /// In en, this message translates to:
  /// **'LEARN'**
  String get trainingArticlesScreenEyebrow;

  /// No description provided for @trainingArticlesScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Training Articles'**
  String get trainingArticlesScreenTitle;

  /// No description provided for @todayWorkoutStartButton.
  ///
  /// In en, this message translates to:
  /// **'START'**
  String get todayWorkoutStartButton;

  /// No description provided for @restDayTitle.
  ///
  /// In en, this message translates to:
  /// **'Rest day 😌'**
  String get restDayTitle;

  /// No description provided for @restDaySubtitle.
  ///
  /// In en, this message translates to:
  /// **'You\'ve already completed today\'s plan.'**
  String get restDaySubtitle;

  /// No description provided for @restDayNextWorkoutLabel.
  ///
  /// In en, this message translates to:
  /// **'Next workout'**
  String get restDayNextWorkoutLabel;

  /// No description provided for @restDayViewWorkoutButton.
  ///
  /// In en, this message translates to:
  /// **'VIEW WORKOUT'**
  String get restDayViewWorkoutButton;

  /// No description provided for @restDayStartEarlyButton.
  ///
  /// In en, this message translates to:
  /// **'Start workout early'**
  String get restDayStartEarlyButton;

  /// No description provided for @noProgramTitle.
  ///
  /// In en, this message translates to:
  /// **'Set up your program in 30 seconds'**
  String get noProgramTitle;

  /// No description provided for @noProgramSubtitle.
  ///
  /// In en, this message translates to:
  /// **'After that, BODYRON will suggest your workout every day.'**
  String get noProgramSubtitle;

  /// No description provided for @noProgramSetupButton.
  ///
  /// In en, this message translates to:
  /// **'Set up a program'**
  String get noProgramSetupButton;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to BODYRON'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Train. Track. Get stronger.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingStartButton.
  ///
  /// In en, this message translates to:
  /// **'GET STARTED'**
  String get onboardingStartButton;

  /// No description provided for @onboardingGoalTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your goal?'**
  String get onboardingGoalTitle;

  /// No description provided for @onboardingGoalMuscleGain.
  ///
  /// In en, this message translates to:
  /// **'Build muscle'**
  String get onboardingGoalMuscleGain;

  /// No description provided for @onboardingGoalStrength.
  ///
  /// In en, this message translates to:
  /// **'Get stronger'**
  String get onboardingGoalStrength;

  /// No description provided for @onboardingGoalWeightLoss.
  ///
  /// In en, this message translates to:
  /// **'Lose weight'**
  String get onboardingGoalWeightLoss;

  /// No description provided for @onboardingGoalMaintenance.
  ///
  /// In en, this message translates to:
  /// **'Stay in shape'**
  String get onboardingGoalMaintenance;

  /// No description provided for @onboardingContinueButton.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get onboardingContinueButton;

  /// No description provided for @onboardingFrequencyTitle.
  ///
  /// In en, this message translates to:
  /// **'How many times a week do you train?'**
  String get onboardingFrequencyTitle;

  /// No description provided for @onboardingFrequencyOptionLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count}x a week} other{{count}x a week}}'**
  String onboardingFrequencyOptionLabel(int count);

  /// No description provided for @onboardingLevelTitle.
  ///
  /// In en, this message translates to:
  /// **'What\'s your experience level?'**
  String get onboardingLevelTitle;

  /// No description provided for @onboardingLevelBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get onboardingLevelBeginner;

  /// No description provided for @onboardingLevelBeginnerHint.
  ///
  /// In en, this message translates to:
  /// **'Under 6 months'**
  String get onboardingLevelBeginnerHint;

  /// No description provided for @onboardingLevelIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get onboardingLevelIntermediate;

  /// No description provided for @onboardingLevelIntermediateHint.
  ///
  /// In en, this message translates to:
  /// **'6 months – 2 years'**
  String get onboardingLevelIntermediateHint;

  /// No description provided for @onboardingLevelAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get onboardingLevelAdvanced;

  /// No description provided for @onboardingLevelAdvancedHint.
  ///
  /// In en, this message translates to:
  /// **'2+ years'**
  String get onboardingLevelAdvancedHint;

  /// No description provided for @onboardingReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your program is ready'**
  String get onboardingReadyTitle;

  /// No description provided for @onboardingReadyRestDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get onboardingReadyRestDayLabel;

  /// No description provided for @onboardingReadyStartButton.
  ///
  /// In en, this message translates to:
  /// **'START FIRST WORKOUT'**
  String get onboardingReadyStartButton;

  /// No description provided for @completionTitle.
  ///
  /// In en, this message translates to:
  /// **'WORKOUT COMPLETE 🔥'**
  String get completionTitle;

  /// No description provided for @completionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Great work!'**
  String get completionSubtitle;

  /// No description provided for @completionDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get completionDurationLabel;

  /// No description provided for @completionVolumeLabel.
  ///
  /// In en, this message translates to:
  /// **'VOLUME'**
  String get completionVolumeLabel;

  /// No description provided for @completionSetsLabel.
  ///
  /// In en, this message translates to:
  /// **'SETS'**
  String get completionSetsLabel;

  /// No description provided for @completionNewPrBadge.
  ///
  /// In en, this message translates to:
  /// **'🏆 New PR'**
  String get completionNewPrBadge;

  /// No description provided for @completionMotivationLine.
  ///
  /// In en, this message translates to:
  /// **'You\'re getting stronger. Your {exercise} working weight is up {delta} kg.'**
  String completionMotivationLine(String exercise, String delta);

  /// No description provided for @completionDoneButton.
  ///
  /// In en, this message translates to:
  /// **'DONE'**
  String get completionDoneButton;

  /// No description provided for @myProgramSection.
  ///
  /// In en, this message translates to:
  /// **'MY PROGRAM'**
  String get myProgramSection;

  /// No description provided for @myProgramCurrentLabel.
  ///
  /// In en, this message translates to:
  /// **'CURRENT PROGRAM'**
  String get myProgramCurrentLabel;

  /// No description provided for @myProgramNoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Not set up'**
  String get myProgramNoneLabel;

  /// No description provided for @myProgramChangeButton.
  ///
  /// In en, this message translates to:
  /// **'Change program'**
  String get myProgramChangeButton;

  /// No description provided for @programPickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a program'**
  String get programPickerTitle;

  /// No description provided for @programPickerPersonalTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal (auto)'**
  String get programPickerPersonalTitle;

  /// No description provided for @programPickerPersonalSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A quick 3-question quiz, and it\'s ready'**
  String get programPickerPersonalSubtitle;

  /// No description provided for @programPickerProSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'PRO PROGRAMS'**
  String get programPickerProSectionTitle;

  /// No description provided for @programPickerAppliedMessage.
  ///
  /// In en, this message translates to:
  /// **'Program updated'**
  String get programPickerAppliedMessage;

  /// No description provided for @programPickerLockedHint.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to PRO above to unlock this program.'**
  String get programPickerLockedHint;

  /// No description provided for @curatedProgram5x5Name.
  ///
  /// In en, this message translates to:
  /// **'5×5 Strength'**
  String get curatedProgram5x5Name;

  /// No description provided for @curatedProgram5x5Description.
  ///
  /// In en, this message translates to:
  /// **'Compound lifts, 5 sets of 5 — for lifters focused on building raw strength.'**
  String get curatedProgram5x5Description;

  /// No description provided for @curatedProgramPplName.
  ///
  /// In en, this message translates to:
  /// **'PPL Hypertrophy'**
  String get curatedProgramPplName;

  /// No description provided for @curatedProgramPplDescription.
  ///
  /// In en, this message translates to:
  /// **'Push/Pull/Legs with higher volume at 8–12 reps — for building muscle size.'**
  String get curatedProgramPplDescription;

  /// No description provided for @curatedProgramUpperLowerName.
  ///
  /// In en, this message translates to:
  /// **'Upper/Lower Power'**
  String get curatedProgramUpperLowerName;

  /// No description provided for @curatedProgramUpperLowerDescription.
  ///
  /// In en, this message translates to:
  /// **'4 days a week mixing strength and hypertrophy rep ranges in one split.'**
  String get curatedProgramUpperLowerDescription;

  /// No description provided for @curatedProgramFullBodyName.
  ///
  /// In en, this message translates to:
  /// **'Advanced Full Body'**
  String get curatedProgramFullBodyName;

  /// No description provided for @curatedProgramFullBodyDescription.
  ///
  /// In en, this message translates to:
  /// **'More exercises per session — for experienced lifters who train efficiently.'**
  String get curatedProgramFullBodyDescription;

  /// No description provided for @curatedProgramArmsName.
  ///
  /// In en, this message translates to:
  /// **'Arms/Shoulders Specialization'**
  String get curatedProgramArmsName;

  /// No description provided for @curatedProgramArmsDescription.
  ///
  /// In en, this message translates to:
  /// **'A base split plus a dedicated day for lagging arms and shoulders.'**
  String get curatedProgramArmsDescription;

  /// No description provided for @todayWorkoutChangeButton.
  ///
  /// In en, this message translates to:
  /// **'Choose a different workout'**
  String get todayWorkoutChangeButton;

  /// No description provided for @changeWorkoutSheetTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a workout'**
  String get changeWorkoutSheetTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
