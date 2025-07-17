import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../component/config/app_const.dart';
import '../../../component/config/app_style.dart';
import '../../../component/widget/popup_button.dart';
import 'surah_controller.dart';
import 'widget/card_surah.dart';

class SurahScreen extends GetView<SurahController> {
  const SurahScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppStyle.pressedGreen,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: SvgPicture.asset(
              AppConst.assetBackButton,
              width: 24,
              height: 24,
            ),
            onPressed: () => Get.back(),
          ),
          title: Obx(() {
            return Text(
              controller.title.value,
              style: AppStyle.bold(size: 20, textColor: Colors.white),
            );
          }),
        ),
        body: Obx(() {
          final isLoadingLevel = controller.isLoading;
          final surah = controller.surahIdResponse.value?.ayat;
          final suratSebelumnya =
              controller.surahIdResponse.value?.suratSebelumnya;
          final suratSelanjutnya =
              controller.surahIdResponse.value?.suratSelanjutnya;
          final lastIndex = surah?.length ?? 0;
          final place = controller.surahIdResponse.value?.tempatTurun;

          return Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () {
                    controller.getSurah();
                    return Future.value();
                  },
                  child: Skeletonizer(
                    enabled: isLoadingLevel,
                    child: ListView.separated(
                      itemCount: (surah?.length ?? 2) + 1,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      separatorBuilder: (ctx, index) {
                        return const SizedBox(
                          height: 20,
                        );
                      },
                      itemBuilder: (ctx, index) {
                        if (index == lastIndex) {
                          return const SizedBox(height: 200);
                        }
                        final ayat = surah?[index];

                        return CardSurah(
                            isLoading: isLoadingLevel,
                            arab: ayat?.ar ??
                                'وَاِنْ كَانَ اَصْحٰبُ الْاَيْكَةِ لَظٰلِمِيْنَۙ',
                            translate: ayat?.tr ??
                                "fawarabbika lanas-alannahum ajma'iin\u003Cstrong\u003Ea\u003C/strong\u003E",
                            numberAyat: ayat?.nomor.toString() ?? '10',
                            enabled: place == "mekah" ? true : false,
                            message: ayat?.idn ?? '');
                      },
                    ),
                  ),
                ),
              ),
              Skeletonizer(
                enabled: isLoadingLevel,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 40),
                  decoration: BoxDecoration(
                    color: AppStyle.hintColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    children: [
                      isLoadingLevel == false
                          ? suratSebelumnya != null
                              ? Expanded(
                                  child: PopupButton(
                                    onPressed: () {
                                      controller.nextAyat(
                                          isTitle:
                                              suratSebelumnya.namaLatin ?? '-',
                                          isSurahId:
                                              suratSebelumnya.nomor ?? 0);
                                    },
                                    size: 50,
                                    color: AppStyle.mainRed,
                                    shadowColor: AppStyle.hoverRed,
                                    child: Text(
                                      suratSebelumnya.namaLatin ?? '-',
                                      style: AppStyle.bold(
                                        size: 15,
                                        textColor: AppStyle.whiteColor,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 50,
                                )
                          : Container(
                              height: 50,
                            ),
                      suratSebelumnya != null && suratSelanjutnya != null
                          ? const SizedBox(
                              width: 20,
                            )
                          : Container(),
                      isLoadingLevel == false
                          ? suratSelanjutnya != null
                              ? Expanded(
                                  child: PopupButton(
                                    onPressed: () {
                                      controller.nextAyat(
                                          isTitle:
                                              suratSelanjutnya.namaLatin ?? '-',
                                          isSurahId:
                                              suratSelanjutnya.nomor ?? 0);
                                    },
                                    size: 50,
                                    color: AppStyle.mainOrange,
                                    shadowColor: AppStyle.hoverOrange,
                                    child: Text(
                                      suratSelanjutnya.namaLatin ?? '-',
                                      textAlign: TextAlign.center,
                                      style: AppStyle.bold(
                                        size: 15,
                                        textColor: AppStyle.whiteColor,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 50,
                                )
                          : Container(
                              height: 50,
                            ),
                    ],
                  ),
                ),
              )
            ],
          );
        }));
  }
}
