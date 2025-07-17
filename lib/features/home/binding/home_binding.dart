import 'package:get/get.dart';

import '../../../component/util/network.dart';
import '../presentation/home_controller.dart';
import '../repository/home_datasource.dart';
import '../repository/home_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeDatasource(Network.dioClient()));
    Get.lazyPut(() => HomeRepository(Get.find()));
    Get.lazyPut(() => HomeController(Get.find()), fenix: true);
    // Get.lazyPut(() => HomeController(Get.find()));
  }
}
