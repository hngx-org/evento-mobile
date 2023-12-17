import 'package:evento/ui/screens/auth/login_screen.dart';
import 'package:evento/ui/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../ui/screens/auth/sign_up_screen.dart';
import '../ui/screens/onboarding/splash_screen.dart';

final routes = GoRouter(
  initialLocation: SplashScreen.path,
  routes: [
    GoRoute(
      name: SplashScreen.name,
      path: SplashScreen.path,
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
    GoRoute(
      name: OnboardingScreen.name,
      path: OnboardingScreen.path,
      pageBuilder: (BuildContext context, GoRouterState state) => CupertinoPage(
        child: const OnboardingScreen(),
        key: state.pageKey,
      ),
    ),
    GoRoute(
        name: LoginScreen.name,
        path: LoginScreen.path,
        pageBuilder: (BuildContext context, GoRouterState state) {
          if (state.uri.queryParameters.isNotEmpty) {
            Map<String, dynamic> args = state.uri.queryParameters;
            return CupertinoPage<void>(
              child: LoginScreen(
                token: args['token'],
              ),
              key: state.pageKey,
            );
          } else {
            return CupertinoPage<void>(
              child: const LoginScreen(
                token: null,
              ),
              key: state.pageKey,
            );
          }
        }),
    GoRoute(
      name: SignUpScreen.name,
      path: SignUpScreen.path,
      pageBuilder: (BuildContext context, GoRouterState state) => CupertinoPage(
        child: const SignUpScreen(),
        key: state.pageKey,
      ),
    ),
  ],
);
