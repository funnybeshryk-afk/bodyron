/// Одна запись веса тела.
class BodyWeightEntry {
  final DateTime date;
  final double weightKg;

  const BodyWeightEntry({
    required this.date,
    required this.weightKg,
  });

  Map<String, Object?> toMap() {
    return {
      'date': date.toIso8601String(),
      'weight_kg': weightKg,
    };
  }

  factory BodyWeightEntry.fromMap(Map<String, Object?> map) {
    return BodyWeightEntry(
      date: DateTime.parse(map['date'] as String),
      weightKg: (map['weight_kg'] as num).toDouble(),
    );
  }
}
