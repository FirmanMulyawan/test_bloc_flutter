import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../model/login_request.dart';
import '../model/login_response.dart';
import '../model/user_id_response.dart';
import '../model/user_list_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('login')
  Future<LoginResponse> postLogin(@Body() LoginRequest request);

  @GET('users/{usersId}')
  Future<UserIdResponse> getUserById(
    @Path("usersId") String usersId,
  );

  @GET('users')
  Future<UserListResponse> getUserList(
    @Query("page") int page,
    @Query("per_page") int perPage,
  );
}
