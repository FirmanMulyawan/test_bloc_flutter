import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';

import '../config/app_style.dart';
import '../widget/popup_button.dart';

class AlertModel {
  static Future<bool?> showAlert({
    required String title,
    required String message,
    String? buttonText,
    bool? barrierDismissible,
  }) async {
    final result = await Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: AppStyle.pressedGreen,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 17,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppStyle.bold(
                    size: 25,
                    textColor: AppStyle.whiteColor,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppStyle.bold(
                    size: 20,
                    textColor: AppStyle.textColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 30,
                  left: 30,
                  right: 30,
                ),
                child: PopupButton(
                  onPressed: () {
                    Get.back(result: false);
                  },
                  size: 50,
                  color: AppStyle.mainRed,
                  shadowColor: AppStyle.hoverRed,
                  child: Text(
                    buttonText ?? 'Ok',
                    style: AppStyle.bold(
                      size: 15,
                      textColor: AppStyle.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible ?? true,
      barrierColor: AppStyle.dialogBgColor,
    );
    return result;
  }

  static Future<bool?> showConfirmation({
    required String title,
    required String message,
    required Color mainColor,
    required Color hoverColor,
    String? confirmText,
    String? cancelText,
    bool? barrierDismissible,
  }) async {
    final result = await Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 17,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppStyle.bold(
                    size: 25,
                    textColor: AppStyle.whiteColor,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                  ),
                  child: Scrollbar(
                    thumbVisibility: true,
                    radius: const Radius.circular(8),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Html(data: message, style: {
                          "body": Style(
                              fontFamily: "BloggerSans",
                              color: AppStyle.textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: FontSize(15))
                        }),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 30,
                  left: 30,
                  right: 30,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: PopupButton(
                        onPressed: () {
                          Get.back(result: true);
                        },
                        size: 50,
                        color: mainColor,
                        shadowColor: hoverColor,
                        child: Text(
                          confirmText ?? 'Done',
                          textAlign: TextAlign.center,
                          style: AppStyle.bold(
                            size: 15,
                            textColor: AppStyle.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible ?? true,
      barrierColor: AppStyle.dialogBgColor,
    );
    return result;
  }

  final String title;
  final String message;

  AlertModel({this.title = "", this.message = ""});
}
