import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/login_request.dart';
import '../repository/user_repository.dart';
import '../util/storage_util.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IUserRepository userRepository;
  final IStorage storage;

  LoginBloc({required this.userRepository, required this.storage})
      : super(const LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, errorMessage: null));

      try {
        final response = await userRepository.postLogin(LoginRequest(
          email: state.email,
          password: state.password,
        ));

        await storage.setLoginToken(response.token ?? '');
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(
          isSubmitting: false,
          errorMessage: e.toString(),
        ));
      }
    });
  }
}
