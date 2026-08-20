import 'package:flutter/material.dart';

import '../theme/app_palette.dart';

/// Небольшая ненавязчивая карточка-тизер PRO-фичи: заголовок + подзаголовок,
/// без реального пейволла (Billing будет добавлен позже).
class ProTeaserCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const ProTeaserCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.lock_outline,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.cardAlt,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.accent, colors.accentDark],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 11.5, color: colors.textMuted, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
