import '../model/user_list_response.dart';
import '../provider/user_provider.dart';

abstract class IUserRepository {
  Future<UserListResponse> getUsers();
}

class UserRepository implements IUserRepository {
  final UserProvider userProvider;
  UserRepository(this.userProvider);

  @override
  Future<UserListResponse> getUsers() {
    return userProvider.getUsers();
  }
}
