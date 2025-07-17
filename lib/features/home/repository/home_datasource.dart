import '../../../component/ext/dio_ext.dart';
import '../../../component/base/base_dio_datasource.dart';

class HomeDatasource extends BaseDioDataSource {
  HomeDatasource(super.client);

  Future<String> getListSurah() {
    String path = '/surah';

    return get<String>(path).load();
  }
}
