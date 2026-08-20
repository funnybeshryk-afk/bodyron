import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

/// Отображаемое (локализованное) название группы мышц. Канонические
/// английские строки ('Chest', 'Back', ...) остаются внутренним ключом
/// данных (см. [ExerciseLibrary]) — меняется только то, что видит пользователь.
extension MuscleGroupL10n on String {
  String display(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case 'Chest':
        return l10n.muscleGroupChest;
      case 'Back':
        return l10n.muscleGroupBack;
      case 'Legs':
        return l10n.muscleGroupLegs;
      case 'Shoulders':
        return l10n.muscleGroupShoulders;
      case 'Arms':
        return l10n.muscleGroupArms;
      case 'Abs':
        return l10n.muscleGroupAbs;
      default:
        return this;
    }
  }
}
