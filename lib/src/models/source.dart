/// A news publisher available through `getSources`, `getTopHeadlines` and `getEverything`.
///
/// Only [id] and [name] are populated when a `Source` is nested inside an
/// [Article]; the rest are only returned by `getSources`.
class Source {
  /// The publisher's name.
  final String name;

  /// The publisher's identifier, usable as a `sources` filter.
  final String? id;

  /// A short description of the publisher. Only returned by `getSources`.
  final String? description;

  /// The publisher's homepage. Only returned by `getSources`.
  final String? url;

  /// The publisher's primary category. Only returned by `getSources`.
  final String? category;

  /// The publisher's language. Only returned by `getSources`.
  final String? language;

  /// The publisher's country. Only returned by `getSources`.
  final String? country;

  /// Creates a [Source] with the given field values.
  const Source({
    required this.name,
    this.id,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
  });

  /// Parses a [Source] from the News API's JSON representation.
  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      name: json["name"] ?? "",
      id: json["id"],
      description: json["description"],
      url: json["url"],
      category: json["category"],
      language: json["language"],
      country: json["country"],
    );
  }

  /// Parses a JSON list into [Source]s, or returns `[]` if [list] isn't a list.
  static List<Source> parseList(dynamic list) {
    if (list is! List) return [];
    return list.map((e) => Source.fromJson(e)).toList();
  }
}
