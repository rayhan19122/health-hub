import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../buttons/icon_action_button.dart';

/// Top navigation bar with logo, dark mode toggle, notifications, and profile.
class AppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const AppTopBar({
    super.key,
    required this.onThemeToggle,
    required this.onNotificationTap,
    required this.onProfileTap,
    this.userName,
    this.userRole,
    this.isDarkMode = false,
    this.hasNotification = true,
    this.onLogoTap,
  });

  final VoidCallback onThemeToggle;
  final VoidCallback onNotificationTap;
  final VoidCallback onProfileTap;
  final String? userName;
  final String? userRole;
  final bool isDarkMode;
  final bool hasNotification;
  final VoidCallback? onLogoTap;

  @override
  Size get preferredSize => const Size.fromHeight(AppSpacing.topBarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: AppSpacing.topBarHeight,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceDark.withValues(alpha: 0.92)
            : AppColors.surfaceLight.withValues(alpha: 0.92),
        border: Border(
          bottom: BorderSide(color: theme.colorScheme.outline),
        ),
      ),
      // backdrop blur handled via ClipRect + BackdropFilter in shell
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // Logo
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: onLogoTap,
              child: Row(
                children: [
                  _LogoIcon(),
                  const SizedBox(width: 8),
                  Text(
                    'HealthHub',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                      letterSpacing: -0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),

          // Actions
          IconActionButton(
            icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            onPressed: onThemeToggle,
            tooltip: isDark ? 'Light mode' : 'Dark mode',
          ),
          const SizedBox(width: 4),
          IconActionButton(
            icon: Icons.notifications_outlined,
            onPressed: onNotificationTap,
            tooltip: 'Notifications',
            badge: hasNotification ? const NotificationBadge() : null,
          ),
          const SizedBox(width: 8),

          // Profile chip
          _ProfileChip(
            name: userRole ?? 'Patient',
            initial: userName?.isNotEmpty == true ? userName![0] : 'U',
            onTap: onProfileTap,
            avatarColor: _roleColor(userRole),
          ),
        ],
      ),
    );
  }

  Color _roleColor(String? role) {
    switch (role?.toLowerCase()) {
      case 'hospital admin':
        return AppColors.secondary;
      case 'super admin':
        return const Color(0xFF7B1FA2);
      default:
        return AppColors.primary;
    }
  }
}

class _LogoIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(7),
      ),
      child: const Center(
        child: Icon(Icons.local_hospital_rounded, size: 16, color: Colors.white),
      ),
    );
  }
}

class _ProfileChip extends StatefulWidget {
  const _ProfileChip({
    required this.name,
    required this.initial,
    required this.onTap,
    required this.avatarColor,
  });

  final String name;
  final String initial;
  final VoidCallback onTap;
  final Color avatarColor;

  @override
  State<_ProfileChip> createState() => _ProfileChipState();
}

class _ProfileChipState extends State<_ProfileChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.fromLTRB(4, 4, 12, 4),
          decoration: BoxDecoration(
            color: _isHovered
                ? (isDark ? AppColors.hoverDark : AppColors.hoverLight)
                : (isDark ? AppColors.chipBgDark : AppColors.chipBgLight),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: widget.avatarColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.initial.toUpperCase(),
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                widget.name,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
