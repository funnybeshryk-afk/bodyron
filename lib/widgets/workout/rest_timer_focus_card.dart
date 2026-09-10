import 'package:flutter/material.dart';

import '../../data/workout_session_store.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

/// Крупное состояние таймера отдыха между подходами в пошаговом режиме
/// Тренировки (см. Phase 1 ТЗ, п.4: "крупно '1:30 ОТДЫХ'"). Логика таймера
/// (в т.ч. фоновое OS-уведомление) не меняется — это только визуальный
/// слой над уже существующими [WorkoutSessionStore.adjustRestTimer]/
/// [WorkoutSessionStore.skipRestTimer]. Не заменяет компактный
/// [RestTimerBanner], который продолжает работать поверх других вкладок.
class RestTimerFocusCard extends StatelessWidget {
  final WorkoutSessionStore store;

  const RestTimerFocusCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final minutes = (store.restRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (store.restRemaining % 60).toString().padLeft(2, '0');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
      decoration: BoxDecoration(
        color: colors.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colors.accent.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            l10n.restLabel,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.5,
              color: colors.textMuted,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$minutes:$seconds',
            style: TextStyle(fontSize: 56, fontWeight: FontWeight.w900, color: colors.accent),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _RestAdjustButton(label: '−15', onTap: () => store.adjustRestTimer(-15)),
              const SizedBox(width: 10),
              TextButton(
                onPressed: store.skipRestTimer,
                child: Text(
                  l10n.restSkipButton,
                  style: TextStyle(fontWeight: FontWeight.w800, color: colors.textSecondary),
                ),
              ),
              const SizedBox(width: 10),
              _RestAdjustButton(label: '+15', onTap: () => store.adjustRestTimer(15)),
            ],
          ),
        ],
      ),
    );
  }
}

class _RestAdjustButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _RestAdjustButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: colors.textPrimary),
        ),
      ),
    );
  }
}
