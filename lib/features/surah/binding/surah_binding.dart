import 'package:get/get.dart';

import '../../../component/util/network.dart';
import '../presentation/surah_controller.dart';
import '../repository/surah_datasource.dart';
import '../repository/surah_repository.dart';

class SurahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SurahDatasource(Network.dioClient()));
    Get.lazyPut(() => SurahRepository(Get.find()));
    Get.lazyPut(() => SurahController(Get.find()));
  }
}
