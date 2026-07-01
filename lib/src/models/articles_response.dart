import 'article.dart';

/// The result of `getEverything` or `getTopHeadlines`.
class ArticlesResponse {
  /// The total number of articles matching the request, across all pages.
  final int totalResults;

  /// The articles for the requested page.
  final List<Article> articles;

  /// Creates an [ArticlesResponse] with the given field values.
  const ArticlesResponse({required this.totalResults, required this.articles});

  /// Parses an [ArticlesResponse] from the News API's JSON representation.
  factory ArticlesResponse.fromJson(Map<String, dynamic> json) {
    return ArticlesResponse(
      totalResults: json["totalResults"] is int ? json["totalResults"] : 0,
      articles: Article.parseList(json["articles"]),
    );
  }
}
