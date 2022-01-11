import 'dart:convert';

import 'package:app_ideas/ideas/model/idea_model.dart';
import 'package:http/http.dart' as http;

abstract class IdeasRepository {
  Future<List<Idea>> fetchIdeas();
}

class SimpleIdeaRepository implements IdeasRepository {
  SimpleIdeaRepository({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'www.mivoligo.github.io';
  final http.Client _httpClient;

  @override
  Future<List<Idea>> fetchIdeas() async {
    final ideasRequest = Uri.https(_baseUrl, 'app_ideas_page/ideas.json');
    final ideasResponse = await _httpClient.get(ideasRequest);

    if (ideasResponse.statusCode != 200) {
      throw Exception('Failed to fetch ideas');
    }

    final bodyJson = jsonDecode(ideasResponse.body);

    return bodyJson.map((data) => Idea.fromJson(data)).toList();
  }
}
