import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Status chip / badge for showing states like Available, Full, Open, Busy.
class StatusChip extends StatelessWidget {
  const StatusChip({
    super.key,
    required this.label,
    required this.color,
    this.isOutlined = false,
    this.showDot = false,
  });

  final String label;
  final Color color;
  final bool isOutlined;
  final bool showDot;

  /// Factory constructors for common statuses
  factory StatusChip.available() => const StatusChip(
        label: 'Available',
        color: AppColors.success,
        showDot: true,
      );

  factory StatusChip.open() => const StatusChip(
        label: 'Open',
        color: AppColors.success,
        showDot: true,
      );

  factory StatusChip.full() => const StatusChip(
        label: 'Full',
        color: AppColors.error,
        showDot: true,
      );

  factory StatusChip.busy() => const StatusChip(
        label: 'Busy',
        color: AppColors.error,
      );

  factory StatusChip.onTrip() => const StatusChip(
        label: 'On Trip',
        color: AppColors.warning,
      );

  factory StatusChip.approved() => const StatusChip(
        label: 'Approved ✓',
        color: AppColors.success,
      );

  factory StatusChip.expired() => const StatusChip(
        label: 'Expired',
        color: AppColors.warning,
      );

  factory StatusChip.rejected() => const StatusChip(
        label: 'Rejected',
        color: AppColors.error,
      );

  factory StatusChip.critical() => const StatusChip(
        label: 'CRITICAL',
        color: AppColors.critical,
      );

  factory StatusChip.urgent() => const StatusChip(
        label: 'URGENT',
        color: AppColors.warning,
      );

  factory StatusChip.standard() => const StatusChip(
        label: 'STANDARD',
        color: AppColors.primary,
      );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark
        ? color.withValues(alpha: 0.15)
        : color.withValues(alpha: 0.08);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isOutlined ? Colors.transparent : bgColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
        border: isOutlined ? Border.all(color: color) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
