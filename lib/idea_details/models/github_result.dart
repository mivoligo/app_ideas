class GithubResult {
  GithubResult({
    required this.id,
    required this.nodeId,
    required this.name,
    required this.fullName,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    required this.language,
    required this.forks,
    required this.score,
  });

  final int id;
  final String nodeId;
  final String name;
  final String fullName;
  final String url;
  final String createdAt;
  final String updatedAt;
  final String? language;
  final int forks;
  final double score;

  factory GithubResult.fromJson(Map<String, dynamic> json) {
    return GithubResult(
      id: json['id'],
      nodeId: json['node_id'],
      name: json['name'],
      fullName: json['full_name'],
      url: json['url'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      language: json['language'],
      forks: json['forks'],
      score: json['score'],
    );
  }
}
