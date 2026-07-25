import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// HealthHub — Dart Extensions
///
/// Convenience extensions for BuildContext, Color, and common types.
extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  MediaQueryData get mq => MediaQuery.of(this);
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Shorthand for showing a SnackBar
  void showSnack(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppColors.error : null,
      ),
    );
  }
}

extension ColorX on Color {
  /// Returns this color with a specified alpha (0.0 to 1.0)
  Color withAlpha01(double opacity) => withValues(alpha: opacity);
}

extension StringX on String {
  /// Capitalizes the first letter
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// Returns initials from a name (e.g. "John Doe" -> "JD")
  String get initials {
    final parts = trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return isNotEmpty ? this[0].toUpperCase() : '';
  }
}
