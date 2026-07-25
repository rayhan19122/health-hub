import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_viewmodel.dart';
import 'features/authentication/repositories/auth_repository.dart';
import 'features/authentication/viewmodels/auth_viewmodel.dart';
import 'features/dashboard/viewmodels/dashboard_viewmodel.dart';
import 'routes/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize repositories
  final authRepository = MockAuthRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(repository: authRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => DashboardViewModel(),
        ),
      ],
      child: const HealthHubApp(),
    ),
  );
}

/// HealthHub — Root Application Widget
class HealthHubApp extends StatelessWidget {
  const HealthHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeVm = context.watch<ThemeViewModel>();
    final authVm = context.read<AuthViewModel>();

    final router = AppRouter.router(authVm);

    return MaterialApp.router(
      title: 'HealthHub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeVm.themeMode,
      routerConfig: router,
    );
  }
}
