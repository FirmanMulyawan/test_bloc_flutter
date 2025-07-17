import '../../../component/ext/dio_ext.dart';
import '../../../component/base/base_dio_datasource.dart';

class SurahDatasource extends BaseDioDataSource {
  SurahDatasource(super.client);

  Future<String> getListSurahById({int? nomor}) {
    String path = '/surah/$nomor';

    return get<String>(path).load();
  }
}
