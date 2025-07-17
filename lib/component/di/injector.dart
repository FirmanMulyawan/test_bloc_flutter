import '../api/api_client.dart';
import '../config/app_config.dart';
import '../util/network.dart';
import '../util/storage_util.dart';

/// ====== DI Section =====
/// Add dependency here when you need to use/available for all feature
/// ====== end =======
Future<void> dependencyInjection() async {
  getIt.registerLazySingleton<IStorage>(() => SecureStorage());
  getIt.registerLazySingleton(() => Network.dioClient());
  getIt.registerLazySingleton(() => ApiClient(getIt()));
}
