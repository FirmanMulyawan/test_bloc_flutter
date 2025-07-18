import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConst {
  static String appName = "User App";
  static bool isDebuggable = true;
  static String appUrl = '${dotenv.env['API_LINK']!}/api/';

  static String path = 'assets/';

  static String eyeIcon = '${path}icons/ic_eye.svg';
  static String eyeClosedIcon = '${path}icons/ic_eye_off.svg';
  static String bgSplash = '${path}icons/bg_splash.png';
  static String kidsIcon = '${path}icons/ic_kids.png';
  static String assetImageBeginnerLearn = '${path}icons/img_beginner.png';
  static String assetImageElementaryLearn = '${path}icons/img_elementary.png';
  static String bgImage = '${path}icons/bg_image.png';
  static String assetBackButton = '${path}icons/ic_back_button.svg';
  static String assetTopicBackground = '${path}icons/ic_topic_background.svg';
  static String assetTopicDisabledBackground =
      '${path}icons/ic_topic_background_disabled.svg';
}
