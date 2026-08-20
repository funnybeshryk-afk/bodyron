/// Определение упражнения в библиотеке: либо встроенное, либо
/// добавленное пользователем вручную.
class ExerciseDefinition {
  final String name;
  final String muscleGroup;
  final bool isCustom;

  const ExerciseDefinition({
    required this.name,
    required this.muscleGroup,
    this.isCustom = false,
  });

  /// Только пользовательские упражнения сохраняются в БД — встроенная
  /// библиотека ([ExerciseLibrary]) остаётся статичным контентом приложения.
  Map<String, Object?> toMap() {
    return {
      'name': name,
      'muscle_group': muscleGroup,
    };
  }

  factory ExerciseDefinition.fromMap(Map<String, Object?> map) {
    return ExerciseDefinition(
      name: map['name'] as String,
      muscleGroup: map['muscle_group'] as String,
      isCustom: true,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is ExerciseDefinition &&
      other.name.toLowerCase() == name.toLowerCase();

  @override
  int get hashCode => name.toLowerCase().hashCode;
}
