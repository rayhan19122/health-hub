import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// HealthHub Design System — Typography
///
/// Uses Inter via Google Fonts for a clean, modern, highly legible interface.
/// Scale follows Material 3 type scale with custom adjustments for SaaS aesthetic.
class AppTypography {
  AppTypography._();

  /// Base text theme built from Inter
  static TextTheme get textTheme => GoogleFonts.interTextTheme();

  // ── Display ──
  static TextStyle displayLarge = GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.5,
    height: 1.1,
  );

  static TextStyle displayMedium = GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.0,
    height: 1.15,
  );

  static TextStyle displaySmall = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    height: 1.2,
  );

  // ── Headline ──
  static TextStyle headlineLarge = GoogleFonts.inter(
    fontSize: 26,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.25,
  );

  static TextStyle headlineMedium = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 1.3,
  );

  static TextStyle headlineSmall = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 1.3,
  );

  // ── Title ──
  static TextStyle titleLarge = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
    height: 1.35,
  );

  static TextStyle titleMedium = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
    height: 1.4,
  );

  static TextStyle titleSmall = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // ── Body ──
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  // ── Label ──
  static TextStyle labelLarge = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static TextStyle labelMedium = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
  );

  static TextStyle labelSmall = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );

  // ── Caption ──
  static TextStyle caption = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.3,
  );

  // ── Stat Number ──
  static TextStyle statLarge = GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.0,
    height: 1.0,
  );

  static TextStyle statMedium = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    letterSpacing: -1.0,
    height: 1.0,
  );

  static TextStyle statSmall = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    height: 1.0,
  );

  // ── Overline (uppercase labels) ──
  static TextStyle overline = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.4,
  );
}
