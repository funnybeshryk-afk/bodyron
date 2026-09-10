import 'package:flutter/material.dart';

import '../../theme/app_palette.dart';

/// Степпер [-] значение [+] для веса/повторений. [large] — увеличенная
/// версия для фокусного текущего подхода в пошаговом режиме Тренировки
/// (см. CurrentSetEditor) — обычный размер используется в компактных
/// строках уже выполненных подходов (см. SetEntryRow).
class NumberStepper extends StatelessWidget {
  final double value;
  final double step;
  final int decimals;
  final bool enabled;
  final double min;
  final bool large;
  final ValueChanged<double> onChanged;

  const NumberStepper({
    super.key,
    required this.value,
    required this.step,
    required this.onChanged,
    this.decimals = 1,
    this.enabled = true,
    this.min = 0,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = large ? 44.0 : 26.0;
    final iconSize = large ? 22.0 : 14.0;
    final valueWidth = large ? 76.0 : 44.0;
    final fontSize = large ? 22.0 : 13.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepIconButton(
          icon: Icons.remove,
          size: buttonSize,
          iconSize: iconSize,
          onTap: enabled
              ? () {
                  final next = value - step;
                  onChanged(next < min ? min : next);
                }
              : null,
        ),
        SizedBox(
          width: valueWidth,
          child: Text(
            value.toStringAsFixed(decimals),
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: fontSize),
          ),
        ),
        _StepIconButton(
          icon: Icons.add,
          size: buttonSize,
          iconSize: iconSize,
          onTap: enabled ? () => onChanged(value + step) : null,
        ),
      ],
    );
  }
}

class _StepIconButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final double iconSize;
  final VoidCallback? onTap;

  const _StepIconButton({
    required this.icon,
    required this.size,
    required this.iconSize,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;
    final colors = context.colors;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: disabled ? colors.textFaint : colors.textSecondary,
        ),
      ),
    );
  }
}
