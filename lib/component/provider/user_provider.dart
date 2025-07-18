import 'package:quran_app/component/api/api_client.dart';

import '../config/app_config.dart';
import '../model/user_list_response.dart';

class UserProvider {
  var apiClient = getIt.get<ApiClient>();

  Future<UserListResponse> getUsers({int page = 1, int perPage = 10}) async {
    try {
      final response = await apiClient.getUsers(page, perPage);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
