import '../config/app_config.dart';
import '../util/storage_util.dart';

enum RouteStatus {
  init,
  error,
  online,
  offline,
  loggedIn,
  notLoggedIn,
  onboarding,
  forceUpdate,
  noNetwork,
  serverOffline,
  serverMaintenance,
}

class RouteService {
  factory RouteService() {
    return _instance;
  }

  RouteService._internal();

  static RouteStatus routeStatus = RouteStatus.init;
  static final RouteService _instance = RouteService._internal();
  static final storage = getIt.get<IStorage>();

  static bool _isUserLogged = false;
  static bool get isUserLogged => _isUserLogged;

  static Future set(RouteStatus status) async {
    routeStatus = status;
    await setValueUserLogged();
  }

  static Future setValueUserLogged() async {
    _isUserLogged = await storage.isLoggedIn();
  }
}
