import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_shadows.dart';
import '../../constants/app_constants.dart';

/// Statistics card showing a metric with label and optional trend.
class StatCard extends StatefulWidget {
  const StatCard({
    super.key,
    required this.value,
    required this.label,
    this.trend,
    this.trendColor,
    this.valueColor,
    this.icon,
  });

  final String value;
  final String label;
  final String? trend;
  final Color? trendColor;
  final Color? valueColor;
  final IconData? icon;

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppConstants.animFast,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
          border: Border.all(color: theme.colorScheme.outline),
          boxShadow: _isHovered ? (isDark ? AppShadows.mdDark : AppShadows.md) : null,
        ),
        transform: _isHovered
            ? Matrix4.translationValues(0.0, -2.0, 0.0)
            : Matrix4.identity(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.label.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurfaceVariant,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                if (widget.icon != null)
                  Icon(widget.icon, size: 16, color: theme.colorScheme.onSurfaceVariant),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.value,
              style: GoogleFonts.inter(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: widget.valueColor ?? theme.colorScheme.onSurface,
                letterSpacing: -1.0,
                height: 1.0,
              ),
            ),
            if (widget.trend != null) ...[
              const SizedBox(height: 4),
              Text(
                widget.trend!,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: widget.trendColor ?? theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
