import 'source.dart';

/// A news article returned by `getEverything` or `getTopHeadlines`.
class Article {
  /// The article's publisher.
  final Source source;

  /// The article's headline.
  final String title;

  /// The direct link to the article.
  final String url;

  /// The article's author, if known.
  final String? author;

  /// A short summary of the article, if available.
  final String? description;

  /// The URL of the article's image, if available.
  final String? urlToImage;

  /// When the article was published, if the API returned a parseable date.
  final DateTime? publishedAt;

  /// The (possibly truncated) body of the article, if available.
  final String? content;

  /// Creates an [Article] with the given field values.
  const Article({
    required this.source,
    required this.title,
    required this.url,
    this.author,
    this.description,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  /// Parses an [Article] from the News API's JSON representation.
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      source: Source.fromJson(json["source"] ?? const {}),
      title: json["title"] ?? "",
      url: json["url"] ?? "",
      author: json["author"],
      description: json["description"],
      urlToImage: json["urlToImage"],
      publishedAt: json["publishedAt"] is String
          ? DateTime.tryParse(json["publishedAt"])
          : null,
      content: json["content"],
    );
  }

  /// Parses a JSON list into [Article]s, or returns `[]` if [list] isn't a list.
  static List<Article> parseList(dynamic list) {
    if (list is! List) return [];
    return list.map((e) => Article.fromJson(e)).toList();
  }
}
