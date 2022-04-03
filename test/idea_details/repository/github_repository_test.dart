import 'package:app_ideas/idea_details/idea_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../helpers/github_json_example.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockHttpResponse extends Mock implements http.Response {}

class FakeUri extends Mock implements Uri {}

void main() {
  const mockSearchQuery = ['query1', 'query2'];

  group('GithubRepository', () {
    late GithubRepository githubRepository;
    late MockHttpClient mockHttpClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      mockHttpClient = MockHttpClient();
      githubRepository = GithubRepository(httpClient: mockHttpClient);
    });

    group('constructor', () {
      test('does not require a httpClient', () {
        expect(GithubRepository(), isNotNull);
      });
    });

    group('fetchResults', () {
      test('make correct http request with empty response', () async {
        final mockResponse = MockHttpResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn('');
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => mockResponse);

        try {
          await githubRepository.fetchResults(mockSearchQuery);
          fail('should throw error empty response');
        } catch (e) {
          expect(e, isA<Exception>());
        }

        verify(
          () => mockHttpClient.get(
            Uri.parse(
                'https://api.github.com/search/repositories?q=query1+query2'),
          ),
        ).called(1);
      });

      test('throws Exception on non-200 response', () async {
        final mockResponse = MockHttpResponse();
        when(() => mockResponse.statusCode).thenReturn(404);
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => mockResponse);
        expect(
          githubRepository.fetchResults(mockSearchQuery),
          throwsA(isA<Exception>()),
        );
      });

      test('returns list of results on a valid response', () async {
        final mockResponse = MockHttpResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(fetchResultsResponse);
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => mockResponse);

        final ideas = await githubRepository.fetchResults(mockSearchQuery);
        expect(ideas, isA<List<GithubResult>>());
      });
    });
  });
}
