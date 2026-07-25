/// HealthHub — App Constants
class AppConstants {
  AppConstants._();

  static const String appName = 'HealthHub';
  static const String appTagline = 'Beds · Ambulance · Blood Bank';
  static const String appVersion = '1.0.0';

  // Emergency
  static const String emergencyNumber = '999';

  // Country
  static const String countryCode = '+880';

  // Animation durations
  static const Duration animFast = Duration(milliseconds: 150);
  static const Duration animNormal = Duration(milliseconds: 250);
  static const Duration animSlow = Duration(milliseconds: 400);
  static const Duration animPage = Duration(milliseconds: 300);

  // OTP
  static const int otpLength = 6;
  static const int otpResendSeconds = 30;

  // Pagination
  static const int defaultPageSize = 20;

  // Debounce
  static const Duration searchDebounce = Duration(milliseconds: 300);
}
