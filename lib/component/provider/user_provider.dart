import 'package:quran_app/component/api/api_client.dart';

import '../config/app_config.dart';
import '../model/user_id_response.dart';
import '../model/user_list_response.dart';

class UserProvider {
  var apiClient = getIt.get<ApiClient>();

  Future<UserListResponse> getUserList({int page = 1, int perPage = 10}) async {
    try {
      final response = await apiClient.getUserList(page, perPage);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<UserIdResponse> getUserById({required String usersId}) async {
    try {
      final response = await apiClient.getUserById(usersId);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
