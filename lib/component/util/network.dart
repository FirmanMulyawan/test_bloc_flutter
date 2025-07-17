import 'package:dio/dio.dart';
import 'package:get/get.dart';
import '../config/app_route.dart';

class Network {
  static Dio dioClient() {
    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(seconds: 40),
    );
    final Dio dio = Dio(options);
    dio.interceptors.add(LogInterceptor(
        responseBody: true, requestBody: true, requestHeader: true));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (option, handle) async {
      option.headers["Accept"] = "application/json";
      return handle.next(option);
    }, onError: (error, handle) async {
      if (error.response?.statusCode == 401) {
        await Get.offNamedUntil(AppRoute.defaultRoute, (route) => false);
      } else {
        handle.next(error);
      }
    }));
    return dio;
  }
}

class UnauthorizedException implements Exception {}
