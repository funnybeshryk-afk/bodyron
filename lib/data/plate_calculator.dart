/// Результат разбивки веса на блины для одной стороны штанги.
class PlateBreakdown {
  final List<double> platesPerSide;
  final double perSideWeight;
  final double totalWeight;
  final double requestedWeight;
  final bool isExact;
  final bool belowBar;

  const PlateBreakdown({
    required this.platesPerSide,
    required this.perSideWeight,
    required this.totalWeight,
    required this.requestedWeight,
    required this.isExact,
    required this.belowBar,
  });
}

/// Считает, какие блины повесить с каждой стороны штанги для целевого веса.
/// Набор блинов и вес грифа — стандартные константы (пока не настраиваются
/// пользователем).
class PlateCalculator {
  PlateCalculator._();

  static const double defaultBarWeightKg = 20;

  static const List<double> availablePlatesKg = [25, 20, 15, 10, 5, 2.5, 1.25];

  static const double _smallestPlateKg = 1.25;

  static PlateBreakdown calculate({
    required double targetWeight,
    double barWeight = defaultBarWeightKg,
  }) {
    final rawPerSide = (targetWeight - barWeight) / 2;

    if (rawPerSide <= 0) {
      return PlateBreakdown(
        platesPerSide: const [],
        perSideWeight: 0,
        totalWeight: barWeight,
        requestedWeight: targetWeight,
        isExact: targetWeight == barWeight,
        belowBar: targetWeight < barWeight,
      );
    }

    // Ближайший достижимый вес на сторону — кратный минимальному блину.
    final roundedPerSide =
        (rawPerSide / _smallestPlateKg).round() * _smallestPlateKg;

    final plates = <double>[];
    var remaining = roundedPerSide;
    for (final plate in availablePlatesKg) {
      while (remaining + 1e-9 >= plate) {
        plates.add(plate);
        remaining -= plate;
      }
    }

    final achievedTotal = barWeight + roundedPerSide * 2;

    return PlateBreakdown(
      platesPerSide: plates,
      perSideWeight: roundedPerSide,
      totalWeight: achievedTotal,
      requestedWeight: targetWeight,
      isExact: (achievedTotal - targetWeight).abs() < 0.001,
      belowBar: false,
    );
  }
}
