import 'package:flutter/material.dart';

import '../data/training_articles.dart';
import '../l10n/app_localizations.dart';
import '../l10n/article_content_l10n.dart';
import '../theme/app_palette.dart';
import 'training_article_detail_screen.dart';

/// Список обучающих статей — обычная push-навигация из карточки "Learn"
/// на Dashboard, без своего таба в нижней панели.
class TrainingArticlesScreen extends StatelessWidget {
  const TrainingArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 15),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(width: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.trainingArticlesScreenEyebrow,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                          color: colors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        l10n.trainingArticlesScreenTitle,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                itemCount: TrainingArticles.all.length,
                separatorBuilder: (_, _) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final article = TrainingArticles.all[index];

                  return InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TrainingArticleDetailScreen(article: article),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colors.card,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: colors.cardBorder),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.displayCategory(context).toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.6,
                                    color: colors.accent,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  article.displayTitle(context),
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.chevron_right, color: colors.textMuted),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
