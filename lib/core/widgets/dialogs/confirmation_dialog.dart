import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

/// Confirmation dialog with customizable title, message, and actions.
class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.confirmColor,
    this.icon,
    this.isDestructive = false,
  });

  final String title;
  final String? message;
  final String confirmLabel;
  final String cancelLabel;
  final Color? confirmColor;
  final IconData? icon;
  final bool isDestructive;

  /// Show the dialog and return true if confirmed.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    String? message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    Color? confirmColor,
    IconData? icon,
    bool isDestructive = false,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => ConfirmationDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        confirmColor: confirmColor,
        icon: icon,
        isDestructive: isDestructive,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = confirmColor ??
        (isDestructive ? theme.colorScheme.error : theme.colorScheme.primary);

    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 28, color: color),
                ),
                const SizedBox(height: 16),
              ],
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              if (message != null) ...[
                const SizedBox(height: 8),
                Text(
                  message!,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      label: cancelLabel,
                      onPressed: () => Navigator.of(context).pop(false),
                      height: 40,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: PrimaryButton(
                      label: confirmLabel,
                      onPressed: () => Navigator.of(context).pop(true),
                      color: color,
                      height: 40,
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
