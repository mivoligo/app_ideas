import 'package:app_ideas/ideas/repository/ideas_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/idea_model.dart';

part 'random_idea_state.dart';

class RandomIdeaCubit extends Cubit<RandomIdeaState> {
  RandomIdeaCubit(this._ideasRepository) : super(const RandomIdeaState());

  final IdeasRepository _ideasRepository;

  Future<void> fetchRandomIdea() async {
    emit(state.copyWith(status: RandomIdeaStatus.loading));
    await Future.delayed(const Duration(seconds: 2));

    try {
      final randomIdea = await _ideasRepository.fetchRandomIdea();
      emit(state.copyWith(status: RandomIdeaStatus.success, idea: randomIdea));
    } on Exception {
      emit(state.copyWith(status: RandomIdeaStatus.failure));
    }
  }
}