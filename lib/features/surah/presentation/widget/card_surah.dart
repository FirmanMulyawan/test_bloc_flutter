import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;

import '../../../../component/config/app_const.dart';
import '../../../../component/config/app_style.dart';
import '../../../../component/util/helper.dart';
import '../../../../component/widget/popup_button.dart';
// import '../../../../component/widget/custom_progress_bar.dart';

class CardSurah extends StatelessWidget {
  final String arab;
  final String translate;
  final String numberAyat;
  final String message;
  final bool enabled;
  final bool isLoading;

  const CardSurah(
      {super.key,
      required this.arab,
      required this.translate,
      required this.numberAyat,
      required this.message,
      required this.enabled,
      required this.isLoading});

  @override
  Widget build(BuildContext context) {
    final Color textColor = enabled ? Colors.white : AppStyle.borderYellow;
    final String backgroundAsset = enabled
        ? AppConst.assetTopicBackground
        : AppConst.assetTopicDisabledBackground;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: svg_provider.Svg(
              backgroundAsset,
            ),
            fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            children: [
              Opacity(
                opacity: enabled ? 1.0 : 0.4,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(numberAyat,
                          style: AppStyle.bold(
                              size: 12, textColor: AppStyle.green)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // arab and progress bar
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      arab,
                      style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: isLoading == false
                              ? PopupButton(
                                  onPressed: () async {
                                    final result =
                                        await AlertModel.showConfirmation(
                                      barrierDismissible: false,
                                      title: "Transliterasi",
                                      message: translate,
                                      hoverColor: AppStyle.homeYoutubeHover,
                                      mainColor: AppStyle.homeYoutubeRed,
                                    );
                                    if (result == true) {}
                                  },
                                  size: 30,
                                  color: AppStyle.homeYoutubeRed,
                                  shadowColor: AppStyle.homeYoutubeHover,
                                  child: Text(
                                    "Transliterasi",
                                    textAlign: TextAlign.center,
                                    style: AppStyle.bold(
                                      size: 12,
                                      textColor: AppStyle.whiteColor,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 30,
                                ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 100,
                          child: isLoading == false
                              ? PopupButton(
                                  onPressed: () async {
                                    final result =
                                        await AlertModel.showConfirmation(
                                      barrierDismissible: false,
                                      title: "Terjemahan",
                                      message: message,
                                      hoverColor: AppStyle.hoverBlue,
                                      mainColor: AppStyle.mainBlue,
                                    );
                                    if (result == true) {}
                                  },
                                  size: 30,
                                  color: AppStyle.mainBlue,
                                  shadowColor: AppStyle.hoverBlue,
                                  child: Text(
                                    "Terjemahan",
                                    textAlign: TextAlign.center,
                                    style: AppStyle.bold(
                                      size: 12,
                                      textColor: AppStyle.whiteColor,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 30,
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
