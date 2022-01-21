import 'package:app_ideas/idea_details/models/github_result.dart';
import 'package:app_ideas/idea_details/repository/github_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'code_examples_state.dart';

class CodeExamplesCubit extends Cubit<CodeExamplesState> {
  CodeExamplesCubit(this._githubRepository) : super(const CodeExamplesState());

  final GithubRepository _githubRepository;

  Future<void> fetchCodeExamples({required String query}) async {
    emit(state.copyWith(status: CodeExamplesStatus.loading));

    try {
      final examples = await _githubRepository.fetchResults(query);
      emit(state.copyWith(
          status: CodeExamplesStatus.success, examples: examples));
    } on Exception {
      emit(state.copyWith(status: CodeExamplesStatus.failure));
    }
  }
}
