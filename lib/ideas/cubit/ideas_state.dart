part of 'ideas_cubit.dart';

enum IdeasStatus { initial, loading, success, failure }

class IdeasState extends Equatable {
  const IdeasState({
    this.status = IdeasStatus.initial,
    this.ideas = const <Idea>[],
  });

  IdeasState copyWith({
    IdeasStatus? status,
    List<Idea>? ideas,
  }) {
    return IdeasState(
      status: status ?? this.status,
      ideas: ideas ?? this.ideas,
    );
  }

  final IdeasStatus status;
  final List<Idea> ideas;

  @override
  List<Object?> get props => [status, ideas];
}
