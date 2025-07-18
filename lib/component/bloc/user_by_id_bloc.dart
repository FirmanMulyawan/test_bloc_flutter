import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/user_repository.dart';
import 'user_by_id_event.dart';
import 'user_by_id_state.dart';

class UserByIdBloc extends Bloc<UserByIdEvent, UserByIdState> {
  final UserRepository _userRepository;

  UserByIdBloc(this._userRepository) : super(UserByIdInitialState()) {
    on<LoadUserByIdEvent>((event, emit) async {
      emit(UserByIdLoadingState());

      try {
        final users = await _userRepository.getUserById(usersId: event.userId);
        emit(UserByIdSuccessState(users));
      } catch (e) {
        emit(UserErrorState(e.toString()));
      }
    });
  }
}
