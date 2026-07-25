import 'package:flutter_test/flutter_test.dart';
import 'package:health_hub/main.dart';
import 'package:provider/provider.dart';
import 'package:health_hub/core/theme/theme_viewmodel.dart';
import 'package:health_hub/features/authentication/repositories/auth_repository.dart';
import 'package:health_hub/features/authentication/viewmodels/auth_viewmodel.dart';
import 'package:health_hub/features/dashboard/viewmodels/dashboard_viewmodel.dart';

void main() {
  testWidgets('App boots and shows login', (WidgetTester tester) async {
    final authRepo = MockAuthRepository();
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeViewModel()),
          ChangeNotifierProvider(create: (_) => AuthViewModel(repository: authRepo)),
          ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ],
        child: const HealthHubApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Verify app renders
    expect(find.text('HealthHub'), findsOneWidget);
  });
}
