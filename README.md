# News API Flutter Package

[![pub package](https://img.shields.io/pub/v/news_api_flutter_package.svg)](https://pub.dev/packages/news_api_flutter_package)
[![CI](https://github.com/sharmadhiraj/news_api_flutter_package/actions/workflows/ci.yml/badge.svg)](https://github.com/sharmadhiraj/news_api_flutter_package/actions/workflows/ci.yml)
[![License: Apache-2.0](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](https://github.com/sharmadhiraj/news_api_flutter_package/blob/master/LICENSE)

A Dart/Flutter client for [News API](https://newsapi.org/), with type-safe parameters, structured
responses, and no unnecessary dependencies.

## Getting Started

* [Installation Guide](https://pub.dev/packages/news_api_flutter_package/install)
* [Example Project](https://github.com/sharmadhiraj/news_api_flutter_package/tree/master/example)
* [Get an API key](https://newsapi.org/register)

## Initialization

Configure a shared instance once, e.g. in `main()`:

```
NewsAPI.init(apiKey: "your_api_key");
```

Then use it anywhere via `NewsAPI.instance` (throws `StateError` if called before `init()`):

```
final response = await NewsAPI.instance.getTopHeadlines(country: NewsCountry.us);
```

`NewsAPI.instance` lives for your app's lifetime, so you don't need to call `close()` on it.

## Top Headlines

```
final response = await NewsAPI.instance.getTopHeadlines(country: NewsCountry.us);
print(response.totalResults);
print(response.articles);
```

| Parameter  | Type                            | Notes                                                     |
|------------|---------------------------------|-----------------------------------------------------------|
| `country`  | [`NewsCountry?`][NewsCountry]   | Cannot be combined with `sources`.                        |
| `category` | [`NewsCategory?`][NewsCategory] | Cannot be combined with `sources`.                        |
| `sources`  | `List<String>?`                 | Source IDs. Cannot be combined with `country`/`category`. |
| `query`    | `String?`                       | Keywords or phrase to search for.                         |
| `pageSize` | `int?`                          | Results per page (max 100).                               |
| `page`     | `int?`                          | Page number.                                              |

[Endpoint details](https://newsapi.org/docs/endpoints/top-headlines)

## Everything

```
final response = await NewsAPI.instance.getEverything(
  query: "bitcoin",
  language: NewsLanguage.en,
  sortBy: ArticleSortBy.publishedAt,
);
```

| Parameter        | Type                            | Notes                                          |
|------------------|---------------------------------|------------------------------------------------|
| `query`          | `String?`                       | Keywords or phrase to search for.              |
| `queryInTitle`   | `String?`                       | Keywords or phrase, restricted to the title.   |
| `searchIn`       | `Set<ArticleSearchIn>?`         | Fields to search: title, description, content. |
| `sources`        | `List<String>?`                 | Source IDs.                                    |
| `domains`        | `List<String>?`                 | Domains to include.                            |
| `excludeDomains` | `List<String>?`                 | Domains to exclude.                            |
| `from`           | `DateTime?`                     | Oldest article date/time.                      |
| `to`             | `DateTime?`                     | Newest article date/time.                      |
| `language`       | [`NewsLanguage?`][NewsLanguage] | Article language.                              |
| `sortBy`         | `ArticleSortBy?`                | `relevancy`, `popularity`, or `publishedAt`.   |
| `pageSize`       | `int?`                          | Results per page (max 100).                    |
| `page`           | `int?`                          | Page number.                                   |

[Endpoint details](https://newsapi.org/docs/endpoints/everything)

## Sources

```
final sources = await NewsAPI.instance.getSources(category: NewsCategory.technology);
```

| Parameter  | Type                            | Notes               |
|------------|---------------------------------|---------------------|
| `category` | [`NewsCategory?`][NewsCategory] | Filter by category. |
| `language` | [`NewsLanguage?`][NewsLanguage] | Filter by language. |
| `country`  | [`NewsCountry?`][NewsCountry]   | Filter by country.  |

[Endpoint details](https://newsapi.org/docs/endpoints/sources)

## Errors

Failed requests throw a `NewsApiException` with `code` and `message`:

```
try {
  final response = await NewsAPI.instance.getTopHeadlines();
} on NewsApiException catch (e) {
  print("${e.code}: ${e.message}");
}
```

[Details on error codes](https://newsapi.org/docs/errors)

## Custom HTTP Client

`NewsAPI.init()` accepts an optional `http.Client`:

```
NewsAPI.init(apiKey: "your_api_key", client: myClient);
```

* **Testing** — pass a `MockClient` to avoid real network calls.
* **Caching** — News API's free plan has tight rate limits; wrap a caching `http.Client` if needed.
* **Retrying** — `package:http/retry.dart`'s `RetryClient` retries transient failures with backoff:
  `NewsAPI.init(apiKey: "your_api_key", client: RetryClient(http.Client()))`.

[NewsCountry]: https://pub.dev/documentation/news_api_flutter_package/latest/news_api_flutter_package/NewsCountry.html

[NewsCategory]: https://pub.dev/documentation/news_api_flutter_package/latest/news_api_flutter_package/NewsCategory.html

[NewsLanguage]: https://pub.dev/documentation/news_api_flutter_package/latest/news_api_flutter_package/NewsLanguage.html
