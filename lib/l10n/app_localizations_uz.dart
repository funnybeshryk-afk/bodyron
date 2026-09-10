// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get appTitle => 'BODYRON';

  @override
  String get appTagline => 'TANANGNI SHAKLLANTIR';

  @override
  String get startWorkoutEyebrow => 'MASHQ QILISHGA TAYYORMISAN?';

  @override
  String get startWorkoutHeadline => 'Mashgʻulotni boshlash';

  @override
  String get startWorkoutButton => 'BOSHLASH';

  @override
  String get todayWorkoutLabel => 'BUGUNGI MASHGʻULOT';

  @override
  String todayWorkoutSummary(String muscles, int count, int minutes) {
    return '$muscles · $count mashq · ~$minutes daqiqa';
  }

  @override
  String get sectionLastWorkout => 'OXIRGI MASHGʻULOT';

  @override
  String minutesShort(int minutes) {
    return '$minutes daq';
  }

  @override
  String weightKg(String value) {
    return '$value kg';
  }

  @override
  String prCount(int count) {
    return '$count PR';
  }

  @override
  String get sectionBodyWeight => 'TANA VAZNI';

  @override
  String get currentBodyWeightLabel => 'JORIY TANA VAZNI';

  @override
  String get weeklyProgressLabel => 'HAFTALIK NATIJA';

  @override
  String weeklyProgressCount(int done, int goal) {
    return '$done/$goal mashgʻulot';
  }

  @override
  String get navHome => 'Bosh sahifa';

  @override
  String get navWorkout => 'Mashgʻulot';

  @override
  String get navProgress => 'Natija';

  @override
  String get navProfile => 'Profil';

  @override
  String get workoutScreenEyebrow => 'MASHGʻULOT';

  @override
  String get workoutScreenTitle => 'Yangi mashgʻulot';

  @override
  String get restTimerSettingsTooltip => 'Dam olish taymeri sozlamalari';

  @override
  String get finishWorkoutDialogTitle => 'Mashgʻulotni yakunlaysanmi?';

  @override
  String get finishWorkoutDialogContent =>
      'Bu seansni saqlaydi va mashgʻulot ekranini tozalaydi.';

  @override
  String get cancel => 'Bekor qilish';

  @override
  String get finish => 'Yakunlash';

  @override
  String get workoutSavedMessage => 'Mashgʻulot saqlandi';

  @override
  String get addExerciseButton => 'MASHQ QOʻSHISH';

  @override
  String get finishWorkoutButton => 'MASHGʻULOTNI YAKUNLASH';

  @override
  String workoutExerciseProgressLabel(int current, int total) {
    return '$total DAN $current-MASHQ';
  }

  @override
  String get workoutNextExerciseButton => 'KEYINGI MASHQNI BOSHLASH';

  @override
  String get workoutAllDoneTitle => 'Barcha mashqlar bajarildi';

  @override
  String get emptyWorkoutTitle => 'Mashgʻulotingni tuz';

  @override
  String get emptyWorkoutSubtitle =>
      'Kuzatishni boshlash uchun mashqlar qoʻsh.';

  @override
  String get workoutTimeLabel => 'MASHGʻULOT VAQTI';

  @override
  String get removeExerciseTooltip => 'Mashqni oʻchirish';

  @override
  String get noSetsYetMessage => 'Hali yondashuv yoʻq — birinchisini qoʻsh.';

  @override
  String get addSetButton => 'YONDASHUV QOʻSHISH';

  @override
  String lastSetHint(String value, int reps) {
    return 'Oxirgi safar: $value kg × $reps';
  }

  @override
  String get setDoneButton => '✓ TAYYOR';

  @override
  String get setDoneFeedback => '✓ Yondashuv bajarildi';

  @override
  String get addExerciseSheetTitle => 'Mashq qoʻshish';

  @override
  String get addYourOwnExerciseTile => 'Oʻz mashqingni qoʻshish';

  @override
  String get addCustomExerciseDialogTitle => 'Oʻz mashqingni qoʻshish';

  @override
  String get exerciseNameHint => 'Mashq nomi';

  @override
  String get muscleGroupOptionalLabel => 'MUSKUL GURUHI (IXTIYORIY)';

  @override
  String get add => 'Qoʻshish';

  @override
  String get setIntensityTitle => 'Yondashuv intensivligi';

  @override
  String get rpeLabel => 'RPE';

  @override
  String get toFailureLabel => 'Toʻliq charchaguncha';

  @override
  String rpeValue(String value) {
    return 'RPE $value';
  }

  @override
  String get toFailureDescription =>
      'Bu yondashuv mushak toʻliq charchaguncha bajarilgan deb belgilanadi.';

  @override
  String get clear => 'Tozalash';

  @override
  String get save => 'Saqlash';

  @override
  String get toFailureChipLabel => 'TOʻLIQ CHARCHAGUNCHA';

  @override
  String get addIntensityLabel => 'YONDASHUVNI OʻZGARTIRISH';

  @override
  String get plateCalculatorTooltip => 'Disk kalkulyatori';

  @override
  String get plateCalculatorTitle => 'Disk kalkulyatori';

  @override
  String plateCalculatorTargetWeight(String value) {
    return 'Maqsad: $value kg';
  }

  @override
  String plateCalculatorBarLabel(String value) {
    return 'Grif: $value kg';
  }

  @override
  String get plateCalculatorPerSideLabel => 'HAR TOMONGA';

  @override
  String get plateCalculatorNoPlatesMessage =>
      'Grifning oʻzi bu vaznga yetadi yoki undan ogʻir — disk kerak emas.';

  @override
  String plateCalculatorBelowBarMessage(String value) {
    return 'Maqsad grif vaznidan kam ($value kg).';
  }

  @override
  String plateCalculatorApproxNote(String value) {
    return 'Standart disklar bilan eng yaqin natija: $value kg';
  }

  @override
  String get defaultRestTimeTitle => 'Standart dam olish vaqti';

  @override
  String get restCompleteLabel => 'DAM OLISH TUGADI';

  @override
  String get restLabel => 'DAM OLISH';

  @override
  String get skipRestTooltip => 'Dam olishni oʻtkazib yuborish';

  @override
  String get restSkipButton => 'Oʻtkazib yuborish';

  @override
  String get restTimerNotificationTitle => 'Dam olish tugadi';

  @override
  String get restTimerNotificationBody => 'Keyingi yondashuv vaqti keldi.';

  @override
  String get muscleGroupChest => 'Koʻkrak';

  @override
  String get muscleGroupBack => 'Orqa';

  @override
  String get muscleGroupLegs => 'Oyoq';

  @override
  String get muscleGroupShoulders => 'Yelka';

  @override
  String get muscleGroupArms => 'Qoʻl';

  @override
  String get muscleGroupAbs => 'Press';

  @override
  String get profileScreenTitle => 'Profil';

  @override
  String get profileDeveloperSection => 'DASTURCHI';

  @override
  String get proDebugToggleLabel => 'PRO — faqat sinov uchun';

  @override
  String get proDebugToggleSubtitle =>
      'Interfeysni tekshirish uchun PRO huquqini simulyatsiya qiladi. Relizda koʻrinmaydi.';

  @override
  String get proBadgeLabel => 'PRO';

  @override
  String get proSectionTitle => 'PRO';

  @override
  String get proUpgradeDescription =>
      'Progressiya boʻyicha aqlli tavsiyalar, kuch grafiklari va plato aniqlash.';

  @override
  String proUpgradeButtonLabel(String price) {
    return 'Sotib olish — $price';
  }

  @override
  String get proPurchasedTitle => 'PRO faollashtirildi';

  @override
  String proPurchasedOnDate(String date) {
    return '$date sotib olindi';
  }

  @override
  String get proUnavailableTitle => 'PRO sotib olish hozircha mavjud emas';

  @override
  String get proUnavailableSubtitle =>
      'Doʻkon hali sozlanmagan. Keyinroq qayta urin.';

  @override
  String get purchaseErrorNetwork =>
      'Internet aloqasi yoʻq. Tarmoqni tekshirib, qayta urin.';

  @override
  String get purchaseErrorItemUnavailable =>
      'Bu mahsulot hozir mavjud emas. Keyinroq qayta urin.';

  @override
  String get purchaseErrorCancelled => 'Xarid bekor qilindi.';

  @override
  String get purchaseErrorGeneric => 'Xarid amalga oshmadi. Qayta urin.';

  @override
  String get exportHistorySection => 'MAʻLUMOTLAR';

  @override
  String get exportHistoryTitle => 'Mashgʻulotlar tarixini eksport qilish';

  @override
  String get exportHistorySubtitle =>
      'Barcha yakunlangan mashgʻulotlar bilan CSV faylni ulash';

  @override
  String get exportHistoryEmptyHint =>
      'Tarixni eksport qilish uchun avval mashgʻulotni yakunla';

  @override
  String get exportHistoryShareText => 'BODYRON mashgʻulotlar tarixi';

  @override
  String get exportHistoryErrorMessage =>
      'Mashgʻulotlar tarixini eksport qilib boʻlmadi';

  @override
  String get relativeToday => 'Bugun';

  @override
  String get relativeYesterday => 'Kecha';

  @override
  String relativeDaysAgo(int days) {
    return '$days kun oldin';
  }

  @override
  String get bodyWeightEmptyTitle => 'Vazn hali kiritilmagan';

  @override
  String get bodyWeightEmptyMessage => 'Birinchi vazningni qoʻsh';

  @override
  String get addWeightEntryButton => 'YOZUV QOʻSHISH';

  @override
  String get addWeightEntryDialogTitle => 'Tana vaznini kiritish';

  @override
  String get weightFieldLabel => 'Vazn (kg)';

  @override
  String get dateFieldLabel => 'Sana';

  @override
  String get weightEntryInvalidMessage => '0 dan katta vazn kirit';

  @override
  String get profileNameSection => 'ISM';

  @override
  String get profileNameEmpty => 'Ismingni qoʻsh';

  @override
  String get editNameDialogTitle => 'Isming';

  @override
  String get nameFieldHint => 'Ismingni kirit';

  @override
  String get profileBodyWeightSection => 'TANA VAZNI';

  @override
  String get profileBodyWeightEmptyHint => 'Hali yozuv yoʻq';

  @override
  String get settingsSection => 'SOZLAMALAR';

  @override
  String get restDurationSettingTitle => 'Standart dam olish vaqti';

  @override
  String get weightUnitSettingTitle => 'Vazn birligi';

  @override
  String get weightUnitComingSoonHint => 'Boshqa birliklar tez orada';

  @override
  String appVersionLabel(String version) {
    return 'Versiya $version';
  }

  @override
  String get progressEmptyTitle => 'Hali natija yoʻq';

  @override
  String get progressEmptyMessage =>
      'Natijani koʻrish uchun bir nechta mashgʻulotni yakunla.';

  @override
  String get progressWeightChartTitle => 'TANA VAZNI';

  @override
  String get progressVolumeChartTitle => 'HAFTALIK HAJM';

  @override
  String get progressPersonalRecordsTitle => 'SHAXSIY REKORDLAR';

  @override
  String get progressPersonalRecordsEmptyHint =>
      'Bu yerda PR koʻrish uchun mashqni ikki mashgʻulotda takrorla';

  @override
  String get progressRecentWorkoutsTitle => 'SOʻNGGI MASHGʻULOTLAR';

  @override
  String get progressWorkoutDetailTitle => 'Mashgʻulot tafsilotlari';

  @override
  String progressSetLabel(int index) {
    return '$index-yondashuv';
  }

  @override
  String get progressNoWeightDataHint =>
      'Grafikni koʻrish uchun tana vazningni yoz';

  @override
  String get progressNoVolumeDataHint =>
      'Haftalik hajmni koʻrish uchun mashgʻulotni yakunla';

  @override
  String weightByReps(String weight, int reps) {
    return '$weight kg × $reps';
  }

  @override
  String get progressScreenTitle => 'Natija';

  @override
  String recentWorkoutSummary(String when, int count, String duration) {
    return '$when · $count mashq · $duration';
  }

  @override
  String get nextTargetLabel => 'KEYINGI MAQSAD';

  @override
  String nextTargetValue(String weight, int repsLow, int repsHigh) {
    return '$weight kg × $repsLow–$repsHigh';
  }

  @override
  String get plateauBannerTitle => 'Progress toʻxtab qoldi';

  @override
  String get plateauBannerMessage =>
      'Eng yaxshi yondashuving soʻnggi 3 mashgʻulotda yaxshilanmadi. Mashq variatsiyasi yoki deload haftasini koʻrib chiq.';

  @override
  String get smartProgressionTeaserTitle =>
      'Smart Progression funksiyasini PRO bilan och';

  @override
  String get smartProgressionTeaserSubtitle =>
      'Tarixingga asoslangan shaxsiy vazn va takrorlash maqsadlarini ol.';

  @override
  String get strengthProgressTitle => 'KUCH PROGRESSI';

  @override
  String get strengthProgressTeaserTitle => 'PRO bilan kuch grafiklarini och';

  @override
  String get strengthProgressTeaserSubtitle =>
      'Istalgan mashq boʻyicha taxminiy 1TM dinamikasini kuzat.';

  @override
  String get strengthProgressNoDataHint =>
      'Bu mashq uchun hali yetarli tarix yoʻq.';

  @override
  String get themeSettingTitle => 'Mavzu';

  @override
  String get themeModeLight => 'Yorugʻ';

  @override
  String get themeModeDark => 'Qorongʻi';

  @override
  String get themeModeSystem => 'Tizim';

  @override
  String get languageSettingTitle => 'Til';

  @override
  String get weekdayMonShort => 'Du';

  @override
  String get weekdayTueShort => 'Se';

  @override
  String get weekdayWedShort => 'Ch';

  @override
  String get weekdayThuShort => 'Pa';

  @override
  String get weekdayFriShort => 'Ju';

  @override
  String get weekdaySatShort => 'Sh';

  @override
  String get weekdaySunShort => 'Ya';

  @override
  String get weekdayMonFull => 'Dushanba';

  @override
  String get weekdayTueFull => 'Seshanba';

  @override
  String get weekdayWedFull => 'Chorshanba';

  @override
  String get weekdayThuFull => 'Payshanba';

  @override
  String get weekdayFriFull => 'Juma';

  @override
  String get weekdaySatFull => 'Shanba';

  @override
  String get weekdaySunFull => 'Yakshanba';

  @override
  String get exerciseTechniqueTooltip => 'Mashq texnikasi';

  @override
  String get exerciseTipsTitle => 'TEXNIKA BOʻYICHA MASLAHATLAR';

  @override
  String get exerciseCommonMistakeTitle => 'KENG TARQALGAN XATO';

  @override
  String get learnCardTitle => 'Asoslarni oʻrgan';

  @override
  String get learnCardSubtitle =>
      'Progressiya, dam olish, RPE va boshqalar boʻyicha maslahatlar';

  @override
  String get trainingArticlesScreenEyebrow => 'TAʼLIM';

  @override
  String get trainingArticlesScreenTitle => 'Oʻquv maqolalari';

  @override
  String get todayWorkoutStartButton => 'BOSHLASH';

  @override
  String get restDayTitle => 'Bugun dam olish kuni 😌';

  @override
  String get restDaySubtitle => 'Bugungi rejani allaqachon bajardingiz.';

  @override
  String get restDayNextWorkoutLabel => 'Keyingi mashgʻulot';

  @override
  String get restDayViewWorkoutButton => 'MASHGʻULOTNI KOʻRISH';

  @override
  String get restDayStartEarlyButton =>
      'Mashgʻulotni muddatidan oldin boshlash';

  @override
  String get noProgramTitle => 'Dasturingni 30 soniyada sozla';

  @override
  String get noProgramSubtitle =>
      'Shundan keyin BODYRON har kuni mashgʻulotni oʻzi taklif qiladi.';

  @override
  String get noProgramSetupButton => 'Dasturni sozlash';

  @override
  String get onboardingWelcomeTitle => 'BODYRONga xush kelibsiz';

  @override
  String get onboardingWelcomeSubtitle => 'Mashq qil. Yoz. Kuchliroq boʻl.';

  @override
  String get onboardingStartButton => 'BOSHLASH';

  @override
  String get onboardingGoalTitle => 'Maqsading nima?';

  @override
  String get onboardingGoalMuscleGain => 'Mushak massasini oshirish';

  @override
  String get onboardingGoalStrength => 'Kuchliroq boʻlish';

  @override
  String get onboardingGoalWeightLoss => 'Vaznni kamaytirish';

  @override
  String get onboardingGoalMaintenance => 'Formani saqlash';

  @override
  String get onboardingContinueButton => 'DAVOM ETISH';

  @override
  String get onboardingFrequencyTitle => 'Haftada nechta marta mashq qilasan?';

  @override
  String onboardingFrequencyOptionLabel(int count) {
    return 'Haftada $count marta';
  }

  @override
  String get onboardingLevelTitle => 'Tajriba darajang qanday?';

  @override
  String get onboardingLevelBeginner => 'Yangi boshlovchi';

  @override
  String get onboardingLevelBeginnerHint => '6 oygacha';

  @override
  String get onboardingLevelIntermediate => 'Oʻrta daraja';

  @override
  String get onboardingLevelIntermediateHint => '6 oy – 2 yil';

  @override
  String get onboardingLevelAdvanced => 'Tajribali';

  @override
  String get onboardingLevelAdvancedHint => '2+ yil';

  @override
  String get onboardingReadyTitle => 'Dasturing tayyor';

  @override
  String get onboardingReadyRestDayLabel => 'Dam olish';

  @override
  String get onboardingReadyStartButton => 'BIRINCHI MASHGʻULOTNI BOSHLASH';

  @override
  String get completionTitle => 'MASHGʻULOT YAKUNLANDI 🔥';

  @override
  String get completionSubtitle => 'Ajoyib ish!';

  @override
  String get completionDurationLabel => 'VAQT';

  @override
  String get completionVolumeLabel => 'HAJM';

  @override
  String get completionSetsLabel => 'YONDASHUVLAR';

  @override
  String get completionNewPrBadge => '🏆 Yangi PR';

  @override
  String completionMotivationLine(String exercise, String delta) {
    return 'Sen kuchliroq boʻlding. $exercise mashqida ishchi vazning $delta kg oshdi.';
  }

  @override
  String get completionDoneButton => 'TAYYOR';

  @override
  String get myProgramSection => 'MENING DASTURIM';

  @override
  String get myProgramCurrentLabel => 'JORIY DASTUR';

  @override
  String get myProgramNoneLabel => 'Sozlanmagan';

  @override
  String get myProgramChangeButton => 'Dasturni oʻzgartirish';

  @override
  String get programPickerTitle => 'Dastur tanlash';

  @override
  String get programPickerPersonalTitle => 'Shaxsiy (avto)';

  @override
  String get programPickerPersonalSubtitle =>
      '3 ta savoldan iborat tezkor viktorina — va dastur tayyor';

  @override
  String get programPickerProSectionTitle => 'PRO DASTURLAR';

  @override
  String get programPickerAppliedMessage => 'Dastur yangilandi';

  @override
  String get programPickerLockedHint =>
      'Bu dasturni ochish uchun yuqorida PRO oling.';

  @override
  String get curatedProgram5x5Name => '5×5 Kuch';

  @override
  String get curatedProgram5x5Description =>
      'Asosiy koʻp boʻgʻimli mashqlar, 5 ta yondashuv × 5 ta takror — kuch oshirish uchun.';

  @override
  String get curatedProgramPplName => 'PPL Gipertrofiya';

  @override
  String get curatedProgramPplDescription =>
      'Yuqori hajmli Itarish/Tortish/Oyoq, 8–12 takror — mushak oʻsishi uchun.';

  @override
  String get curatedProgramUpperLowerName => 'Yuqori/Pastki Kuch';

  @override
  String get curatedProgramUpperLowerDescription =>
      'Haftada 4 kun — bitta splitda kuch va massa.';

  @override
  String get curatedProgramFullBodyName => 'Full Body Ilg\'or';

  @override
  String get curatedProgramFullBodyDescription =>
      'Har mashgʻulotda koʻproq mashq — tajribali sportchilar uchun.';

  @override
  String get curatedProgramArmsName => 'Qoʻl/Yelka Ixtisoslashuvi';

  @override
  String get curatedProgramArmsDescription =>
      'Asosiy split ustiga ortda qolgan qoʻl va yelka uchun alohida kun.';
}
