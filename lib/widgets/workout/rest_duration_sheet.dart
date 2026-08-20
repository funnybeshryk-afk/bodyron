import 'package:flutter/material.dart';

import '../../data/workout_session_store.dart';
import '../../l10n/app_localizations.dart';
import '../../theme/app_palette.dart';

/// Bottom sheet для настройки длительности таймера отдыха по умолчанию.
Future<void> showRestDurationSheet({
  required BuildContext context,
  required WorkoutSessionStore store,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: context.colors.card,
    builder: (context) => _RestDurationSheetContent(store: store),
  );
}

class _RestDurationSheetContent extends StatelessWidget {
  final WorkoutSessionStore store;

  const _RestDurationSheetContent({required this.store});

  static const List<int> _options = [30, 60, 90, 120, 150, 180];

  static String _label(int seconds) => seconds < 60
      ? '${seconds}s'
      : '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.defaultRestTimeTitle,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _options.map((seconds) {
                    final active = store.restDurationSeconds == seconds;

                    return ChoiceChip(
                      label: Text(_label(seconds)),
                      selected: active,
                      onSelected: (_) => store.setDefaultRestDuration(seconds),
                      selectedColor: colors.accent,
                      backgroundColor: colors.cardAlt,
                      labelStyle: TextStyle(
                        color: active ? Colors.white : colors.textSecondary,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
