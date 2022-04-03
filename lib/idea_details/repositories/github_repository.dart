import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/utils.dart';
import '../models/models.dart';

class GithubRepository {
  GithubRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _githubApiUrl = 'api.github.com';
  static const _githubUrl = 'github.com';
  static const _searchPath = 'search';
  static const _searchReposPath = 'search/repositories';
  final http.Client _httpClient;

  Future<List<GithubResult>> fetchResults(List<String> searchKeywords) async {
    final query = searchKeywords.join(' ');
    final request = Uri.https(
      _githubApiUrl,
      _searchReposPath,
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
        _githubUrl,
        _searchPath,
        queryParams: {'q': query},
      );
}
