import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../constants/app_constants.dart';

/// Service card used on the home screen for Hospital Beds, Ambulance, Blood Bank.
class ServiceCard extends StatefulWidget {
  const ServiceCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
    this.accentColor = AppColors.primary,
    this.statusText,
    this.statusColor = AppColors.success,
  });

  final String title;
  final String description;
  final Widget icon;
  final VoidCallback onTap;
  final Color accentColor;
  final String? statusText;
  final Color statusColor;

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppConstants.animNormal,
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
            border: Border.all(
              color: _isHovered
                  ? widget.accentColor
                  : theme.colorScheme.outline,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: widget.accentColor.withValues(alpha: 0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          transform: _isHovered
              ? Matrix4.translationValues(0.0, -2.0, 0.0)
              : Matrix4.identity(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: widget.accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
                ),
                child: Center(child: widget.icon),
              ),
              const SizedBox(height: 16),

              // Title
              Text(
                widget.title,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 4),

              // Description
              Text(
                widget.description,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 14),

              // Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.statusText != null)
                    Row(
                      children: [
                        _PulsingDot(color: widget.statusColor),
                        const SizedBox(width: 4),
                        Text(
                          widget.statusText!,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: widget.statusColor,
                          ),
                        ),
                      ],
                    )
                  else
                    const SizedBox.shrink(),
                  Text(
                    'Open →',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: widget.accentColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Animated pulsing dot for live status indicators.
class _PulsingDot extends StatefulWidget {
  const _PulsingDot({required this.color});
  final Color color;

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) => Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: widget.color.withValues(alpha: _animation.value),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
