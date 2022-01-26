import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/models.dart';
import '../repository/repositories.dart';

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
