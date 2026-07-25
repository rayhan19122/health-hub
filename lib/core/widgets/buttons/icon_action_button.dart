import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';
import '../../constants/app_constants.dart';

/// Small icon-only action button with tooltip and hover effect.
class IconActionButton extends StatefulWidget {
  const IconActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.size = 34,
    this.iconSize = 18,
    this.badge,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final double size;
  final double iconSize;
  final Widget? badge;

  @override
  State<IconActionButton> createState() => _IconActionButtonState();
}

class _IconActionButtonState extends State<IconActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final button = MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: AppConstants.animFast,
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: _isHovered
                ? (isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.black.withValues(alpha: 0.04))
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                widget.icon,
                size: widget.iconSize,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              if (widget.badge != null)
                Positioned(top: 5, right: 5, child: widget.badge!),
            ],
          ),
        ),
      ),
    );

    if (widget.tooltip != null) {
      return Tooltip(message: widget.tooltip!, child: button);
    }
    return button;
  }
}

/// Small notification badge dot
class NotificationBadge extends StatelessWidget {
  const NotificationBadge({
    super.key,
    this.color = const Color(0xFFC62828),
    this.size = 8,
  });

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.surface,
          width: 2,
        ),
      ),
    );
  }
}
