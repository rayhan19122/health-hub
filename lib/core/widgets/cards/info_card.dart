import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';
import '../../constants/app_constants.dart';

/// General-purpose hoverable info card.
class InfoCard extends StatefulWidget {
  const InfoCard({
    super.key,
    required this.child,
    this.onTap,
    this.accentColor,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius,
  });

  final Widget child;
  final VoidCallback? onTap;
  final Color? accentColor;
  final EdgeInsets padding;
  final BorderRadius? borderRadius;

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = widget.borderRadius ??
        BorderRadius.circular(AppSpacing.radiusXl);

    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) {
        if (widget.onTap != null) setState(() => _isHovered = true);
      },
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppConstants.animFast,
          padding: widget.padding,
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: radius,
            border: Border.all(
              color: _isHovered && widget.accentColor != null
                  ? widget.accentColor!
                  : theme.colorScheme.outline,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: (widget.accentColor ?? theme.colorScheme.primary)
                          .withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
