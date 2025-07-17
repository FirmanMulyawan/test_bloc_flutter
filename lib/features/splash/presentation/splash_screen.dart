import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/config/app_const.dart';
import '../../../component/config/app_style.dart';
import '../../../component/widget/background_image.dart';
import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      image: AssetImage(
        AppConst.bgSplash,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  const SizedBox(
                    height: 37,
                  ),
                  GetBuilder<SplashController>(
                    builder: (ctx) {
                      return Container(
                        width: 215,
                        decoration: BoxDecoration(
                          color: AppStyle.whiteColor,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: 215 * controller.progress,
                              height: 22,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(11),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppStyle.progressBarTopBlue,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppStyle.progressBarBottomBlue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 236,
                    child: Image.asset(AppConst.kidsIcon),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
