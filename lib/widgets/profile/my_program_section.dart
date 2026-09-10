import 'package:flutter/material.dart';

import '../../data/entitlement_store.dart';
import '../../data/purchase_service.dart';
import '../../data/training_program_store.dart';
import '../../l10n/app_localizations.dart';
import '../../screens/program_picker_screen.dart';
import '../../theme/app_palette.dart';

/// "Моя программа" на Profile — текущая программа (или "не настроена") +
/// вход в выбор программы (см. [ProgramPickerScreen]: тот же квиз, что и в
/// онбординге, плюс 5 PRO-программ).
class MyProgramSection extends StatelessWidget {
  final TrainingProgramStore trainingProgramStore;
  final EntitlementStore entitlementStore;
  final PurchaseService purchaseService;

  const MyProgramSection({
    super.key,
    required this.trainingProgramStore,
    required this.entitlementStore,
    required this.purchaseService,
  });

  void _openPicker(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProgramPickerScreen(
          trainingProgramStore: trainingProgramStore,
          entitlementStore: entitlementStore,
          purchaseService: purchaseService,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return ListenableBuilder(
      listenable: trainingProgramStore,
      builder: (context, _) {
        final program = trainingProgramStore.activeProgram;

        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _openPicker(context),
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: colors.cardBorder),
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors.accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(Icons.calendar_month_outlined, color: colors.accent),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.myProgramCurrentLabel,
                        style: TextStyle(fontSize: 11, color: colors.textMuted, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        program == null
                            ? l10n.myProgramNoneLabel
                            : l10n.onboardingFrequencyOptionLabel(program.frequency),
                        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      l10n.myProgramChangeButton,
                      style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800, color: colors.accent),
                    ),
                    Icon(Icons.chevron_right, color: colors.accent, size: 18),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
