import '../model/user_id_response.dart';

abstract class UserByIdState {}

final class UserByIdInitialState extends UserByIdState {}

final class UserByIdLoadingState extends UserByIdState {}

final class UserByIdSuccessState extends UserByIdState {
  final UserIdResponse user;

  UserByIdSuccessState(this.user);
}

final class UserErrorState extends UserByIdState {
  final String message;

  UserErrorState(this.message);
}
