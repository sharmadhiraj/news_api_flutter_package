import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/articles_response.dart';
import 'models/enums.dart';
import 'models/news_api_exception.dart';
import 'models/source.dart';

/// Client for the News API (https://newsapi.org).
///
/// Configure a single shared instance once, e.g. in `main()`:
/// ```dart
/// NewsAPI.init(apiKey: "your_api_key");
/// ```
///
/// and access it anywhere via [instance]:
/// ```dart
/// final response = await NewsAPI.instance.getTopHeadlines(country: NewsCountry.us);
/// ```
class NewsAPI {
  static const String _host = "newsapi.org";
  static const Duration _defaultTimeout = Duration(seconds: 30);

  static NewsAPI? _instance;

  /// Configures the shared [instance], closing any previously configured one.
  ///
  /// Call this once, e.g. in `main()`.
  static void init({
    required String apiKey,
    http.Client? client,
    Duration timeout = _defaultTimeout,
  }) {
    _instance?.close();
    _instance = NewsAPI._(apiKey: apiKey, client: client, timeout: timeout);
  }

  /// The shared instance configured by [init].
  ///
  /// Throws a [StateError] if [init] hasn't been called yet.
  static NewsAPI get instance {
    final instance = _instance;
    if (instance == null) {
      throw StateError(
        "NewsAPI.init() must be called before NewsAPI.instance is used.",
      );
    }
    return instance;
  }

  /// Your News API key. Get one at https://newsapi.org/register.
  final String apiKey;

  final http.Client _client;
  final Duration _timeout;

  NewsAPI._({
    required this.apiKey,
    http.Client? client,
    Duration timeout = _defaultTimeout,
  })  : _client = client ?? http.Client(),
        _timeout = timeout;

  /// Releases the underlying [http.Client]'s resources.
  void close() => _client.close();

  /// Returns the news publishers available through [getTopHeadlines] and [getEverything].
  ///
  /// https://newsapi.org/docs/endpoints/sources
  Future<List<Source>> getSources({
    NewsCategory? category,
    NewsLanguage? language,
    NewsCountry? country,
  }) async {
    final response = await _get("v2/sources", {
      "category": category?.name,
      "language": language?.name,
      "country": country?.code,
    });
    return Source.parseList(response["sources"]);
  }

  /// Searches every article available to your plan, sorted by [sortBy].
  ///
  /// https://newsapi.org/docs/endpoints/everything
  Future<ArticlesResponse> getEverything({
    String? query,
    String? queryInTitle,
    Set<ArticleSearchIn>? searchIn,
    List<String>? sources,
    List<String>? domains,
    List<String>? excludeDomains,
    DateTime? from,
    DateTime? to,
    NewsLanguage? language,
    ArticleSortBy? sortBy,
    int? pageSize,
    int? page,
  }) async {
    final response = await _get("v2/everything", {
      "q": query,
      "qInTitle": queryInTitle,
      "searchIn": _join(searchIn?.map((e) => e.name)),
      "sources": _join(sources),
      "domains": _join(domains),
      "excludeDomains": _join(excludeDomains),
      "from": from?.toUtc().toIso8601String(),
      "to": to?.toUtc().toIso8601String(),
      "language": language?.name,
      "sortBy": sortBy?.name,
      "pageSize": pageSize?.toString(),
      "page": page?.toString(),
    });
    return ArticlesResponse.fromJson(response);
  }

  /// Returns live top and breaking headlines.
  ///
  /// [sources] cannot be combined with [country] or [category], matching the
  /// News API's own restriction.
  ///
  /// https://newsapi.org/docs/endpoints/top-headlines
  Future<ArticlesResponse> getTopHeadlines({
    NewsCountry? country,
    NewsCategory? category,
    List<String>? sources,
    String? query,
    int? pageSize,
    int? page,
  }) async {
    if (sources != null &&
        sources.isNotEmpty &&
        (country != null || category != null)) {
      throw ArgumentError(
        "`sources` cannot be combined with `country` or `category`.",
      );
    }
    final response = await _get("v2/top-headlines", {
      "country": country?.code,
      "category": category?.name,
      "sources": _join(sources),
      "q": query,
      "pageSize": pageSize?.toString(),
      "page": page?.toString(),
    });
    return ArticlesResponse.fromJson(response);
  }

  /// Joins [values] with a comma, or returns `null` if [values] is `null` or empty.
  static String? _join(Iterable<String>? values) {
    if (values == null || values.isEmpty) return null;
    return values.join(",");
  }

  Future<Map<String, dynamic>> _get(
    String path,
    Map<String, String?> queryParameters,
  ) async {
    final params = <String, String>{"apiKey": apiKey};
    queryParameters.forEach((key, value) {
      if (value != null) params[key] = value;
    });

    final http.Response response;
    try {
      response =
          await _client.get(Uri.https(_host, path, params)).timeout(_timeout);
    } on TimeoutException {
      throw NewsApiException(
        code: "timeout",
        message: "The request to the News API timed out after $_timeout.",
      );
    } catch (e) {
      throw NewsApiException(code: "connectionError", message: e.toString());
    }

    dynamic body;
    try {
      body = json.decode(response.body);
    } catch (e) {
      throw NewsApiException(
        code: "unexpectedError",
        message: "Couldn't parse the News API's response: $e",
      );
    }

    if (body is Map<String, dynamic> && body["status"] == "ok") return body;

    final code = body is Map ? body["code"]?.toString() : null;
    final message = body is Map ? body["message"]?.toString() : null;
    throw NewsApiException(
      code: code ?? "unexpectedError",
      message: message ?? "Unexpected response from the News API.",
    );
  }
}
