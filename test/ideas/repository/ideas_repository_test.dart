import 'package:app_ideas/ideas/ideas.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../helpers/ideas_json_example.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockHttpResponse extends Mock implements http.Response {}

class FakeUri extends Mock implements Uri {}

void main() {
  group('IdeasRepository', () {
    late IdeasRepository ideasRepository;
    late MockHttpClient mockHttpClient;

    setUpAll(() {
      registerFallbackValue(FakeUri());
    });

    setUp(() {
      mockHttpClient = MockHttpClient();
      ideasRepository = IdeasRepository(httpClient: mockHttpClient);
    });

    group('constructor', () {
      test('does not required a httpClient', () {
        expect(IdeasRepository(), isNotNull);
      });
    });

    group('fetchIdeas', () {
      test('make correct http request with empty response', () async {
        final mockResponse = MockHttpResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn('');
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => mockResponse);

        try {
          await ideasRepository.fetchIdeas();
          fail('should throw error empty response');
        } catch (e) {
          expect(e, isA<Exception>());
        }
        verify(
          () => mockHttpClient.get(
            Uri.parse('https://mivoligo.github.io/app_ideas_page/ideas.json'),
          ),
        ).called(1);
      });

      test('throws Exception on non-200 response', () async {
        final mockResponse = MockHttpResponse();
        when(() => mockResponse.statusCode).thenReturn(404);
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => mockResponse);
        expect(
          ideasRepository.fetchIdeas(),
          throwsA(isA<Exception>()),
        );
      });

      test('returns list of ideas on a valid response', () async {
        final mockResponse = MockHttpResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(fetchIdeasResponse);
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => mockResponse);

        final ideas = await ideasRepository.fetchIdeas();
        // final body = jsonDecode(mockResponse.body) as List;
        expect(ideas, isA<List<Idea>>());
      });
    });

    group('fetchRandomIdeas', () {
      test('make correct http request with empty response', () async {
        final mockResponse = MockHttpResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn('');
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => mockResponse);

        try {
          await ideasRepository.fetchRandomIdea();
          fail('should throw error empty response');
        } catch (e) {
          expect(e, isA<Exception>());
        }
        verify(
          () => mockHttpClient.get(
            Uri.parse('https://mivoligo.github.io/app_ideas_page/ideas.json'),
          ),
        ).called(1);
      });

      test('throws Exception on non-200 response', () async {
        final mockResponse = MockHttpResponse();
        when(() => mockResponse.statusCode).thenReturn(404);
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => mockResponse);
        expect(
          ideasRepository.fetchRandomIdea(),
          throwsA(isA<Exception>()),
        );
      });

      test('returns random idea on a valid response', () async {
        final mockResponse = MockHttpResponse();
        when(() => mockResponse.statusCode).thenReturn(200);
        when(() => mockResponse.body).thenReturn(fetchIdeasResponse);
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => mockResponse);

        final randomIdea = await ideasRepository.fetchRandomIdea();
        expect(
          randomIdea,
          isA<Idea>(),
        );
      });
    });
  });
}
