import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';

/// Bottom navigation bar for mobile views.
class AppBottomBar extends StatelessWidget {
  const AppBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    _BottomNavData(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
    _BottomNavData(icon: Icons.grid_view_outlined, activeIcon: Icons.grid_view_rounded, label: 'Services'),
    _BottomNavData(icon: Icons.location_on_outlined, activeIcon: Icons.location_on_rounded, label: 'Map'),
    _BottomNavData(icon: Icons.notifications_outlined, activeIcon: Icons.notifications_rounded, label: 'Alerts'),
    _BottomNavData(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      height: AppSpacing.bottomBarHeight,
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.surfaceDark.withValues(alpha: 0.92)
            : AppColors.surfaceLight.withValues(alpha: 0.92),
        border: Border(
          top: BorderSide(color: theme.colorScheme.outline),
        ),
      ),
      child: Row(
        children: List.generate(_items.length, (i) {
          final item = _items[i];
          final isActive = i == currentIndex;

          return Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(i),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isActive ? item.activeIcon : item.icon,
                    size: 22,
                    color: isActive
                        ? AppColors.primary
                        : theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.label,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isActive
                          ? AppColors.primary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _BottomNavData {
  const _BottomNavData({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}
