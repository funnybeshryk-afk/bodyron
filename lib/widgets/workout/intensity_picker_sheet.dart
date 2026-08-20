import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../models/active_exercise.dart';
import '../../models/workout_set_entry.dart';
import '../../data/workout_session_store.dart';
import '../../theme/app_palette.dart';
import 'intensity_selector.dart';

/// Открывает bottom sheet для выбора интенсивности подхода:
/// RPE (1-10, шаг 0.5) либо отметка "до отказа".
Future<void> showIntensityPickerSheet({
  required BuildContext context,
  required WorkoutSessionStore store,
  required ActiveExercise entry,
  required WorkoutSetEntry set,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: context.colors.card,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) => _IntensityPickerContent(
      store: store,
      entry: entry,
      set: set,
    ),
  );
}

class _IntensityPickerContent extends StatefulWidget {
  final WorkoutSessionStore store;
  final ActiveExercise entry;
  final WorkoutSetEntry set;

  const _IntensityPickerContent({
    required this.store,
    required this.entry,
    required this.set,
  });

  @override
  State<_IntensityPickerContent> createState() => _IntensityPickerContentState();
}

class _IntensityPickerContentState extends State<_IntensityPickerContent> {
  late bool _toFailure = widget.set.toFailure;
  late double _rpe = widget.set.rpe ?? 8;

  void _save() {
    if (_toFailure) {
      widget.store.setSetToFailure(widget.entry, widget.set);
    } else {
      widget.store.setSetRpe(widget.entry, widget.set, _rpe);
    }
    Navigator.pop(context);
  }

  void _clear() {
    widget.store.clearSetIntensity(widget.entry, widget.set);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.setIntensityTitle,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 18),
            SegmentedButton<bool>(
              segments: [
                ButtonSegment(
                  value: false,
                  label: Text(l10n.rpeLabel),
                  icon: const Icon(Icons.speed, size: 16),
                ),
                ButtonSegment(
                  value: true,
                  label: Text(l10n.toFailureLabel),
                  icon: const Icon(Icons.whatshot, size: 16),
                ),
              ],
              selected: {_toFailure},
              onSelectionChanged: (selection) =>
                  setState(() => _toFailure = selection.first),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return colors.accent;
                  }
                  return colors.cardAlt;
                }),
                foregroundColor: WidgetStateProperty.resolveWith((states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.white;
                  }
                  return colors.textSecondary;
                }),
              ),
            ),
            const SizedBox(height: 22),
            if (!_toFailure) ...[
              Text(
                l10n.rpeValue(IntensitySelector.formatRpe(_rpe)),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: colors.accent,
                  thumbColor: colors.accent,
                  inactiveTrackColor: colors.cardAlt,
                ),
                child: Slider(
                  value: _rpe,
                  min: 1,
                  max: 10,
                  divisions: 18,
                  onChanged: (value) => setState(() => _rpe = value),
                ),
              ),
            ] else
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(
                  l10n.toFailureDescription,
                  style: TextStyle(color: colors.textMuted, fontSize: 13),
                ),
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                if (widget.set.hasIntensity) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _clear,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colors.textSecondary,
                        side: BorderSide(color: colors.cardBorder),
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(l10n.clear),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.accent,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      l10n.save,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
