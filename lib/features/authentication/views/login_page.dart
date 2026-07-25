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

/// Premium login page with phone number input.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController(text: '01712 345 678');

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0A0A0A) : const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          // Background gradient circle
          Positioned(
            top: -200,
            right: -200,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: FadeSlideAnimation(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      _buildLogo(theme),
                      const SizedBox(height: 32),

                      // Login card
                      _buildLoginCard(context, theme, isDark),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo(ThemeData theme) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Center(
            child: Icon(Icons.local_hospital_rounded, size: 30, color: Colors.white),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          AppConstants.appName,
          style: GoogleFonts.inter(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.onSurface,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          AppConstants.appTagline,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard(BuildContext context, ThemeData theme, bool isDark) {
    return Container(
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
        builder: (context, auth, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Enter your phone number to get started',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),

              // Phone label
              Text(
                'Phone Number',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 6),

              // Phone input row
              Row(
                children: [
                  // Country code
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      border: Border.all(color: theme.colorScheme.outline),
                      color: isDark ? AppColors.inputBgDark : AppColors.inputBgLight,
                    ),
                    child: Text(
                      AppConstants.countryCode,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Phone number field
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                      onChanged: (v) => auth.setPhoneNumber(v),
                      decoration: InputDecoration(
                        hintText: '01712 345 678',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Error message
              if (auth.errorMessage != null) ...[
                const SizedBox(height: 12),
                Text(
                  auth.errorMessage!,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],

              const SizedBox(height: 20),

              // Submit button
              PrimaryButton(
                label: 'Send OTP →',
                isLoading: auth.isLoading,
                onPressed: () async {
                  auth.setPhoneNumber(_phoneController.text);
                  final success = await auth.sendOtp();
                  if (success && context.mounted) {
                    context.goNamed('otp');
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
