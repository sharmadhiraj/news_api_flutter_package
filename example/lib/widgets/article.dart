import 'package:example/screens/detail.dart';
import 'package:flutter/material.dart';
import 'package:news_api_flutter_package/model/article.dart';

class ArticleListVIew extends StatelessWidget {
  const ArticleListVIew({required this.articles, super.key});

  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) => _buildArticleListItem(
        context,
        articles[index],
      ),
    );
  }

  Widget _buildArticleListItem(BuildContext context, Article article) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailScreen(article: article),
            ),
          );
        },
        title: Text(
          article.title!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          article.description ?? article.content ?? "",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: article.urlToImage == null
            ? null
            : SizedBox(
                width: 80,
                child: Image.network(article.urlToImage!),
              ),
      ),
    );
  }
}
