## [2.0.0]

### Breaking changes

* `getTopHeadlines`/`getEverything` now return `ArticlesResponse` (`.articles`, `.totalResults`)
  instead of a bare `List<Article>`.
* `category`, `language`, `country`, `sortBy` and `searchIn` are now typed enums (`NewsCategory`,
  `NewsLanguage`, `NewsCountry`, `ArticleSortBy`, `ArticleSearchIn`) instead of raw strings.
* `sources`, `domains` and `excludeDomains` now take a `List<String>` instead of a comma-separated
  `String`.
* `Article.publishedAt` is now a `DateTime?` instead of a `String?`.
* `Article.title`, `Article.url` and `Source.name` are now non-nullable `String`.
* Errors are now thrown as `NewsApiException` (implements `Exception`) instead of `ApiError`.
* `NewsAPI` can no longer be constructed directly. Configure it once via `NewsAPI.init()` and
  access it anywhere via `NewsAPI.instance`.

### Added

* `searchIn` parameter on `getEverything`.
* `NewsAPI.init()`/`NewsAPI.instance` for configuring and accessing a single shared instance.
* Optional `client` (for testing/caching/retrying) and `timeout` (defaults to 30 seconds) on
  `NewsAPI.init()`.
* `NewsAPI.close()` to release the underlying `http.Client`.
* Validation that `sources` isn't combined with `country`/`category` on `getTopHeadlines`.

### Changed

* Removed the `flutter` SDK dependency; the package is now pure Dart.
* Reorganized the package into `lib/src` with a single public export file.

### Fixed

* `from`/`to` dates sent to `getEverything` were missing zero-padding (e.g. `9` instead of `09`),
  producing invalid timestamps.
* A non-JSON response (e.g. an HTML error page from a proxy) threw an uncaught `FormatException`
  instead of a `NewsApiException`.

## [1.2.1]

* Internal improvements

## [1.2.0]

* Internal improvements

## [1.1.1]

* Internal improvements

## [1.1.0]

* Null safety migration

## [1.0.1]

* Update documentation.

## [1.0.0]

* Implemented top headlines, everything, sources.
