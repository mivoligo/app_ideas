import 'package:app_ideas/ideas/ideas.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIdeasRepository extends Mock implements IdeasRepository {}

void main() {
  final mockIdeas = [
    const Idea(id: '1', title: 'Idea 1', attributes: Attributes.empty()),
    const Idea(id: '2', title: 'Idea 2', attributes: Attributes.empty()),
    const Idea(id: '3', title: 'Idea 3', attributes: Attributes.empty()),
  ];

  group('IdeasCubit test', () {
    late IdeasCubit ideasCubit;
    late IdeasRepository ideasRepository;

    setUp(() {
      ideasRepository = MockIdeasRepository();
      ideasCubit = IdeasCubit(ideasRepository);
    });

    test('initial state is correct', () {
      expect(
        ideasCubit.state,
        const IdeasState(
          status: IdeasStatus.initial,
          ideas: [],
        ),
      );
    });

    blocTest<IdeasCubit, IdeasState>(
      'calls fetchIdeas',
      setUp: () async {
        when(() => ideasRepository.fetchIdeas())
            .thenAnswer((_) async => mockIdeas);
      },
      build: () => ideasCubit,
      act: (cubit) => cubit.fetchIdeas(),
      verify: (_) {
        verify(() => ideasRepository.fetchIdeas()).called(1);
      },
    );

    blocTest<IdeasCubit, IdeasState>(
      'emits [loading, success] when fetchIdeas is called successfully',
      setUp: () async {
        when(() => ideasRepository.fetchIdeas())
            .thenAnswer((_) async => mockIdeas);
      },
      build: () => ideasCubit,
      act: (cubit) => cubit.fetchIdeas(),
      expect: () => [
        const IdeasState(status: IdeasStatus.loading),
        IdeasState(status: IdeasStatus.success, ideas: mockIdeas),
      ],
    );

    blocTest<IdeasCubit, IdeasState>(
      'emits [loading, failure] status when fetchIdeas fails',
      setUp: () async {
        when(() => ideasRepository.fetchIdeas()).thenThrow(Exception('Error'));
      },
      build: () => ideasCubit,
      act: (cubit) => cubit.fetchIdeas(),
      expect: () => [
        const IdeasState(status: IdeasStatus.loading),
        const IdeasState(status: IdeasStatus.failure),
      ],
    );

    tearDown(() {
      ideasCubit.close();
    });
  });
}
