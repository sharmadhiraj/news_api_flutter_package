import 'package:news_api_flutter_package/news_api_flutter_package.dart';
import 'package:test/test.dart';

void main() {
  group("Article.fromJson", () {
    test("defaults missing fields", () {
      final article = Article.fromJson({});

      expect(article.title, "");
      expect(article.url, "");
      expect(article.source.name, "");
      expect(article.author, isNull);
      expect(article.description, isNull);
      expect(article.urlToImage, isNull);
      expect(article.publishedAt, isNull);
      expect(article.content, isNull);
    });

    test(
        "parses a `[Removed]` placeholder article without nulling required fields",
        () {
      final article = Article.fromJson({
        "source": {"id": null, "name": "[Removed]"},
        "author": null,
        "title": "[Removed]",
        "description": "[Removed]",
        "url": "https://removed.com",
        "urlToImage": null,
        "publishedAt": "2026-01-01T00:00:00Z",
        "content": "[Removed]",
      });

      expect(article.title, "[Removed]");
      expect(article.url, "https://removed.com");
      expect(article.source.name, "[Removed]");
    });

    test("leaves publishedAt null when the date can't be parsed", () {
      final article = Article.fromJson({"publishedAt": "not-a-date"});

      expect(article.publishedAt, isNull);
    });

    test("leaves publishedAt null when it isn't a string", () {
      final article = Article.fromJson({"publishedAt": 12345});

      expect(article.publishedAt, isNull);
    });
  });

  group("Article.parseList", () {
    test("returns an empty list for null, non-list or empty input", () {
      expect(Article.parseList(null), isEmpty);
      expect(Article.parseList("not a list"), isEmpty);
      expect(Article.parseList([]), isEmpty);
    });
  });

  group("Source.fromJson", () {
    test("defaults a missing name and leaves the rest null", () {
      final source = Source.fromJson({});

      expect(source.name, "");
      expect(source.id, isNull);
      expect(source.description, isNull);
      expect(source.url, isNull);
      expect(source.category, isNull);
      expect(source.language, isNull);
      expect(source.country, isNull);
    });

    test("only populates id and name when nested inside an article", () {
      final source = Source.fromJson({"id": "bbc-news", "name": "BBC News"});

      expect(source.id, "bbc-news");
      expect(source.name, "BBC News");
      expect(source.category, isNull);
    });
  });

  group("Source.parseList", () {
    test("returns an empty list for null or non-list input", () {
      expect(Source.parseList(null), isEmpty);
      expect(Source.parseList("not a list"), isEmpty);
    });
  });

  group("ArticlesResponse.fromJson", () {
    test("defaults a missing totalResults to 0 and missing articles to []", () {
      final response = ArticlesResponse.fromJson({});

      expect(response.totalResults, 0);
      expect(response.articles, isEmpty);
    });
  });
}
