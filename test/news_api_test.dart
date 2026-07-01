import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';
import 'package:test/test.dart';

void main() {
  group("getTopHeadlines", () {
    test("parses articles and totalResults", () async {
      NewsAPI.init(
        apiKey: "test_key",
        client: MockClient((request) async {
          expect(request.url.path, "/v2/top-headlines");
          expect(request.url.queryParameters["country"], "us");
          expect(request.url.queryParameters["apiKey"], "test_key");
          return http.Response(
            jsonEncode({
              "status": "ok",
              "totalResults": 1,
              "articles": [
                {
                  "source": {"id": "bbc-news", "name": "BBC News"},
                  "title": "Headline",
                  "publishedAt": "2026-01-01T00:00:00Z",
                },
              ],
            }),
            200,
          );
        }),
      );

      final response =
          await NewsAPI.instance.getTopHeadlines(country: NewsCountry.us);

      expect(response.totalResults, 1);
      expect(response.articles, hasLength(1));
      expect(response.articles.single.title, "Headline");
      expect(response.articles.single.source.name, "BBC News");
      expect(
        response.articles.single.publishedAt,
        DateTime.utc(2026, 1, 1),
      );
    });

    test("throws ArgumentError when sources is combined with country", () {
      NewsAPI.init(apiKey: "test_key");

      expect(
        () => NewsAPI.instance
            .getTopHeadlines(country: NewsCountry.us, sources: ["bbc-news"]),
        throwsArgumentError,
      );
    });

    test("allows an empty sources list alongside country", () async {
      NewsAPI.init(
        apiKey: "test_key",
        client: MockClient((request) async {
          expect(request.url.queryParameters.containsKey("sources"), isFalse);
          return http.Response(
            jsonEncode({"status": "ok", "totalResults": 0, "articles": []}),
            200,
          );
        }),
      );

      await expectLater(
        NewsAPI.instance.getTopHeadlines(country: NewsCountry.us, sources: []),
        completes,
      );
    });

    test("throws NewsApiException on error response", () async {
      NewsAPI.init(
        apiKey: "invalid_key",
        client: MockClient((request) async {
          return http.Response(
            jsonEncode({
              "status": "error",
              "code": "apiKeyInvalid",
              "message": "Your API key is invalid.",
            }),
            401,
          );
        }),
      );

      expect(
        () => NewsAPI.instance.getTopHeadlines(),
        throwsA(
          isA<NewsApiException>()
              .having((e) => e.code, "code", "apiKeyInvalid")
              .having((e) => e.message, "message", "Your API key is invalid."),
        ),
      );
    });

    test(
        "throws NewsApiException instead of a raw FormatException on a non-JSON response",
        () async {
      NewsAPI.init(
        apiKey: "test_key",
        client: MockClient((request) async {
          return http.Response("<html>Bad Gateway</html>", 502);
        }),
      );

      expect(
        () => NewsAPI.instance.getTopHeadlines(),
        throwsA(isA<NewsApiException>()),
      );
    });

    test(
        "falls back instead of using the literal string \"null\" when code/message are missing",
        () async {
      NewsAPI.init(
        apiKey: "test_key",
        client: MockClient((request) async {
          return http.Response(jsonEncode({"status": "error"}), 500);
        }),
      );

      expect(
        () => NewsAPI.instance.getTopHeadlines(),
        throwsA(
          isA<NewsApiException>()
              .having((e) => e.code, "code", "unexpectedError")
              .having(
                (e) => e.message,
                "message",
                "Unexpected response from the News API.",
              ),
        ),
      );
    });

    test("throws NewsApiException when the request exceeds the timeout",
        () async {
      NewsAPI.init(
        apiKey: "test_key",
        timeout: const Duration(milliseconds: 1),
        client: MockClient((request) async {
          await Future.delayed(const Duration(milliseconds: 50));
          return http.Response(
            jsonEncode({"status": "ok", "totalResults": 0, "articles": []}),
            200,
          );
        }),
      );

      expect(
        () => NewsAPI.instance.getTopHeadlines(),
        throwsA(
          isA<NewsApiException>().having((e) => e.code, "code", "timeout"),
        ),
      );
    });
  });

  group("getEverything", () {
    test("builds all supported query parameters", () async {
      NewsAPI.init(
        apiKey: "test_key",
        client: MockClient((request) async {
          final params = request.url.queryParameters;
          expect(params["q"], "flutter");
          expect(params["searchIn"], "title,description");
          expect(params["sources"], "bbc-news,cnn");
          expect(params["language"], "en");
          expect(params["sortBy"], "publishedAt");
          expect(params["from"], "2026-01-01T00:00:00.000Z");
          return http.Response(
            jsonEncode({"status": "ok", "totalResults": 0, "articles": []}),
            200,
          );
        }),
      );

      await NewsAPI.instance.getEverything(
        query: "flutter",
        searchIn: {ArticleSearchIn.title, ArticleSearchIn.description},
        sources: ["bbc-news", "cnn"],
        language: NewsLanguage.en,
        sortBy: ArticleSortBy.publishedAt,
        from: DateTime.utc(2026, 1, 1),
      );
    });

    test("omits searchIn/sources/domains/excludeDomains when given empty lists",
        () async {
      NewsAPI.init(
        apiKey: "test_key",
        client: MockClient((request) async {
          final params = request.url.queryParameters;
          expect(params.containsKey("searchIn"), isFalse);
          expect(params.containsKey("sources"), isFalse);
          expect(params.containsKey("domains"), isFalse);
          expect(params.containsKey("excludeDomains"), isFalse);
          return http.Response(
            jsonEncode({"status": "ok", "totalResults": 0, "articles": []}),
            200,
          );
        }),
      );

      await NewsAPI.instance.getEverything(
        searchIn: {},
        sources: [],
        domains: [],
        excludeDomains: [],
      );
    });
  });

  group("getSources", () {
    test("uses `in` as the country code for India", () async {
      NewsAPI.init(
        apiKey: "test_key",
        client: MockClient((request) async {
          expect(request.url.queryParameters["country"], "in");
          return http.Response(
            jsonEncode({"status": "ok", "sources": []}),
            200,
          );
        }),
      );

      await NewsAPI.instance.getSources(country: NewsCountry.india);
    });
  });
}
