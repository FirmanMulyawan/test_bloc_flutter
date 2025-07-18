import '../model/login_request.dart';
import '../model/login_response.dart';
import '../model/user_id_response.dart';
import '../model/user_list_response.dart';
import '../provider/user_provider.dart';

abstract class IUserRepository {
  Future<UserListResponse> getUserList();
  Future<UserIdResponse> getUserById({required String usersId});
  Future<LoginResponse> postLogin(LoginRequest request);
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

  @override
  Future<LoginResponse> postLogin(LoginRequest request) {
    return userProvider.postLogin(request);
  }
}
