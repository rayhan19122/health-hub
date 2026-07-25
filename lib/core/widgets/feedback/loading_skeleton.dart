import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/app_spacing.dart';

/// Shimmer loading skeleton for cards, lists, and content.
class LoadingSkeleton extends StatelessWidget {
  const LoadingSkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius,
  });

  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  /// Creates a skeleton card
  factory LoadingSkeleton.card({double height = 120}) => LoadingSkeleton(
        width: double.infinity,
        height: height,
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
      );

  /// Creates a skeleton line (for text)
  factory LoadingSkeleton.line({double width = 120, double height = 14}) =>
      LoadingSkeleton(width: width, height: height);

  /// Creates a circular skeleton (for avatars)
  factory LoadingSkeleton.circle({double size = 40}) =>
      LoadingSkeleton(width: size, height: size);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? const Color(0xFF2A2A2A) : const Color(0xFFE5E5E5);
    final highlightColor = isDark ? const Color(0xFF3A3A3A) : const Color(0xFFF5F5F5);
    final radius = borderRadius ?? BorderRadius.circular(AppSpacing.radiusSm);

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: width == height ? null : radius,
          shape: width == height ? BoxShape.circle : BoxShape.rectangle,
        ),
      ),
    );
  }
}

/// Loading skeleton for a card list
class CardListSkeleton extends StatelessWidget {
  const CardListSkeleton({super.key, this.count = 3});
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        count,
        (i) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: LoadingSkeleton.card(),
        ),
      ),
    );
  }
}
