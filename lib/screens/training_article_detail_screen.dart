import 'package:flutter/material.dart';

import '../l10n/article_content_l10n.dart';
import '../models/training_article.dart';
import '../theme/app_palette.dart';

/// Экран чтения одной статьи — обычная push-навигация, без своего таба
/// в нижней панели.
class TrainingArticleDetailScreen extends StatelessWidget {
  final TrainingArticle article;

  const TrainingArticleDetailScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                article.displayCategory(context).toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                  color: colors.accent,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                article.displayTitle(context),
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, height: 1.15),
              ),
              const SizedBox(height: 20),
              for (final paragraph in article.displayParagraphs(context))
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    paragraph,
                    style: TextStyle(fontSize: 15.5, height: 1.5, color: colors.textSecondary),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
