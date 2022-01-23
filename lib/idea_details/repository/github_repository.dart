import 'dart:convert';

import 'package:app_ideas/idea_details/models/github_result.dart';
import 'package:app_ideas/utils/links_helper.dart';
import 'package:http/http.dart' as http;

class GithubRepository {
  GithubRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const githubApiUrl = 'api.github.com';
  static const githubUrl = 'github.com';
  static const searchPath = 'search';
  static const searchReposPath = 'search/repositories';
  final http.Client _httpClient;

  Future<List<GithubResult>> fetchResults(List<String> searchKeywords) async {
    final query = searchKeywords.join(' ');
    final request = Uri.https(
      githubApiUrl,
      searchReposPath,
      {'q': query},
    );

    final response = await _httpClient.get(request);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch data');
    }

    final bodyJson = jsonDecode(response.body) as Map<String, dynamic>;

    final results = bodyJson['items'] as List;

    return results.map((e) => GithubResult.fromJson(e)).toList();
  }

  Future<void> launchMoreResultsGithubLink(String query) async => openLink(
        githubUrl,
        searchPath,
        queryParams: {'q': query},
      );
}
