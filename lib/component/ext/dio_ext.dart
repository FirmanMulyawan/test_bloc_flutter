import 'package:dio/dio.dart';

extension DioExt<T> on Future<Response<T>> {
  Future<T> load() {
    return then((value) {
      return value.data!;
    });
  }

  Future<int> loadCode() {
    return then((value) => value.statusCode!);
  }
}
