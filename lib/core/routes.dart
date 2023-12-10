import 'package:evento/ui/screens/onboarding/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

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
  ],
);
