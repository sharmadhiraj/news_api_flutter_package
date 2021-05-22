import 'package:news_api_flutter_package/model/source.dart';

class Article {
  final Source source;
  final String? author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content;

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

  static List<Article> parseList(List<dynamic> list) {
    return list.map((e) => Article.fromJson(e)).toList();
  }
}
