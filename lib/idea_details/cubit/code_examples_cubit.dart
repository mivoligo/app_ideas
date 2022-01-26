import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';

part 'code_examples_state.dart';

class CodeExamplesCubit extends Cubit<CodeExamplesState> {
  CodeExamplesCubit(this._githubRepository) : super(const CodeExamplesState());

  final GithubRepository _githubRepository;

  Future<void> fetchCodeExamples({required List<String> searchKeywords}) async {
    emit(state.copyWith(status: CodeExamplesStatus.loading));

    try {
      final examples = await _githubRepository.fetchResults(searchKeywords);
      emit(state.copyWith(
          status: CodeExamplesStatus.success, examples: examples));
    } on Exception {
      emit(state.copyWith(status: CodeExamplesStatus.failure));
    }
  }
}
