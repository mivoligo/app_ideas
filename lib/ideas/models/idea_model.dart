class Idea {
  const Idea({
    required this.id,
    required this.title,
    required this.attributes,
  });

  const Idea.empty({
    this.id = '',
    this.title = '',
    this.attributes = const Attributes.empty(),
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
    required this.description,
    required this.features,
    required this.tags,
    required this.searchKeywords,
  });

  const Attributes.empty({
    this.summary = '',
    this.imageLink = '',
    this.description = '',
    this.features = const [],
    this.tags = const [],
    this.searchKeywords = const [],
  });

  factory Attributes.fromJson(Map<String, dynamic> json) {
    return Attributes(
      summary: json['summary'] as String,
      imageLink: json['image'] as String,
      description: json['description'] as String,
      features: List<String>.from(json['features']),
      tags: List<String>.from(json['tags']),
      searchKeywords: List<String>.from(json['search_keywords']),
    );
  }

  final String summary;
  final String imageLink;
  final String description;
  final List<String> features;
  final List<String> tags;
  final List<String> searchKeywords;
}
