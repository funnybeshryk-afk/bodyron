import 'package:flutter/widgets.dart';

/// Локализация авто-названий завершённых тренировок (см.
/// [WorkoutSessionStore.finishWorkout] — генерирует 'Chest Day', 'Full Body
/// Day', 'Workout' и т.п. по группам мышц в сессии) и названий дней
/// автосгенерированной программы (см. [ProgramGenerator] — тот же набор
/// канонических ключей, 'Push Day'/'Upper Body Day'/и т.п., чтобы Home и
/// история тренировок называли одно и то же одинаково). Эти строки хранятся
/// в БД как есть (см. [CompletedWorkout.name]) — это тот же канонический
/// английский ключ, что и остальной контент приложения, просто не через
/// [ExerciseDefinition]; локализуется только на отображении, что заодно
/// локализует и уже сохранённую в БД историю.
const Map<String, String> _ruWorkoutName = {
  'Workout': 'Тренировка',
  'Chest Day': 'Тренировка на грудь',
  'Back Day': 'Тренировка на спину',
  'Legs Day': 'Тренировка на ноги',
  'Shoulders Day': 'Тренировка на плечи',
  'Arms Day': 'Тренировка на руки',
  'Abs Day': 'Тренировка на пресс',
  'Full Body Day': 'Тренировка на всё тело',
  'Upper Body Day': 'Тренировка на верх тела',
  'Lower Body Day': 'Тренировка на низ тела',
  'Push Day': 'Жимовой день',
  'Pull Day': 'Тяговый день',
  'Shoulders & Arms Day': 'Тренировка на плечи и руки',
  'Arms & Abs Day': 'Тренировка на руки и пресс',
};

const Map<String, String> _uzWorkoutName = {
  'Workout': 'Mashgʻulot',
  'Chest Day': 'Koʻkrak mashgʻuloti',
  'Back Day': 'Qanot mashgʻuloti',
  'Legs Day': 'Oyoq mashgʻuloti',
  'Shoulders Day': 'Yelka mashgʻuloti',
  'Arms Day': 'Qoʻl mashgʻuloti',
  'Abs Day': 'Press mashgʻuloti',
  'Full Body Day': 'Butun tana mashgʻuloti',
  'Upper Body Day': 'Yuqori tana mashgʻuloti',
  'Lower Body Day': 'Pastki tana mashgʻuloti',
  'Push Day': 'Itarish mashgʻuloti',
  'Pull Day': 'Tortish mashgʻuloti',
  'Shoulders & Arms Day': 'Yelka va qoʻl mashgʻuloti',
  'Arms & Abs Day': 'Qoʻl va press mashgʻuloti',
};

extension WorkoutNameL10n on String {
  String displayWorkoutName(BuildContext context) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'ru':
        return _ruWorkoutName[this] ?? this;
      case 'uz':
        return _uzWorkoutName[this] ?? this;
      default:
        return this;
    }
  }
}
