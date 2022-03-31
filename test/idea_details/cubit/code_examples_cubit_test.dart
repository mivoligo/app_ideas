import 'package:app_ideas/idea_details/idea_details.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGithubRepository extends Mock implements GithubRepository {}

void main() {
  final mockKeywords = ['keyword1', 'keyword2'];
  final mockResults = [
    GithubResult(
      id: 1,
      name: 'name',
      description: 'description',
      projectUrl: 'projectUrl',
      language: 'language',
      stars: 1,
      owner: const Owner(name: 'name', avatarUrl: 'avatarUrl'),
    ),
    GithubResult(
      id: 2,
      name: 'name 2',
      description: 'description 2',
      projectUrl: 'projectUrl 2',
      language: 'language 2',
      stars: 2,
      owner: const Owner(name: 'name', avatarUrl: 'avatarUrl'),
    ),
  ];

  group('CodeExamplesCubit test', () {
    late CodeExamplesCubit codeExamplesCubit;
    late GithubRepository githubRepository;

    setUp(() {
      githubRepository = MockGithubRepository();
      codeExamplesCubit = CodeExamplesCubit(githubRepository);
    });

    test('initial state is correct', () {
      expect(
          codeExamplesCubit.state,
          const CodeExamplesState(
            status: CodeExamplesStatus.initial,
            examples: [],
          ));
    });

    blocTest<CodeExamplesCubit, CodeExamplesState>(
      'calls fetchCodeExamples',
      setUp: () async {
        when(() => githubRepository.fetchResults(mockKeywords))
            .thenAnswer((_) async => mockResults);
      },
      build: () => codeExamplesCubit,
      act: (cubit) => cubit.fetchCodeExamples(searchKeywords: mockKeywords),
      verify: (_) {
        verify(() => githubRepository.fetchResults(mockKeywords)).called(1);
      },
    );

    blocTest<CodeExamplesCubit, CodeExamplesState>(
      'emits [loading, success] when fetchCodeExamples is called successfully',
      setUp: () async {
        when(() => githubRepository.fetchResults(mockKeywords))
            .thenAnswer((_) async => mockResults);
      },
      build: () => codeExamplesCubit,
      act: (cubit) => cubit.fetchCodeExamples(searchKeywords: mockKeywords),
      expect: () => [
        const CodeExamplesState(
          status: CodeExamplesStatus.loading,
        ),
        CodeExamplesState(
          status: CodeExamplesStatus.success,
          examples: mockResults,
        ),
      ],
    );

    blocTest<CodeExamplesCubit, CodeExamplesState>(
      'emits [loading, failure] when fetchCodeExamples fails',
      setUp: () async {
        when(() => githubRepository.fetchResults(mockKeywords))
            .thenThrow(Exception());
      },
      build: () => codeExamplesCubit,
      act: (cubit) => cubit.fetchCodeExamples(searchKeywords: mockKeywords),
      expect: () => [
        const CodeExamplesState(
          status: CodeExamplesStatus.loading,
        ),
        const CodeExamplesState(
          status: CodeExamplesStatus.failure,
        ),
      ],
    );
  });
}
