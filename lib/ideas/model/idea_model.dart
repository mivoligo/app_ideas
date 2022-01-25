class Idea {
  const Idea({
    required this.id,
    required this.title,
    required this.attributes,
  });

  factory Idea.fromJson(Map<String, dynamic> json) {
    return Idea(
      id: json['id'] as String,
      title: json['name'] as String,
      attributes: Attributes.fromJson(json['attributes']),
    );
  }

  final String id;
  final String title;
  final Attributes attributes;
}

class Attributes {
  Attributes({
    required this.summary,
    required this.imageLink,
    required this.tags,
    required this.searchKeywords,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      summary: json['summary'] as String,
      imageLink: json['image'] as String,
      tags: List<String>.from(json['tags']),
      searchKeywords: List<String>.from(json['search_keywords']),
    );
  }

  final String summary;
  final String imageLink;
  final List<String> tags;
  final List<String> searchKeywords;
}
