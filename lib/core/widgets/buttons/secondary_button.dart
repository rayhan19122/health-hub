import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_spacing.dart';
import '../../constants/app_constants.dart';

/// Secondary / outlined button with hover effects.
class SecondaryButton extends StatefulWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isExpanded = true,
    this.icon,
    this.accentColor,
    this.height = AppSpacing.buttonHeight,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isExpanded;
  final IconData? icon;
  final Color? accentColor;
  final double height;

  @override
  State<SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<SecondaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = widget.accentColor ?? theme.colorScheme.outline;
    final textColor = widget.accentColor ?? theme.colorScheme.onSurface;

    return MouseRegion(
      cursor: widget.onPressed == null
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: AppConstants.animFast,
          height: widget.height,
          width: widget.isExpanded ? double.infinity : null,
          padding: widget.isExpanded
              ? null
              : const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: _isHovered
                ? (widget.accentColor ?? theme.colorScheme.primary)
                    .withValues(alpha: 0.04)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            border: Border.all(
              color: _isHovered
                  ? (widget.accentColor ?? theme.colorScheme.primary)
                  : borderColor,
            ),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize:
                widget.isExpanded ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 18,
                  color: _isHovered
                      ? (widget.accentColor ?? theme.colorScheme.primary)
                      : textColor,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: _isHovered
                      ? (widget.accentColor ?? theme.colorScheme.primary)
                      : textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
