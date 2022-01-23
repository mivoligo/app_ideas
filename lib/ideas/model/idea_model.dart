class Idea {
  const Idea({
    required this.id,
    required this.title,
    required this.attributes,
  });

  factory Idea.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final title = json['name'] as String;
    final attributes = Attributes.fromJson(json['attributes']);
    return Idea(
      id: id,
      title: title,
      attributes: attributes,
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
    final summary = json['summary'] as String;
    final imageLink = json['image'] as String;
    final tags = List<String>.from(json['tags']);
    final searchKeywords = List<String>.from(json['search_keywords']);
    return Attributes(
      summary: summary,
      imageLink: imageLink,
      tags: tags,
      searchKeywords: searchKeywords,
    );
  }

  final String summary;
  final String imageLink;
  final List<String> tags;
  final List<String> searchKeywords;
}
