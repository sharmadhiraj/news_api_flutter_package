/// News category, used to filter results in `getSources` and `getTopHeadlines`.
enum NewsCategory {
  business,
  entertainment,
  general,
  health,
  science,
  sports,
  technology,
}

/// 2-letter ISO 639-1 language code, used to filter `getSources` and `getEverything`.
enum NewsLanguage { ar, de, en, es, fr, he, it, nl, no, pt, ru, sv, ud, zh }

/// 2-letter ISO 3166-1 country code, used to filter `getSources` and `getTopHeadlines`.
enum NewsCountry {
  ae,
  ar,
  at,
  au,
  be,
  bg,
  br,
  ca,
  ch,
  cn,
  co,
  cu,
  cz,
  de,
  eg,
  fr,
  gb,
  gr,
  hk,
  hu,
  id,
  ie,
  il,
  india,
  it,
  jp,
  kr,
  lt,
  lv,
  ma,
  mx,
  my,
  ng,
  nl,
  no,
  nz,
  ph,
  pl,
  pt,
  ro,
  rs,
  ru,
  sa,
  se,
  sg,
  si,
  sk,
  th,
  tr,
  tw,
  ua,
  us,
  ve,
  za;

  /// The 2-letter country code accepted by the News API.
  ///
  /// Only [NewsCountry.india] differs from its enum name, since `in` is a
  /// reserved word in Dart.
  String get code => this == NewsCountry.india ? "in" : name;
}

/// Sort order for articles returned by `getEverything`.
enum ArticleSortBy { relevancy, popularity, publishedAt }

/// Fields to restrict the `getEverything` keyword search to.
enum ArticleSearchIn { title, description, content }
