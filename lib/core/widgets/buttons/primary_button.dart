import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../constants/app_constants.dart';

/// Premium primary CTA button with animated hover and loading state.
class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isExpanded = true,
    this.icon,
    this.color,
    this.height = AppSpacing.buttonHeight,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isExpanded;
  final IconData? icon;
  final Color? color;
  final double height;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.color ?? AppColors.primary;
    final isDisabled = widget.onPressed == null || widget.isLoading;

    return MouseRegion(
      cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          if (!isDisabled) widget.onPressed!();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedContainer(
          duration: AppConstants.animFast,
          height: widget.height,
          width: widget.isExpanded ? double.infinity : null,
          padding: widget.isExpanded
              ? null
              : const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: isDisabled
                ? bgColor.withValues(alpha: 0.5)
                : _isHovered
                    ? Color.lerp(bgColor, Colors.black, 0.15)
                    : bgColor,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            boxShadow: _isHovered && !isDisabled
                ? [
                    BoxShadow(
                      color: bgColor.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          transform: _isPressed
              ? Matrix4.diagonal3Values(0.98, 0.98, 1.0)
              : Matrix4.identity(),
          alignment: Alignment.center,
          child: widget.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
              : Row(
                  mainAxisSize: widget.isExpanded
                      ? MainAxisSize.max
                      : MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.icon != null) ...[
                      Icon(widget.icon, size: 18, color: Colors.white),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      widget.label,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
