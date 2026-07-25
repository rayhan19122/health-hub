import 'package:flutter/material.dart';
import '../constants/app_breakpoints.dart';

/// HealthHub — Responsive Helper
///
/// Provides responsive utilities for building adaptive layouts.
class ResponsiveHelper {
  ResponsiveHelper._();

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppBreakpoints.mobile;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= AppBreakpoints.mobile && w < AppBreakpoints.tablet;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppBreakpoints.tablet;

  /// Returns a value based on the current screen size.
  static T responsive<T>(
    BuildContext context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= AppBreakpoints.tablet) return desktop ?? tablet ?? mobile;
    if (w >= AppBreakpoints.mobile) return tablet ?? mobile;
    return mobile;
  }

  /// Returns grid cross-axis count based on screen width.
  static int gridColumns(BuildContext context, {int mobile = 1, int tablet = 2, int desktop = 3}) =>
      responsive(context, mobile: mobile, tablet: tablet, desktop: desktop);
}
