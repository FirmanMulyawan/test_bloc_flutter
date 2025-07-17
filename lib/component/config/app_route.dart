import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../features/home/binding/home_binding.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/splash/binding/splash_binding.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/surah/binding/surah_binding.dart';
import '../../features/surah/presentation/surah_screen.dart';

class AppRoute {
  static const String defaultRoute = '/';
  static const String notFound = '/notFound';
  static const String home = '/home';
  static const String surah = '/surah';

  static List<GetPage> pages = [
    GetPage(
      name: defaultRoute,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: surah,
      page: () => const SurahScreen(),
      binding: SurahBinding(),
    ),
  ];
}
