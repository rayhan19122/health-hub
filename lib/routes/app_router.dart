import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_names.dart';
import '../features/authentication/viewmodels/auth_viewmodel.dart';
import '../features/authentication/views/login_page.dart';
import '../features/authentication/views/otp_page.dart';
import '../features/dashboard/views/services_home_page.dart';
import '../features/shell/app_shell.dart';
import '../features/notifications/views/notifications_page.dart';

/// HealthHub GoRouter configuration with auth guard and shell route.
class AppRouter {
  AppRouter._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router(AuthViewModel authVm) => GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: '/login',
        debugLogDiagnostics: false,
        redirect: (context, state) {
          final isLoggedIn = authVm.isAuthenticated;
          final isAuthRoute = state.matchedLocation == '/login' ||
              state.matchedLocation == '/otp';

          if (!isLoggedIn && !isAuthRoute) return '/login';
          if (isLoggedIn && isAuthRoute) return '/';
          return null;
        },
        routes: [
          // Auth routes (outside shell)
          GoRoute(
            path: '/login',
            name: RouteNames.login,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const LoginPage(),
              transitionsBuilder: _fadeTransition,
            ),
          ),
          GoRoute(
            path: '/otp',
            name: RouteNames.otp,
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const OtpPage(),
              transitionsBuilder: _fadeTransition,
            ),
          ),

          // Main app shell
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (context, state, child) => AppShell(child: child),
            routes: [
              GoRoute(
                path: '/',
                name: RouteNames.services,
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const ServicesHomePage(),
                  transitionsBuilder: _fadeTransition,
                ),
              ),
              GoRoute(
                path: '/notifications',
                name: RouteNames.notifications,
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: const NotificationsPage(),
                  transitionsBuilder: _fadeTransition,
                ),
              ),
              // Placeholder routes for future phases
              GoRoute(
                path: '/hospital-beds',
                name: RouteNames.hospitalBeds,
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: _PlaceholderPage(title: 'Hospital Beds', color: const Color(0xFF1565C0)),
                  transitionsBuilder: _fadeTransition,
                ),
              ),
              GoRoute(
                path: '/ambulance',
                name: RouteNames.ambulanceHome,
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: _PlaceholderPage(title: 'Ambulance', color: const Color(0xFFC62828)),
                  transitionsBuilder: _fadeTransition,
                ),
              ),
              GoRoute(
                path: '/blood-bank',
                name: RouteNames.bloodBankHome,
                pageBuilder: (context, state) => CustomTransitionPage(
                  key: state.pageKey,
                  child: _PlaceholderPage(title: 'Blood Bank', color: const Color(0xFFAD1457)),
                  transitionsBuilder: _fadeTransition,
                ),
              ),
            ],
          ),
        ],
      );

  static Widget _fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}

/// Placeholder page for features not yet implemented.
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title, required this.color});
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(Icons.construction_rounded, size: 36, color: color),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Coming in Phase 2+',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
