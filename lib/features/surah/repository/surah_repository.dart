import 'package:dio/dio.dart';

import '../../../component/base/base_repository.dart';
import '../../../component/util/state.dart';
import '../model/surah_by_id_response.dart';
import 'surah_datasource.dart';

class SurahRepository extends BaseRepository {
  final SurahDatasource _dataSource;

  SurahRepository(this._dataSource);

  Future<void> getListSurah(
      {int? nomor,
      required ResponseHandler<SurahByIdResponse> response}) async {
    try {
      final data = await _dataSource
          .getListSurahById(nomor: nomor)
          .then(mapToData)
          .then((value) {
        final response = SurahByIdResponse.fromJson(value);
        return response;
      });
      response.onSuccess.call(data);
      response.onDone.call();
    } on DioException catch (e) {
      handleDioException(e, response);
    } catch (e) {
      response.onFailed(e, e.toString());
      response.onDone.call();
    }
  }
}
