import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../constants/app_constants.dart';

/// Collapsible sidebar for admin/desktop views.
class AppSidebar extends StatelessWidget {
  const AppSidebar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.items,
    required this.selectedIndex,
    required this.onItemTap,
  });

  final String title;
  final String subtitle;
  final List<SidebarItem> items;
  final int selectedIndex;
  final ValueChanged<int> onItemTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: AppSpacing.sidebarWidth,
      decoration: BoxDecoration(
        color: isDark ? AppColors.sidebarDark : AppColors.sidebarLight,
        border: Border(
          right: BorderSide(color: theme.colorScheme.outline),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
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
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          // Nav items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: List.generate(items.length, (i) {
                  return _SidebarNavItem(
                    item: items[i],
                    isSelected: i == selectedIndex,
                    onTap: () => onItemTap(i),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Data class for sidebar items.
class SidebarItem {
  const SidebarItem({
    required this.label,
    this.icon,
    this.badge,
  });

  final String label;
  final IconData? icon;
  final int? badge;
}

class _SidebarNavItem extends StatefulWidget {
  const _SidebarNavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final SidebarItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_SidebarNavItem> createState() => _SidebarNavItemState();
}

class _SidebarNavItemState extends State<_SidebarNavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: AppConstants.animFast,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: widget.isSelected
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : _isHovered
                      ? (isDark ? AppColors.hoverDark : AppColors.hoverLight)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Row(
              children: [
                if (widget.item.icon != null) ...[
                  Icon(
                    widget.item.icon,
                    size: 16,
                    color: widget.isSelected
                        ? AppColors.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Text(
                    widget.item.label,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: widget.isSelected
                          ? AppColors.primary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                if (widget.item.badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${widget.item.badge}',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
