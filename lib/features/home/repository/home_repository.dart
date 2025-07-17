import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../component/base/base_repository.dart';
import '../../../component/util/state.dart';
import '../model/list_surah_response.dart';
import 'home_datasource.dart';

class HomeRepository extends BaseRepository {
  final HomeDatasource _dataSource;

  HomeRepository(this._dataSource);

  Future<void> getListSurah(
      {required ResponseHandler<List<ListSurahResponse>> response}) async {
    try {
      final rawJson = await _dataSource.getListSurah();
      final decoded = jsonDecode(rawJson);

      if (decoded is List) {
        final list = decoded
            .map((e) => ListSurahResponse.fromJson(e as Map<String, dynamic>))
            .toList();

        response.onSuccess.call(list);
      } else {
        response.onFailed.call(Exception("Invalid format"), "Unexpected data");
      }
      response.onDone.call();
    } on DioException catch (e) {
      handleDioException(e, response);
    } catch (e) {
      response.onFailed(e, e.toString());
      response.onDone.call();
    }
  }
}
