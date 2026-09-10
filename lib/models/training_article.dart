/// Короткая обучающая статья со статическим контентом (см.
/// [TrainingArticles]). Текст пока только на английском — локализация
/// контента отдельной задачей позже; интерфейс вокруг статей (заголовки
/// экранов, кнопки) локализован как обычно через [AppLocalizations].
class TrainingArticle {
  final String id;
  final String title;
  final String category;
  final List<String> paragraphs;

  const TrainingArticle({
    required this.id,
    required this.title,
    required this.category,
    required this.paragraphs,
  });
}
