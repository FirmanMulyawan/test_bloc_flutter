import 'package:dio/dio.dart';
import '../../main.dart';
import '../config/app_const.dart';
import '../config/app_route.dart';

class Network {
  static Dio dioClient() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(seconds: 40),
      baseUrl: AppConst.appUrl,
    );
    final Dio dio = Dio(options);
    dio.interceptors.add(LogInterceptor(
        responseBody: true, requestBody: true, requestHeader: true));
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handle) async {
      // options.headers["Accept"] = "application/json";
      options.headers["x-api-key"] = "reqres-free-v1";
      return handle.next(options);
    }, onError: (error, handle) async {
      if (error.response?.statusCode == 401) {
        // await Get.offNamedUntil(AppRoute.defaultRoute, (route) => false);
        AppNav.context.goNamed(AppRoute.login);
      } else {
        handle.next(error);
      }
    }));
    return dio;
  }
}

class UnauthorizedException implements Exception {}
