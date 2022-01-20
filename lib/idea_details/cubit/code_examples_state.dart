part of 'code_examples_cubit.dart';

enum CodeExamplesStatus { initial, loading, success, failure }

class CodeExamplesState extends Equatable {
  const CodeExamplesState({
    this.status = CodeExamplesStatus.initial,
    this.examples = const <GithubResult>[],
  });

  CodeExamplesState copyWith({
    CodeExamplesStatus? status,
    List<GithubResult>? examples,
  }) {
    return CodeExamplesState(
      status: status ?? this.status,
      examples: examples ?? this.examples,
    );
  }

  final CodeExamplesStatus status;

  final List<GithubResult> examples;

  @override
  List<Object> get props => [status, examples];
}
