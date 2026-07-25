import 'package:flutter/material.dart';

/// Reusable fade + slide animation wrapper for page content.
class FadeSlideAnimation extends StatefulWidget {
  const FadeSlideAnimation({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 400),
    this.offset = const Offset(0, 20),
    this.curve = Curves.easeOut,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset offset;
  final Curve curve;

  @override
  State<FadeSlideAnimation> createState() => _FadeSlideAnimationState();
}

class _FadeSlideAnimationState extends State<FadeSlideAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    _slideAnimation = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.translate(
        offset: _slideAnimation.value,
        child: Opacity(
          opacity: _fadeAnimation.value,
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}
