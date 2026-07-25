import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/widgets/animations/fade_slide_animation.dart';

/// Notifications page showing grouped alerts.
class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: FadeSlideAnimation(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Notifications',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 16),

                // Today
                _sectionHeader(context, 'Today'),
                const SizedBox(height: 8),
                _notificationItem(
                  context,
                  icon: '🚑',
                  color: AppColors.success,
                  title: 'Ambulance Assigned',
                  body: 'Mohammad Karim (DHA-1245) is en route. ETA 4 min.',
                  time: '2 min ago',
                ),
                const SizedBox(height: 6),
                _notificationItem(
                  context,
                  icon: '🩸',
                  color: AppColors.bloodBank,
                  title: 'Blood Request Approved',
                  body: 'Your A+ blood request has been approved. Collect by 11:00 AM.',
                  time: '35 min ago',
                ),
                const SizedBox(height: 6),
                _notificationItem(
                  context,
                  icon: '🛏️',
                  color: AppColors.primary,
                  title: 'Bed Reservation Approved',
                  body: 'ICU bed at Dhaka Medical confirmed. Hold expires in 18:42.',
                  time: '1 hour ago',
                ),

                const SizedBox(height: 20),

                // Earlier
                _sectionHeader(context, 'Earlier'),
                const SizedBox(height: 8),
                _notificationItem(
                  context,
                  icon: '⏰',
                  color: AppColors.warning,
                  title: 'Bed Reservation Expired',
                  body: 'Your ICU hold at United Hospital has expired.',
                  time: 'Yesterday, 3:15 PM',
                  isOld: true,
                ),
                const SizedBox(height: 6),
                _notificationItem(
                  context,
                  icon: '❌',
                  color: AppColors.error,
                  title: 'Blood Request Rejected',
                  body: 'AB- blood not available at Quantum Blood Bank.',
                  time: 'Yesterday, 11:00 AM',
                  isOld: true,
                ),
                const SizedBox(height: 6),
                _notificationItem(
                  context,
                  icon: '✅',
                  color: AppColors.success,
                  title: 'Driver Arrived',
                  body: 'Ambulance DHA-2301 has arrived at your location.',
                  time: 'Jul 10, 2:30 PM',
                  isOld: true,
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader(BuildContext context, String label) {
    return Text(
      label.toUpperCase(),
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _notificationItem(
    BuildContext context, {
    required String icon,
    required Color color,
    required String title,
    required String body,
    required String time,
    bool isOld = false,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border.all(color: theme.colorScheme.outline),
        // Left accent border
      ),
      foregroundDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        border: Border(
          left: BorderSide(color: color, width: 4),
        ),
      ),
      child: Opacity(
        opacity: isOld ? 0.7 : 1.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              alignment: Alignment.center,
              child: Text(icon, style: const TextStyle(fontSize: 16)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    body,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
