abstract class UserByIdEvent {}

class LoadUserByIdEvent extends UserByIdEvent {
  final String userId;

  LoadUserByIdEvent(this.userId);
}
