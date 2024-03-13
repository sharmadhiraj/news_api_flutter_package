import 'dart:async';

import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/model/source.dart';
import 'package:news_api_flutter_package/util.dart';

/// A class for interacting with the News API.
class NewsAPI {
  /// The API key used for authentication.
  final String apiKey;

  /// Creates a [NewsAPI] instance with the given [apiKey].
  NewsAPI({required this.apiKey});

  /// Fetches a list of news sources from the API.
  ///
  /// Optional parameters:
  ///  - [category]: The category of news sources to retrieve.
  ///  - [language]: The language of news sources to retrieve.
  ///  - [country]: The country of news sources to retrieve.
  Future<List<Source>> getSources({
    String? category,
    String? language,
    String? country,
  }) async {
    final String url = Util.buildSourcesUrl(
      "sources",
      category,
      language,
      country,
    );
    final dynamic response = await Util.call(
      apiKey: apiKey,
      url: url,
      dataKey: "sources",
    );
    return Source.parseList(response);
  }

  /// Fetches a list of articles based on the provided query parameters.
  ///
  /// Optional parameters:
  ///  - [query]: The search query.
  ///  - [queryInTitle]: Search for articles with the query term in the title.
  ///  - [sources]: A comma-separated list of source IDs or domains.
  ///  - [domains]: A comma-separated list of domains (e.g., bbc.co.uk, techcrunch.com).
  ///  - [excludeDomains]: A comma-separated list of domains to exclude.
  ///  - [from]: The earliest date (YYYY-MM-DD or YYYY-MM-DDTHH:mm:ss) to retrieve articles from.
  ///  - [to]: The latest date (YYYY-MM-DD or YYYY-MM-DDTHH:mm:ss) to retrieve articles to.
  ///  - [language]: The language of the articles.
  ///  - [sortBy]: The order to sort articles in.
  ///  - [pageSize]: The number of articles per page.
  ///  - [page]: The page number to retrieve.
  Future<List<Article>> getEverything({
    String? query,
    String? queryInTitle,
    String? sources,
    String? domains,
    String? excludeDomains,
    DateTime? from,
    DateTime? to,
    String? language,
    String? sortBy,
    int? pageSize,
    int? page,
  }) async {
    final String url = Util.buildEverythingUrl(
      query,
      queryInTitle,
      sources,
      domains,
      excludeDomains,
      from,
      to,
      language,
      sortBy,
      pageSize,
      page,
    );
    final dynamic response = await Util.call(
      apiKey: apiKey,
      url: url,
      dataKey: "articles",
    );
    return Article.parseList(response);
  }

  /// Fetches a list of top headlines based on the provided query parameters.
  ///
  /// Optional parameters:
  ///  - [country]: The 2-letter ISO 3166-1 code of the country to retrieve headlines for.
  ///  - [category]: The category of articles to retrieve.
  ///  - [sources]: A comma-separated list of source IDs or domains.
  ///  - [query]: The search query.
  ///  - [pageSize]: The number of articles per page.
  ///  - [page]: The page number to retrieve.
  Future<List<Article>> getTopHeadlines({
    String? country,
    String? category,
    String? sources,
    String? query,
    int? pageSize,
    int? page,
  }) async {
    final String url = Util.buildTopHeadlinesUrl(
      country,
      category,
      sources,
      query,
      pageSize,
      page,
    );
    final dynamic response = await Util.call(
      apiKey: apiKey,
      url: url,
      dataKey: "articles",
    );
    return Article.parseList(response);
  }
}
