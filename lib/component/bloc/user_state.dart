import '../model/user_list_response.dart';

sealed class UserState {}

final class UserInitialState extends UserState {}

final class UserLoadingState extends UserState {}

final class UserSuccessState extends UserState {
  final UserListResponse userListResponse;

  UserSuccessState(this.userListResponse);
}

final class UserErrorState extends UserState {
  final String error;

  UserErrorState(this.error);
}
