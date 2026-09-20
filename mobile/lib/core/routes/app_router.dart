import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/profile_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/baby_care/presentation/pages/baby_care_home_page.dart';
import '../../features/community/presentation/pages/community_home_page.dart';
import '../../features/consultation/presentation/pages/consultation_home_page.dart';
import '../../features/womb_care/presentation/pages/womb_care_home_page.dart';
import '../presentation/pages/home_dashboard_page.dart';
import '../presentation/widgets/main_shell.dart';
import 'app_routes.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// App-wide router. Five bottom-nav tabs live inside a single
/// `StatefulShellRoute.indexedStack` (each branch keeps its own stack);
/// `splash`, `login`, and `consultation` are pushed/replaced above it.
final GoRouter goRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.consultation,
      builder: (context, state) => const ConsultationHomePage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomeDashboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.wombCare,
              builder: (context, state) => const WombCareHomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.babyCare,
              builder: (context, state) => const BabyCareHomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.community,
              builder: (context, state) => const CommunityHomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.profile,
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
