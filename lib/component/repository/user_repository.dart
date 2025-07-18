import '../model/user_id_response.dart';
import '../model/user_list_response.dart';
import '../provider/user_provider.dart';

abstract class IUserRepository {
  Future<UserListResponse> getUserList();
  Future<UserIdResponse> getUserById({required String usersId});
}

class UserRepository implements IUserRepository {
  final UserProvider userProvider;
  UserRepository(this.userProvider);

  @override
  Future<UserListResponse> getUserList() {
    return userProvider.getUserList();
  }

  @override
  Future<UserIdResponse> getUserById({required String usersId}) {
    return userProvider.getUserById(usersId: usersId);
  }
}
