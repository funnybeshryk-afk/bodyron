import 'package:flutter/widgets.dart';

import '../data/curated_programs.dart';
import 'app_localizations.dart';

/// Локализованные название и описание PRO-программы (см. [CuratedProgram]),
/// тот же паттерн, что [MuscleGroupL10n]/[WorkoutNameL10n] — ключ
/// [CuratedProgram.id] статический, строки, которые видит пользователь,
/// живут в ARB.
extension CuratedProgramL10n on CuratedProgram {
  String displayName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (id) {
      case CuratedPrograms.strength5x5:
        return l10n.curatedProgram5x5Name;
      case CuratedPrograms.pplHypertrophy:
        return l10n.curatedProgramPplName;
      case CuratedPrograms.upperLowerPower:
        return l10n.curatedProgramUpperLowerName;
      case CuratedPrograms.fullBodyAdvanced:
        return l10n.curatedProgramFullBodyName;
      case CuratedPrograms.armsShouldersSpecialization:
        return l10n.curatedProgramArmsName;
      default:
        return id;
    }
  }

  String displayDescription(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (id) {
      case CuratedPrograms.strength5x5:
        return l10n.curatedProgram5x5Description;
      case CuratedPrograms.pplHypertrophy:
        return l10n.curatedProgramPplDescription;
      case CuratedPrograms.upperLowerPower:
        return l10n.curatedProgramUpperLowerDescription;
      case CuratedPrograms.fullBodyAdvanced:
        return l10n.curatedProgramFullBodyDescription;
      case CuratedPrograms.armsShouldersSpecialization:
        return l10n.curatedProgramArmsDescription;
      default:
        return '';
    }
  }
}
