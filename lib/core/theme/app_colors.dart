import 'package:flutter/material.dart';

/// HealthHub Design System — Color Palette
///
/// Semantic color tokens for both light and dark themes.
/// Inspired by the HealthHub brand with blue primary, red emergency,
/// pink blood bank, and teal secondary accents.
class AppColors {
  AppColors._();

  // ── Brand Primary (Blue) ──
  static const Color primary = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color primarySurface = Color(0xFFE3F2FD);
  static const Color primarySurfaceDark = Color(0xFF1A2332);

  // ── Secondary (Teal) ──
  static const Color secondary = Color(0xFF00897B);
  static const Color secondaryLight = Color(0xFF4DB6AC);
  static const Color secondaryDark = Color(0xFF00695C);

  // ── Error / Emergency (Red) ──
  static const Color error = Color(0xFFC62828);
  static const Color errorLight = Color(0xFFEF5350);
  static const Color errorDark = Color(0xFFB71C1C);
  static const Color errorSurface = Color(0xFFFCE4EC);
  static const Color errorSurfaceDark = Color(0xFF2D1517);

  // ── Warning (Amber) ──
  static const Color warning = Color(0xFFF57F17);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFE65100);
  static const Color warningSurface = Color(0xFFFFF8E1);
  static const Color warningSurfaceDark = Color(0xFF2D2517);

  // ── Success (Green) ──
  static const Color success = Color(0xFF2E7D32);
  static const Color successLight = Color(0xFF66BB6A);
  static const Color successDark = Color(0xFF1B5E20);
  static const Color successSurface = Color(0xFFE8F5E9);
  static const Color successSurfaceDark = Color(0xFF1A2D1A);

  // ── Blood Bank Accent (Pink) ──
  static const Color bloodBank = Color(0xFFAD1457);
  static const Color bloodBankLight = Color(0xFFEC407A);
  static const Color bloodBankDark = Color(0xFF880E4F);
  static const Color bloodBankSurface = Color(0xFFFCE4EC);
  static const Color bloodBankSurfaceDark = Color(0xFF2D1520);

  // ── Critical (Deep Red) ──
  static const Color critical = Color(0xFFD50000);

  // ── Light Theme Neutrals ──
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color borderLight = Color(0xFFE5E5E5);
  static const Color inputBgLight = Color(0xFFFAFAFA);
  static const Color chipBgLight = Color(0xFFF0F0F0);
  static const Color hoverLight = Color(0x0A000000);
  static const Color shadowLight = Color(0x0F000000);

  // ── Light Theme Text ──
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textTertiaryLight = Color(0xFF9E9E9E);

  // ── Dark Theme Neutrals ──
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color borderDark = Color(0xFF333333);
  static const Color inputBgDark = Color(0xFF2A2A2A);
  static const Color chipBgDark = Color(0xFF2A2A2A);
  static const Color hoverDark = Color(0x0FFFFFFF);
  static const Color shadowDark = Color(0x66000000);

  // ── Dark Theme Text ──
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color textTertiaryDark = Color(0xFF666666);

  // ── Sidebar ──
  static const Color sidebarLight = Color(0xFFFAFAFA);
  static const Color sidebarDark = Color(0xFF1A1A1A);

  // ── Map ──
  static const Color mapBgLight = Color(0xFFE8E4DC);
  static const Color mapBgDark = Color(0xFF1A1C20);
  static const Color mapLineLight = Color(0xFFC8C4BC);
  static const Color mapLineDark = Color(0xFF333333);
}
