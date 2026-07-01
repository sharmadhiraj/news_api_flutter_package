import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';

class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({required this.article, super.key});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(article.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage != null && article.urlToImage!.isNotEmpty)
              Image.network(
                article.urlToImage!,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
              ),
            const SizedBox(height: 16),
            Text(
              article.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              _subtitle(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            Text(article.description ?? ""),
            const SizedBox(height: 8),
            Text(article.content ?? ""),
          ],
        ),
      ),
    );
  }

  String _subtitle() {
    final parts = <String>[
      if (article.source.name.isNotEmpty) article.source.name,
      if (article.author != null && article.author!.trim().isNotEmpty)
        article.author!,
      if (article.publishedAt != null)
        article.publishedAt!.toLocal().toString().split(".").first,
    ];
    return parts.join(" · ");
  }
}
