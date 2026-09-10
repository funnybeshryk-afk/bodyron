import 'package:flutter/material.dart';

import '../data/curated_programs.dart';
import '../data/entitlement_store.dart';
import '../data/purchase_service.dart';
import '../data/training_program_store.dart';
import '../l10n/app_localizations.dart';
import '../l10n/curated_program_l10n.dart';
import '../theme/app_palette.dart';
import '../widgets/profile/pro_purchase_section.dart';
import '../widgets/section_title.dart';
import 'onboarding_screen.dart';

/// "Изменить программу" — Профиль → Моя программа → сюда. Две ветки:
/// бесплатная "Персональная (авто)" (тот же квиз, что и в онбординге — см.
/// [OnboardingScreen], переиспользуется без изменений) и 5 экспертных
/// PRO-программ (см. [CuratedPrograms]), тем же паттерном gate/teaser, что
/// уже используется для Smart Progression (см. [ProPurchaseSection]).
class ProgramPickerScreen extends StatelessWidget {
  final TrainingProgramStore trainingProgramStore;
  final EntitlementStore entitlementStore;
  final PurchaseService purchaseService;

  const ProgramPickerScreen({
    super.key,
    required this.trainingProgramStore,
    required this.entitlementStore,
    required this.purchaseService,
  });

  void _openPersonalQuiz(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => OnboardingScreen(
          store: trainingProgramStore,
          onFinished: () {
            // Возвращаемся сразу в Профиль — квиз (1) и этот экран выбора (2)
            // оба уходят со стека, "Моя программа" уже покажет новую программу.
            Navigator.of(context)
              ..pop()
              ..pop();
          },
        ),
      ),
    );
  }

  Future<void> _applyCurated(BuildContext context, CuratedProgram curated) async {
    final l10n = AppLocalizations.of(context)!;
    await trainingProgramStore.applyProgram(curated.program);
    if (!context.mounted) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.programPickerAppliedMessage)),
    );
  }

  void _showLockedHint(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.programPickerLockedHint)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: Listenable.merge([entitlementStore, purchaseService]),
          builder: (context, _) {
            final isPro = entitlementStore.isPro;

            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Text(
                      l10n.programPickerTitle,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _PersonalQuizTile(onTap: () => _openPersonalQuiz(context)),
                const SizedBox(height: 24),
                SectionTitle(title: l10n.programPickerProSectionTitle),
                const SizedBox(height: 10),
                if (!isPro) ...[
                  ProPurchaseSection(
                    entitlementStore: entitlementStore,
                    purchaseService: purchaseService,
                  ),
                  const SizedBox(height: 14),
                ],
                for (final curated in CuratedPrograms.all)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _CuratedProgramTile(
                      curated: curated,
                      locked: !isPro,
                      onTap: isPro
                          ? () => _applyCurated(context, curated)
                          : () => _showLockedHint(context),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PersonalQuizTile extends StatelessWidget {
  final VoidCallback onTap;

  const _PersonalQuizTile({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: colors.accent.withValues(alpha: 0.35)),
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
              child: Icon(Icons.auto_awesome, color: colors.accent),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.programPickerPersonalTitle,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.programPickerPersonalSubtitle,
                    style: TextStyle(fontSize: 12, color: colors.textMuted),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: colors.textMuted),
          ],
        ),
      ),
    );
  }
}

class _CuratedProgramTile extends StatelessWidget {
  final CuratedProgram curated;
  final bool locked;
  final VoidCallback onTap;

  const _CuratedProgramTile({
    required this.curated,
    required this.locked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Opacity(
        opacity: locked ? 0.6 : 1,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colors.cardAlt,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      curated.displayName(context),
                      style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Icon(
                    locked ? Icons.lock_outline : Icons.chevron_right,
                    color: colors.textMuted,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                curated.displayDescription(context),
                style: TextStyle(fontSize: 12.5, color: colors.textSecondary, height: 1.35),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.onboardingFrequencyOptionLabel(curated.program.frequency),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                  color: colors.accent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
