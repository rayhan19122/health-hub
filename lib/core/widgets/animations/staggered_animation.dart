import 'package:flutter/material.dart';
import 'fade_slide_animation.dart';

/// Applies staggered fade+slide animations to a list of children.
class StaggeredList extends StatelessWidget {
  const StaggeredList({
    super.key,
    required this.children,
    this.staggerDelay = const Duration(milliseconds: 60),
    this.baseDelay = Duration.zero,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
  });

  final List<Widget> children;
  final Duration staggerDelay;
  final Duration baseDelay;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: List.generate(children.length, (i) {
        return FadeSlideAnimation(
          delay: baseDelay + staggerDelay * i,
          child: children[i],
        );
      }),
    );
  }
}
