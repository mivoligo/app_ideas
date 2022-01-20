import 'dart:convert';

import 'package:app_ideas/idea_details/models/github_result.dart';
import 'package:http/http.dart' as http;

class GithubRepository {
  GithubRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const githubUrl = 'api.github.com';
  static const searchPath = 'search/repositories';
  final http.Client _httpClient;

  Future<List<GithubResult>> fetchResults() async {
    final request = Uri.https(githubUrl, searchPath, {'q': 'linux'});

    final response = await _httpClient.get(request);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch data');
    }

    final bodyJson = jsonDecode(response.body) as Map<String, dynamic>;

    final results = bodyJson['items'] as List;

    return results.map((e) => GithubResult.fromJson(e)).toList();
  }
}
