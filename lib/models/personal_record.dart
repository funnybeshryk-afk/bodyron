/// Личный рекорд по упражнению: лучший подход по оценочному 1ПМ
/// (формула Эпли), среди упражнений, встречавшихся в истории минимум дважды.
class PersonalRecord {
  final String exerciseName;
  final String muscleGroup;
  final double weight;
  final int reps;
  final DateTime date;

  const PersonalRecord({
    required this.exerciseName,
    required this.muscleGroup,
    required this.weight,
    required this.reps,
    required this.date,
  });

  double get estimated1Rm => reps <= 1 ? weight : weight * (1 + reps / 30);
}
