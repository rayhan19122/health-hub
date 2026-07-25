import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/animations/fade_slide_animation.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../widgets/otp_input_field.dart';

/// OTP verification page with 6-digit input and countdown timer.
class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String _otp = '';
  int _resendSeconds = AppConstants.otpResendSeconds;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _resendSeconds = AppConstants.otpResendSeconds;
    _canResend = false;
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(() {
        _resendSeconds--;
        if (_resendSeconds <= 0) _canResend = true;
      });
      return _resendSeconds > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0A0A) : const Color(0xFFF5F5F5),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: FadeSlideAnimation(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Icon(Icons.phone_android_rounded, size: 24, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Verify your number',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Consumer<AuthViewModel>(
                    builder: (context, auth, _) => Text(
                      'We sent a code to ${AppConstants.countryCode} ${_maskPhone(auth.phoneNumber)}',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // OTP Card
                  Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
                      border: Border.all(color: theme.colorScheme.outline),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.black.withValues(alpha: 0.4)
                              : Colors.black.withValues(alpha: 0.06),
                          blurRadius: 24,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Consumer<AuthViewModel>(
                      builder: (context, auth, _) => Column(
                        children: [
                          // OTP Input
                          OtpInputField(
                            length: AppConstants.otpLength,
                            onCompleted: (code) => setState(() => _otp = code),
                            onChanged: (code) => setState(() => _otp = code),
                          ),
                          const SizedBox(height: 24),

                          // Error
                          if (auth.errorMessage != null) ...[
                            Text(
                              auth.errorMessage!,
                              style: GoogleFonts.inter(fontSize: 12, color: AppColors.error),
                            ),
                            const SizedBox(height: 12),
                          ],

                          // Verify button
                          PrimaryButton(
                            label: 'Verify →',
                            isLoading: auth.isLoading,
                            onPressed: () async {
                              final success = await auth.verifyOtp(_otp);
                              if (success && context.mounted) {
                                context.go('/');
                              }
                            },
                          ),

                          const SizedBox(height: 16),

                          // Resend
                          Text(
                            _canResend
                                ? 'Didn\'t receive the code?'
                                : 'Resend code in 0:${_resendSeconds.toString().padLeft(2, '0')}',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          if (_canResend) ...[
                            const SizedBox(height: 4),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  auth.sendOtp();
                                  _startCountdown();
                                },
                                child: Text(
                                  'Resend OTP',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Back to login
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        context.read<AuthViewModel>().goBackToLogin();
                        context.go('/login');
                      },
                      child: Text(
                        '← Change phone number',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _maskPhone(String phone) {
    if (phone.length >= 4) {
      return '${phone.substring(0, 4)}** *** **${phone.substring(phone.length - 2)}';
    }
    return phone;
  }
}
