import 'package:flutter/material.dart';

import '../../theme/app_palette.dart';

/// Компактный степпер [-] значение [+] для веса/повторений.
class NumberStepper extends StatelessWidget {
  final double value;
  final double step;
  final int decimals;
  final bool enabled;
  final double min;
  final ValueChanged<double> onChanged;

  const NumberStepper({
    super.key,
    required this.value,
    required this.step,
    required this.onChanged,
    this.decimals = 1,
    this.enabled = true,
    this.min = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepIconButton(
          icon: Icons.remove,
          onTap: enabled
              ? () {
                  final next = value - step;
                  onChanged(next < min ? min : next);
                }
              : null,
        ),
        SizedBox(
          width: 44,
          child: Text(
            value.toStringAsFixed(decimals),
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
          ),
        ),
        _StepIconButton(
          icon: Icons.add,
          onTap: enabled ? () => onChanged(value + step) : null,
        ),
      ],
    );
  }
}

class _StepIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _StepIconButton({
    required this.icon,
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
        width: 26,
        height: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colors.card,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 14,
          color: disabled ? colors.textFaint : colors.textSecondary,
        ),
      ),
    );
  }
}
