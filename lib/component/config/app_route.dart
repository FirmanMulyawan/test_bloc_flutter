import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
export 'package:go_router/go_router.dart';

import '../../features/detail/detail_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/login/login_screen.dart';
import '../../features/splash/splash_cubit.dart';
import '../../features/splash/splash_screen.dart';
import '../../main.dart';
import '../bloc/login_bloc.dart';
import '../repository/user_repository.dart';
import '../util/storage_util.dart';

class AppRoute {
  // path
  static const String pathDefaultRoute = '/';
  static const String pathLogin = '/pathLogin';
  static const String pathHome = '/pathHome';
  static const String pathDetail = 'pathDetail';

  // name
  static const String defaultNameRoute = 'defaultNameRoute';
  static const String login = 'login';
  static const String home = 'home';
  static const String detail = 'detail';

  // The route configuration.
  static GoRouter router = GoRouter(
    // errorBuilder: (context, state) {
    //   return;
    // },
    initialLocation: pathDefaultRoute,
    // debugLogDiagnostics: true,
    navigatorKey: AppNav.navigatorKey,
    routerNeglect: true,
    routes: <RouteBase>[
      GoRoute(
        path: pathDefaultRoute,
        name: defaultNameRoute,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (_) => SplashCubit()..startProgress(),
            child: const SplashScreen(),
          );
        },
      ),
      GoRoute(
        path: pathLogin,
        name: login,
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
              userRepository: context.read<UserRepository>(),
              storage: context.read<IStorage>(),
            ),
            child: const LoginScreen(),
          );
        },
      ),
      GoRoute(
          path: pathHome,
          name: home,
          builder: (BuildContext context, GoRouterState state) {
            return const HomeScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: pathDetail,
              name: detail,
              builder: (BuildContext context, GoRouterState state) {
                final userId = state.uri.queryParameters['userId'];

                return DetailScreen(userId: userId);
              },
            ),
          ]),
    ],
  );
}
