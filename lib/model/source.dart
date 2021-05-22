class Source {
  final String? id, name, description, url, category, language, country;

  Source(
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
  );

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      json["id"],
      json["name"],
      json["description"],
      json["url"],
      json["category"],
      json["language"],
      json["country"],
    );
  }

  static List<Source> parseList(List<dynamic> list) {
    return list.map((e) => Source.fromJson(e)).toList();
  }
}
