import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../component/config/app_style.dart';
import '../../../component/util/helper.dart';
import '../../../component/widget/popup_button.dart';
import '../model/list_surah_response.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppStyle.pressedGreen,
            centerTitle: true,
            elevation: 0,
            title: Text(
              "Quran App",
              style: AppStyle.bold(size: 20, textColor: Colors.white),
            )),
        backgroundColor: AppStyle.whiteColor,
        body: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: controller.searchController,
                onTapOutside: (PointerDownEvent event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                onChanged: (value) {
                  // controller.updateKeyword();
                },
                style: AppStyle.regular(
                  size: 20,
                ),
                decoration: InputDecoration(
                  hintText: "Search Surah",
                  hintStyle: AppStyle.regular(
                    size: 20,
                    textColor: AppStyle.searchHintColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: AppStyle.searchBorderColor,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(
                      color: AppStyle.searchBorderColor,
                      width: 1.5,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppStyle.pressedGreen,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: GetBuilder<HomeController>(builder: (ctrl) {
                final isLoadingLevel = ctrl.isLoading;
                final listSurah = ctrl.listSurah;
                final lastIndex = listSurah?.length ?? 0;

                return Skeletonizer(
                  enabled: isLoadingLevel,
                  child: RefreshIndicator(
                    onRefresh: () {
                      ctrl.getListSurah();
                      return Future.value();
                    },
                    child: ListView(
                      children: [
                        ListView.separated(
                            itemCount: (listSurah?.length ?? 5) + 1,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (ctx, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemBuilder: (ctx, index) {
                              if (isLoadingLevel == false) {
                                if (index == lastIndex) {
                                  return const SizedBox(height: 200);
                                }
                              }

                              final surah = listSurah?[index];

                              return _cardSurah(
                                surah: surah,
                                isloading: isLoadingLevel,
                                isAudio: surah?.audio ?? '',
                                onTap: () => ctrl.toSurah(
                                    namaLatin: surah?.namaLatin ?? '',
                                    nomor: surah?.nomor ?? 0),
                                backgroundImage: ctrl.backgroundCard(
                                    surah?.tempatTurun ?? "madinah"),
                                surahName: surah?.nama ?? "Nama Surah",
                                namaLatin: surah?.namaLatin ?? "Nama Latin",
                                arti: surah?.arti ?? "Pembukaan",
                                jumlahAyat: surah?.jumlahAyat ?? 0,
                                tempatTurun: surah?.tempatTurun ?? "madinah",
                                deskripsi: surah?.deskripsi ?? '',
                                hoverColor:
                                    listSurah?[index].tempatTurun == "madinah"
                                        ? AppStyle.pressedGreen
                                        : AppStyle.hoverBlue,
                                mainColor:
                                    listSurah?[index].tempatTurun == "madinah"
                                        ? AppStyle.green
                                        : AppStyle.mainBlue,
                              );
                            }),
                      ],
                    ),
                  ),
                );
              }),
            ),
            _isProgress()
          ],
        ));
  }

  Widget _isProgress() {
    return Obx(() {
      final lastAudio = controller.lastAudio.value;

      return lastAudio?.audio != null
          ? Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 30, bottom: 40),
              decoration: BoxDecoration(
                color: lastAudio?.tempatTurun == "madinah"
                    ? AppStyle.profleGreen
                    : AppStyle.mainBlue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    lastAudio?.nama ?? '-',
                    style:
                        AppStyle.bold(size: 25, textColor: AppStyle.whiteColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        lastAudio?.namaLatin ?? '-',
                        style: AppStyle.bold(
                            size: 15, textColor: AppStyle.whiteColor),
                      ),
                      Container(
                        width: 1,
                        height: 13,
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      Text(
                        lastAudio?.tempatTurun ?? '-',
                        style: AppStyle.bold(
                            size: 15, textColor: AppStyle.whiteColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Slider(
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey,
                      thumbColor: AppStyle.homeYoutubeRed,
                      min: 0,
                      max: controller.duration.value.inSeconds.toDouble(),
                      value: controller.position.value.inSeconds.toDouble(),
                      onChanged: (value) async {
                        controller.handleSlider(value);
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          formatTime(controller.position.value),
                          style: AppStyle.regular(
                              size: 12, textColor: AppStyle.whiteColor),
                        ),
                        Text(
                          formatTime(controller.duration.value),
                          style: AppStyle.regular(
                              size: 12, textColor: AppStyle.whiteColor),
                        )
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 35,
                    child: IconButton(
                        onPressed: () {
                          if (controller.isPlaying.value) {
                            controller.pauseAudio(lastAudio);
                          } else {
                            controller.resumeAudio(lastAudio);
                          }
                        },
                        iconSize: 50,
                        icon: Icon(
                          controller.isPlaying.value
                              ? Icons.pause
                              : Icons.play_arrow,
                        )),
                  )
                ],
              ))
          : Container();
    });
  }

  Widget _cardSurah(
      {void Function()? onTap,
      ListSurahResponse? surah,
      String backgroundImage = '',
      String surahName = '',
      String namaLatin = '',
      String arti = '',
      int jumlahAyat = 0,
      String tempatTurun = '',
      String deskripsi = '',
      Color? hoverColor,
      Color? mainColor,
      bool isloading = true,
      String isAudio = ''}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Ink(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(backgroundImage), fit: BoxFit.cover),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 80,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  surahName,
                                  style: AppStyle.bold(
                                      textColor: AppStyle.whiteColor, size: 20),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Wrap(
                                  children: [
                                    Text(
                                      namaLatin,
                                      style: AppStyle.medium(
                                              textColor: Colors.white)
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 13,
                                      color: Colors.white,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                    ),
                                    Text(
                                      arti,
                                      style: AppStyle.medium(
                                              textColor: Colors.white)
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "$jumlahAyat Ayat",
                                      style: AppStyle.medium(
                                              textColor: Colors.white)
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 13,
                                      color: Colors.white,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                    ),
                                    Text(
                                      tempatTurun,
                                      style: AppStyle.medium(
                                              textColor: Colors.white)
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 130,
                                  child: isloading == false
                                      ? PopupButton(
                                          onPressed: () async {
                                            final result = await AlertModel
                                                .showConfirmation(
                                              barrierDismissible: false,
                                              title: "Deskripsi",
                                              message: deskripsi,
                                              hoverColor: hoverColor ??
                                                  AppStyle.hoverBlue,
                                              mainColor: mainColor ??
                                                  AppStyle.mainBlue,
                                            );
                                            if (result == true) {}
                                          },
                                          size: 20,
                                          color: AppStyle.mainOrange,
                                          shadowColor: AppStyle.hoverOrange,
                                          child: Text(
                                            "Deskription",
                                            textAlign: TextAlign.center,
                                            style: AppStyle.bold(
                                              size: 10,
                                              textColor: AppStyle.whiteColor,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: 20,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                      top: 30,
                      right: 0,
                      child: _audioButton(isAudio: isAudio, surah: surah)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _audioButton({
    String isAudio = '',
    ListSurahResponse? surah,
  }) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      final audioCondition = surah?.audioCondition;
      return Row(
        children: [
          (audioCondition == "stop")
              ? IconButton(
                  onPressed: () {
                    controller.playAudio(surah);
                  },
                  icon: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ))
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (audioCondition == "playing")
                        ? IconButton(
                            onPressed: () {
                              controller.pauseAudio(surah);
                            },
                            icon: const Icon(
                              Icons.pause,
                              color: Colors.white,
                            ))
                        : IconButton(
                            onPressed: () {
                              controller.resumeAudio(surah);
                            },
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            )),
                    IconButton(
                        onPressed: () {
                          controller.stopAudio(surah);
                        },
                        icon: const Icon(
                          Icons.stop,
                          color: Colors.white,
                        ))
                  ],
                ),
        ],
      );
    });
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
