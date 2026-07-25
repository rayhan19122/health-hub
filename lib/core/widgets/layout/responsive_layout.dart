import 'package:flutter/material.dart';
import '../../constants/app_breakpoints.dart';
import '../../theme/app_spacing.dart';

/// Responsive layout that renders different children for mobile/tablet/desktop.
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppBreakpoints.tablet) {
          return desktop ?? tablet ?? mobile;
        }
        if (constraints.maxWidth >= AppBreakpoints.mobile) {
          return tablet ?? mobile;
        }
        return mobile;
      },
    );
  }
}

/// Page container with max-width constraint and responsive padding.
class PageContainer extends StatelessWidget {
  const PageContainer({
    super.key,
    required this.child,
    this.maxWidth = AppSpacing.maxCardListWidth,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final pagePadding = padding ??
        EdgeInsets.symmetric(
          horizontal: AppBreakpoints.isMobile(width)
              ? AppSpacing.pagePaddingMobile
              : AppBreakpoints.isTablet(width)
                  ? AppSpacing.pagePaddingTablet
                  : AppSpacing.pagePaddingDesktop,
        );

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: pagePadding,
          child: child,
        ),
      ),
    );
  }
}
