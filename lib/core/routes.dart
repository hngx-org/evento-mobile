import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../ui/screens/splash_screen.dart';

final routes = GoRouter(
  initialLocation: SplashScreen.path,
  routes: [
    GoRoute(
      name: SplashScreen.name,
      path: SplashScreen.path,
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
  ],
);
