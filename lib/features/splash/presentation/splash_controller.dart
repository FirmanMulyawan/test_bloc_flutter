import 'package:get/get.dart';

import '../../../component/config/app_route.dart';

class SplashController extends GetxController {
  SplashController();

  double progress = 0.0;

  @override
  void onInit() {
    progressBar();
    super.onInit();
  }

  void progressBar() async {
    await Future.delayed(const Duration(milliseconds: 600));
    progress = 0.5;
    update();
    await Future.delayed(const Duration(milliseconds: 600));
    progress = 1;
    update();
    await Future.delayed(const Duration(milliseconds: 300));
    Get.offNamed(AppRoute.home);
  }
}
