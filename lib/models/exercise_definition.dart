/// Определение упражнения в библиотеке: либо встроенное, либо
/// добавленное пользователем вручную.
class ExerciseDefinition {
  final String name;
  final String muscleGroup;
  final bool isCustom;

  /// Короткие советы по технике (2-4 шт) и частая ошибка — заполнены только
  /// для встроенной библиотеки ([ExerciseLibrary]); у пользовательских
  /// упражнений всегда пусто, так как это статический контент приложения,
  /// а не то, что вводит пользователь. Ничего из этого не сохраняется в БД.
  final List<String> tips;
  final String commonMistake;

  const ExerciseDefinition({
    required this.name,
    required this.muscleGroup,
    this.isCustom = false,
    this.tips = const [],
    this.commonMistake = '',
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
