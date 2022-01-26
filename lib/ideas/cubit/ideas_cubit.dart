import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/models.dart';
import '../repository/repositories.dart';

part 'ideas_state.dart';

class IdeasCubit extends Cubit<IdeasState> {
  IdeasCubit(this._ideasRepository) : super(const IdeasState());

  final IdeasRepository _ideasRepository;

  Future<void> fetchIdeas() async {
    emit(state.copyWith(status: IdeasStatus.loading));

    try {
      final ideas = await _ideasRepository.fetchIdeas();
      emit(state.copyWith(status: IdeasStatus.success, ideas: ideas));
    } on Exception {
      emit(state.copyWith(status: IdeasStatus.failure));
    }
  }
}
