import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/models.dart';

class IdeasRepository {
  IdeasRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'mivoligo.github.io';
  final http.Client _httpClient;

  Future<List<Idea>> fetchIdeas() async {
    final ideasRequest = Uri.https(_baseUrl, 'app_ideas_page/ideas.json');

    final ideasResponse = await _httpClient.get(ideasRequest);

    if (ideasResponse.statusCode != 200) {
      throw Exception('Failed to fetch ideas');
    }

    final bodyJson = jsonDecode(ideasResponse.body) as List;

    return bodyJson.map((e) => Idea.fromJson(e)).toList();
  }

  Future<Idea> fetchRandomIdea() async {
    final ideas = await fetchIdeas();

    ideas.shuffle();
    return ideas.first;
  }
}
