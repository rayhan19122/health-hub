import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../core/utils/responsive_helper.dart';
import '../../core/widgets/navigation/app_top_bar.dart';
import '../../core/widgets/navigation/app_bottom_bar.dart';
import '../../core/theme/theme_viewmodel.dart';
import '../authentication/viewmodels/auth_viewmodel.dart';
import '../../routes/route_names.dart';

/// App shell that wraps authenticated pages with top bar and bottom nav.
class AppShell extends StatefulWidget {
  const AppShell({super.key, required this.child});
  final Widget child;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentNavIndex = 0;

  void _onBottomNavTap(int index) {
    setState(() => _currentNavIndex = index);
    switch (index) {
      case 0:
        context.goNamed(RouteNames.services);
      case 1:
        context.goNamed(RouteNames.services);
      case 2:
        context.goNamed(RouteNames.hospitalBeds);
      case 3:
        context.goNamed(RouteNames.notifications);
      case 4:
        // Profile — future
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final themeVm = context.watch<ThemeViewModel>();
    final authVm = context.watch<AuthViewModel>();

    return Scaffold(
      body: Column(
        children: [
          // Top bar
          AppTopBar(
            isDarkMode: themeVm.isDarkMode,
            onThemeToggle: themeVm.toggleTheme,
            onNotificationTap: () => context.goNamed(RouteNames.notifications),
            onProfileTap: () => authVm.cycleRole(),
            userName: authVm.userName,
            userRole: authVm.userRoleName,
            onLogoTap: () => context.goNamed(RouteNames.services),
          ),

          // Content
          Expanded(child: widget.child),

          // Bottom nav (mobile only)
          if (isMobile)
            AppBottomBar(
              currentIndex: _currentNavIndex,
              onTap: _onBottomNavTap,
            ),
        ],
      ),
    );
  }
}
