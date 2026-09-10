import 'package:flutter/material.dart';

import '../../theme/app_palette.dart';

/// Простой рисованный силуэт тела (без фото/датасетов — только формы) с
/// подсветкой мышечной группы. Один общий набор форм переиспользуется для
/// всех групп: у каждой части тела просто разный цвет заливки в зависимости
/// от того, активна она для текущей группы или нет.
class MuscleGroupSilhouette extends StatelessWidget {
  final String muscleGroup;

  const MuscleGroupSilhouette({super.key, required this.muscleGroup});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AspectRatio(
      aspectRatio: 0.62,
      child: CustomPaint(
        painter: _SilhouettePainter(
          muscleGroup: muscleGroup,
          activeColor: colors.accent,
          inactiveColor: colors.cardAlt,
          strokeColor: colors.cardBorder,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _SilhouettePainter extends CustomPainter {
  final String muscleGroup;
  final Color activeColor;
  final Color inactiveColor;
  final Color strokeColor;

  _SilhouettePainter({
    required this.muscleGroup,
    required this.activeColor,
    required this.inactiveColor,
    required this.strokeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final stroke = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    void drawPart(RRect rrect, bool active) {
      final fill = Paint()..color = active ? activeColor : inactiveColor;
      canvas.drawRRect(rrect, fill);
      canvas.drawRRect(rrect, stroke);
    }

    void drawCircle(Offset center, double radius, bool active) {
      final fill = Paint()..color = active ? activeColor : inactiveColor;
      canvas.drawCircle(center, radius, fill);
      canvas.drawCircle(center, radius, stroke);
    }

    final isFullBody = ![
      'Chest',
      'Back',
      'Legs',
      'Shoulders',
      'Arms',
      'Abs',
    ].contains(muscleGroup);

    bool activeFor(String part) {
      if (isFullBody) return true;
      switch (muscleGroup) {
        case 'Chest':
          return part == 'torsoUpper';
        case 'Back':
          return part == 'torsoUpper' || part == 'backWing';
        case 'Legs':
          return part == 'hips' || part == 'legL' || part == 'legR';
        case 'Shoulders':
          return part == 'shoulderL' || part == 'shoulderR';
        case 'Arms':
          return part == 'armL' || part == 'forearmL' || part == 'armR' || part == 'forearmR';
        case 'Abs':
          return part == 'torsoLower';
      }
      return false;
    }

    RRect rr(double x0, double y0, double x1, double y1, double radius) {
      return RRect.fromRectAndRadius(
        Rect.fromLTRB(x0 * w, y0 * h, x1 * w, y1 * h),
        Radius.circular(radius * w),
      );
    }

    // Голова и шея.
    drawCircle(Offset(0.5 * w, 0.10 * h), 0.13 * w, false);
    drawPart(rr(0.44, 0.16, 0.56, 0.205, 0.02), false);

    // "Крылья" верхней спины — рисуются только под группу Back, слегка
    // расширяют силуэт по бокам от торса, обозначая широчайшие.
    if (muscleGroup == 'Back' || isFullBody) {
      drawPart(rr(0.20, 0.205, 0.30, 0.34, 0.03), activeFor('backWing'));
      drawPart(rr(0.70, 0.205, 0.80, 0.34, 0.03), activeFor('backWing'));
    }

    // Плечи (отдельные "шапки" поверх рук — рисуются позже, чтобы быть сверху).
    // Руки: плечо + предплечье.
    drawPart(rr(0.14, 0.205, 0.265, 0.40, 0.035), activeFor('armL'));
    drawPart(rr(0.12, 0.40, 0.245, 0.56, 0.03), activeFor('forearmL'));
    drawPart(rr(0.735, 0.205, 0.86, 0.40, 0.035), activeFor('armR'));
    drawPart(rr(0.755, 0.40, 0.88, 0.56, 0.03), activeFor('forearmR'));

    // Торс: верх (грудь) и низ (пресс) — отдельные части, чтобы подсвечивать раздельно.
    drawPart(rr(0.28, 0.19, 0.72, 0.365, 0.06), activeFor('torsoUpper'));
    drawPart(rr(0.305, 0.365, 0.695, 0.54, 0.05), activeFor('torsoLower'));

    // Плечевые "шапки" поверх торса/рук.
    drawCircle(Offset(0.205 * w, 0.215 * h), 0.075 * w, activeFor('shoulderL'));
    drawCircle(Offset(0.795 * w, 0.215 * h), 0.075 * w, activeFor('shoulderR'));

    // Таз и ноги.
    drawPart(rr(0.30, 0.54, 0.70, 0.615, 0.04), activeFor('hips'));
    drawPart(rr(0.305, 0.615, 0.485, 0.97, 0.04), activeFor('legL'));
    drawPart(rr(0.515, 0.615, 0.695, 0.97, 0.04), activeFor('legR'));
  }

  @override
  bool shouldRepaint(covariant _SilhouettePainter oldDelegate) {
    return oldDelegate.muscleGroup != muscleGroup ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.inactiveColor != inactiveColor ||
        oldDelegate.strokeColor != strokeColor;
  }
}
