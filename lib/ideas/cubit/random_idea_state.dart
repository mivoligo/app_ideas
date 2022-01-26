part of 'random_idea_cubit.dart';

enum RandomIdeaStatus { initial, loading, success, failure }

class RandomIdeaState extends Equatable {
  const RandomIdeaState({
    this.status = RandomIdeaStatus.initial,
    this.idea = const Idea.empty(),
  });

  RandomIdeaState copyWith({
    RandomIdeaStatus? status,
    Idea? idea,
  }) {
    return RandomIdeaState(
      status: status ?? this.status,
      idea: idea ?? this.idea,
    );
  }

  final RandomIdeaStatus status;
  final Idea idea;

  @override
  List<Object> get props => [status, idea];
}
