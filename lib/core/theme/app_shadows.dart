import 'package:flutter/material.dart';

/// HealthHub Design System — Shadow / Elevation
///
/// Soft, modern shadow system that avoids heavy Material elevation.
/// Uses subtle, diffused shadows for a premium SaaS look.
class AppShadows {
  AppShadows._();

  // ── Light Theme Shadows ──
  static List<BoxShadow> get sm => [
        const BoxShadow(
          color: Color(0x08000000),
          blurRadius: 4,
          offset: Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get md => [
        const BoxShadow(
          color: Color(0x0A000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
        const BoxShadow(
          color: Color(0x05000000),
          blurRadius: 4,
          offset: Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get lg => [
        const BoxShadow(
          color: Color(0x0F000000),
          blurRadius: 24,
          offset: Offset(0, 4),
        ),
        const BoxShadow(
          color: Color(0x05000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get xl => [
        const BoxShadow(
          color: Color(0x14000000),
          blurRadius: 40,
          offset: Offset(0, 8),
        ),
        const BoxShadow(
          color: Color(0x08000000),
          blurRadius: 16,
          offset: Offset(0, 4),
        ),
      ];

  // ── Card Hover Shadow ──
  static List<BoxShadow> cardHover(Color accent) => [
        BoxShadow(
          color: accent.withValues(alpha: 0.12),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ];

  // ── Dark Theme Shadows ──
  static List<BoxShadow> get smDark => [
        const BoxShadow(
          color: Color(0x33000000),
          blurRadius: 4,
          offset: Offset(0, 1),
        ),
      ];

  static List<BoxShadow> get mdDark => [
        const BoxShadow(
          color: Color(0x40000000),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get lgDark => [
        const BoxShadow(
          color: Color(0x4D000000),
          blurRadius: 24,
          offset: Offset(0, 4),
        ),
      ];
}
