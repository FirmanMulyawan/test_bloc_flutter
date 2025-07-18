import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quran_app/component/bloc/user_bloc.dart';
import 'package:quran_app/component/repository/user_repository.dart';

import 'component/bloc/login_bloc.dart';
import 'component/bloc/user_by_id_bloc.dart';
import 'component/config/app_config.dart';
import 'component/config/app_const.dart';
import 'component/config/app_route.dart';
import 'component/config/app_style.dart';
import 'component/di/injector.dart';
import 'component/provider/user_provider.dart';
import 'component/services/route_service.dart';
import 'component/util/storage_util.dart';

final logger = Logger(
  level: kDebugMode ? Level.all : Level.warning,
  output: MultiOutput([
    ConsoleOutput(),
  ]),
);

class AppNav {
  static final _navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  static BuildContext? get maybeContext => navigatorKey.currentContext;
  static BuildContext get context => maybeContext!;

  static bool get hasNavigator => navigatorKey.currentState != null;
  static NavigatorState get navigator => _navigatorKey.currentState!;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await _initPreAppServices();

  runApp(const MyApp());
}

Future<void> _initPreAppServices() async {
  await dotenv.load(fileName: '.env');

  await dependencyInjection();

  final storage = getIt.get<IStorage>();
  await _checkInitRoute(storage);
}

Future _checkInitRoute(IStorage storage) async {
  final token = await storage.getLoginToken();
  if (token != null) {
    await RouteService.set(RouteStatus.loggedIn);
  } else {
    await RouteService.set(RouteStatus.notLoggedIn);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepository(UserProvider()),
        ),
        RepositoryProvider<IStorage>(
          create: (_) => SecureStorage(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (context) => UserBloc(context.read<UserRepository>()),
          ),
          BlocProvider<UserByIdBloc>(
            create: (context) => UserByIdBloc(context.read<UserRepository>()),
          ),
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              userRepository: context.read<UserRepository>(),
              storage: context.read<IStorage>(),
            ),
          ),
        ],
        child: MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: MaterialApp.router(
            title: AppConst.appName,
            // debugShowCheckedModeBanner: false,
            routerConfig: AppRoute.router,
            // theme: AppTheme.themeLight,
            theme: AppStyle.themeData(context),
          ),
        ),
      ),
    );
  }
}
