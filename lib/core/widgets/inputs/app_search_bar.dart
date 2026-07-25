import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_spacing.dart';
import '../../constants/app_constants.dart';

/// Search bar with icon, placeholder, and optional clear button.
class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    this.hint = 'Search...',
    this.onChanged,
    this.onTap,
    this.controller,
    this.readOnly = false,
    this.accentColor,
  });

  final String hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final bool readOnly;
  final Color? accentColor;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      cursor: widget.readOnly
          ? SystemMouseCursors.click
          : SystemMouseCursors.text,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppConstants.animFast,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            border: Border.all(
              color: _isHovered
                  ? (widget.accentColor ?? theme.colorScheme.primary)
                  : theme.colorScheme.outline,
            ),
            color: isDark
                ? const Color(0xFF2A2A2A)
                : const Color(0xFFFAFAFA),
          ),
          child: widget.readOnly
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    children: [
                      Icon(Icons.search_rounded, size: 16, color: theme.colorScheme.onSurfaceVariant),
                      const SizedBox(width: 8),
                      Text(
                        widget.hint,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                )
              : TextField(
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: theme.colorScheme.onSurface,
                  ),
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    prefixIcon: Icon(Icons.search_rounded, size: 18, color: theme.colorScheme.onSurfaceVariant),
                    prefixIconConstraints: const BoxConstraints(minWidth: 40),
                    isDense: true,
                  ),
                ),
        ),
      ),
    );
  }
}
