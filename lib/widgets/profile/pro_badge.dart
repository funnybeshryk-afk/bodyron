import 'package:flutter/material.dart';

import '../../theme/app_palette.dart';

class ProBadge extends StatelessWidget {
  final String label;

  const ProBadge({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.accent, colors.accentDark],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
          // Бейдж всегда на фирменном градиенте — текст остаётся белым в
          // обеих темах.
          color: Colors.white,
        ),
      ),
    );
  }
}
