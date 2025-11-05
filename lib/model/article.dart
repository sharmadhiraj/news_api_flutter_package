import 'package:news_api_flutter_package/model/source.dart';

/// Represents a news article retrieved from the News API.
class Article {
  /// The source of the article.
  final Source source;

  /// The author of the article.
  final String? author;

  /// The title of the article.
  final String? title;

  /// A short description or summary of the article.
  final String? description;

  /// The direct URL to the article.
  final String? url;

  /// The URL of the article’s image (if available).
  final String? urlToImage;

  /// The publication date and time of the article in ISO 8601 format.
  final String? publishedAt;

  /// The full content of the article (if available).
  final String? content;

  /// Creates an [Article] instance with the provided details.
  Article(
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  );

  /// Creates an [Article] object from a JSON map.
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      Source.fromJson(json["source"]),
      json["author"],
      json["title"],
      json["description"],
      json["url"],
      json["urlToImage"],
      json["publishedAt"],
      json["content"],
    );
  }

  /// Parses a list of JSON objects into a list of [Article] instances.
  /// Returns an empty list if [list] is `null`, not a list, or empty.
  static List<Article> parseList(dynamic list) {
    if (list == null || list is! List || list.isEmpty) return [];
    return list.map((e) => Article.fromJson(e)).toList();
  }
}
