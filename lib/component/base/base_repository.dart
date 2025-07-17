import 'dart:convert';
import 'package:dio/dio.dart';

import '../config/app_const.dart';
import '../model/response_model.dart';
import '../util/state.dart';

class BaseRepository {
  final String _errorMsgHandler = "Failed to load, please try again";

  mapToData(String event) {
    try {
      return jsonDecode(event);
    } catch (e) {
      if (AppConst.isDebuggable) {
        throw Exception(e);
      } else {
        throw Exception(_errorMsgHandler);
      }
    }
  }

  handleDioException(
    DioException e,
    ResponseHandler response,
  ) {
    if (e.response?.data != null) {
      Map<String, dynamic> valueMap = jsonDecode(e.response?.data);
      final error = ResponseModel.ignoreDataFromJson(valueMap);
      response.onFailed(e.response?.statusCode, error.message.toString());
      response.onDone.call();
    } else {
      response.onFailed(e.response?.statusCode, e.toString());
      response.onDone.call();
    }
  }
}
