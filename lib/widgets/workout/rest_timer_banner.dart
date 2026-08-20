import 'package:flutter/material.dart';

import '../../data/workout_session_store.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

/// Компактный оверлей-баннер таймера отдыха. Показывается поверх любого
/// таба (живёт на уровне [MainScreen]), не блокирует остальной интерфейс.
class RestTimerBanner extends StatelessWidget {
  final WorkoutSessionStore store;

  const RestTimerBanner({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final visible = store.isResting || store.restJustCompleted;

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: !visible
              ? const SizedBox.shrink(key: ValueKey('rest-hidden'))
              : _BannerContent(store: store, key: const ValueKey('rest-visible')),
        );
      },
    );
  }
}

class _BannerContent extends StatelessWidget {
  final WorkoutSessionStore store;

  const _BannerContent({
    super.key,
    required this.store,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;
    final done = store.restJustCompleted;
    final minutes = (store.restRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (store.restRemaining % 60).toString().padLeft(2, '0');

    // "done" всегда на сплошном зелёном — белый текст читаем в обеих темах.
    // Обычное состояние — на карточном фоне темы, поэтому текст берём из неё.
    final onSurfaceColor = done ? Colors.white : colors.textPrimary;
    final onSurfaceMuted = done ? Colors.white70 : colors.textSecondary;

    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: done ? colors.success : colors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: done ? colors.success : colors.accent.withValues(alpha: 0.4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              done ? Icons.check_circle : Icons.timer_outlined,
              color: onSurfaceColor,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    done ? l10n.restCompleteLabel : l10n.restLabel,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      color: onSurfaceMuted,
                    ),
                  ),
                  if (!done)
                    Text(
                      '$minutes:$seconds',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: onSurfaceColor,
                      ),
                    ),
                ],
              ),
            ),
            if (!done) ...[
              _RestAdjustButton(label: '-15', onTap: () => store.adjustRestTimer(-15)),
              const SizedBox(width: 6),
              _RestAdjustButton(label: '+15', onTap: () => store.adjustRestTimer(15)),
              const SizedBox(width: 4),
              IconButton(
                onPressed: store.skipRestTimer,
                icon: Icon(Icons.close, color: colors.textSecondary),
                tooltip: l10n.skipRestTooltip,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RestAdjustButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _RestAdjustButton({
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: colors.cardAlt,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: colors.textPrimary),
        ),
      ),
    );
  }
}
