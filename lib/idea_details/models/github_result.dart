class GithubResult {
  GithubResult({
    required this.id,
    required this.name,
    required this.description,
    required this.projectUrl,
    required this.language,
    required this.stars,
    required this.owner,
  });

  factory GithubResult.fromJson(Map<String, dynamic> json) {
    return GithubResult(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      projectUrl: json['svn_url'] as String,
      language: json['language'] as String?,
      stars: json['stargazers_count'] as int,
      owner: Owner.fromJson(json['owner']),
    );
  }

  final int id;
  final String name;
  final String? description;
  final String projectUrl;
  final String? language;
  final int stars;
  final Owner owner;
}

class Owner {
  const Owner({
    required this.name,
    required this.avatarUrl,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      name: json['login'] as String,
      avatarUrl: json['avatar_url'] as String,
    );
  }

  final String name;
  final String avatarUrl;
}
