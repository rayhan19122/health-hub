/// HealthHub — Responsive Breakpoints
class AppBreakpoints {
  AppBreakpoints._();

  static const double mobile = 600;
  static const double tablet = 1024;
  static const double desktop = 1440;

  /// Returns true if screen width is mobile-sized
  static bool isMobile(double width) => width < mobile;

  /// Returns true if screen width is tablet-sized
  static bool isTablet(double width) => width >= mobile && width < tablet;

  /// Returns true if screen width is desktop-sized
  static bool isDesktop(double width) => width >= tablet;
}
