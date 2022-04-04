import 'package:app_ideas/ideas/ideas.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIdeasRepository extends Mock implements IdeasRepository {}

void main() {
  const mockIdea = Idea(
    id: '1',
    title: 'Idea 1',
    attributes: Attributes.empty(),
  );
  group('RandomIdeaCubit test', () {
    late RandomIdeaCubit randomIdeaCubit;
    late IdeasRepository ideasRepository;

    setUp(() {
      ideasRepository = MockIdeasRepository();
      randomIdeaCubit = RandomIdeaCubit(ideasRepository);
    });

    test('initial state is correct', () {
      expect(
          randomIdeaCubit.state,
          const RandomIdeaState(
            status: RandomIdeaStatus.initial,
            idea: Idea.empty(),
          ));
    });

    blocTest<RandomIdeaCubit, RandomIdeaState>(
      'calls fetchRandomIdea',
      setUp: () async {
        when(() => ideasRepository.fetchRandomIdea())
            .thenAnswer((_) async => mockIdea);
      },
      build: () => randomIdeaCubit,
      act: (cubit) => cubit.fetchRandomIdea(),
      verify: (_) {
        verify(() => ideasRepository.fetchRandomIdea()).called(1);
      },
    );

    blocTest<RandomIdeaCubit, RandomIdeaState>(
      'emits [loading, success] when fetchRandomIdea is successful',
      setUp: () async {
        when(() => ideasRepository.fetchRandomIdea())
            .thenAnswer((_) async => mockIdea);
      },
      build: () => randomIdeaCubit,
      act: (cubit) => cubit.fetchRandomIdea(),
      expect: () => [
        const RandomIdeaState(status: RandomIdeaStatus.loading),
        const RandomIdeaState(idea: mockIdea, status: RandomIdeaStatus.success),
      ],
    );

    blocTest<RandomIdeaCubit, RandomIdeaState>(
      'emits [loading, failure] when fetchRandomIdea fails',
      setUp: () async {
        when(() => ideasRepository.fetchRandomIdea())
            .thenThrow(Exception('Error'));
      },
      build: () => randomIdeaCubit,
      act: (cubit) => cubit.fetchRandomIdea(),
      expect: () => [
        const RandomIdeaState(status: RandomIdeaStatus.loading),
        const RandomIdeaState(status: RandomIdeaStatus.failure),
      ],
    );

    tearDown(() {
      randomIdeaCubit.close();
    });
  });
}
