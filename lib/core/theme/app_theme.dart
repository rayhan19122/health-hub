import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';
import 'app_spacing.dart';

/// HealthHub Design System — Complete Theme
///
/// Provides Material 3 ThemeData for both light and dark modes.
/// Every component theme is configured for a premium, cohesive look.
class AppTheme {
  AppTheme._();

  // ─────────────────────── LIGHT THEME ───────────────────────
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: _lightColorScheme,
        textTheme: _textTheme(Brightness.light),
        scaffoldBackgroundColor: AppColors.backgroundLight,
        appBarTheme: _appBarTheme(Brightness.light),
        cardTheme: _cardTheme(Brightness.light),
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme(Brightness.light),
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme(Brightness.light),
        chipTheme: _chipTheme(Brightness.light),
        dialogTheme: _dialogTheme(Brightness.light),
        snackBarTheme: _snackBarTheme(Brightness.light),
        dividerTheme: _dividerTheme(Brightness.light),
        tooltipTheme: _tooltipTheme(Brightness.light),
        iconTheme: const IconThemeData(color: AppColors.textSecondaryLight, size: 20),
        floatingActionButtonTheme: _fabTheme,
        navigationBarTheme: _navBarTheme(Brightness.light),
        popupMenuTheme: _popupMenuTheme(Brightness.light),
      );

  // ─────────────────────── DARK THEME ───────────────────────
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: _darkColorScheme,
        textTheme: _textTheme(Brightness.dark),
        scaffoldBackgroundColor: AppColors.backgroundDark,
        appBarTheme: _appBarTheme(Brightness.dark),
        cardTheme: _cardTheme(Brightness.dark),
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme(Brightness.dark),
        textButtonTheme: _textButtonTheme,
        inputDecorationTheme: _inputDecorationTheme(Brightness.dark),
        chipTheme: _chipTheme(Brightness.dark),
        dialogTheme: _dialogTheme(Brightness.dark),
        snackBarTheme: _snackBarTheme(Brightness.dark),
        dividerTheme: _dividerTheme(Brightness.dark),
        tooltipTheme: _tooltipTheme(Brightness.dark),
        iconTheme: const IconThemeData(color: AppColors.textSecondaryDark, size: 20),
        floatingActionButtonTheme: _fabTheme,
        navigationBarTheme: _navBarTheme(Brightness.dark),
        popupMenuTheme: _popupMenuTheme(Brightness.dark),
      );

  // ─────────────────────── COLOR SCHEMES ───────────────────────
  static const _lightColorScheme = ColorScheme.light(
    primary: AppColors.primary,
    onPrimary: Colors.white,
    primaryContainer: AppColors.primarySurface,
    onPrimaryContainer: AppColors.primaryDark,
    secondary: AppColors.secondary,
    onSecondary: Colors.white,
    error: AppColors.error,
    onError: Colors.white,
    errorContainer: AppColors.errorSurface,
    surface: AppColors.surfaceLight,
    onSurface: AppColors.textPrimaryLight,
    onSurfaceVariant: AppColors.textSecondaryLight,
    outline: AppColors.borderLight,
    outlineVariant: AppColors.borderLight,
    shadow: AppColors.shadowLight,
  );

  static const _darkColorScheme = ColorScheme.dark(
    primary: AppColors.primaryLight,
    onPrimary: Colors.white,
    primaryContainer: AppColors.primarySurfaceDark,
    onPrimaryContainer: AppColors.primaryLight,
    secondary: AppColors.secondaryLight,
    onSecondary: Colors.white,
    error: AppColors.errorLight,
    onError: Colors.white,
    errorContainer: AppColors.errorSurfaceDark,
    surface: AppColors.surfaceDark,
    onSurface: AppColors.textPrimaryDark,
    onSurfaceVariant: AppColors.textSecondaryDark,
    outline: AppColors.borderDark,
    outlineVariant: AppColors.borderDark,
    shadow: AppColors.shadowDark,
  );

  // ─────────────────────── TEXT THEME ───────────────────────
  static TextTheme _textTheme(Brightness brightness) {
    final color = brightness == Brightness.light
        ? AppColors.textPrimaryLight
        : AppColors.textPrimaryDark;
    return GoogleFonts.interTextTheme(
      TextTheme(
        displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.w800, letterSpacing: -1.5, color: color),
        displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.w800, letterSpacing: -1.0, color: color),
        displaySmall: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.5, color: color),
        headlineLarge: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, letterSpacing: -0.5, color: color),
        headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: -0.3, color: color),
        headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: -0.3, color: color),
        titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: -0.2, color: color),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: -0.1, color: color),
        titleSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: color),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: color),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: color),
        bodySmall: TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: color),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: color),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.5, color: color),
      ),
    );
  }

  // ─────────────────────── COMPONENT THEMES ───────────────────────

  static AppBarTheme _appBarTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: isDark
          ? AppColors.surfaceDark.withValues(alpha: 0.92)
          : AppColors.surfaceLight.withValues(alpha: 0.92),
      foregroundColor: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        letterSpacing: -0.3,
      ),
    );
  }

  static CardThemeData _cardTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return CardThemeData(
      elevation: 0,
      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXxl),
        side: BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
          width: 1,
        ),
      ),
      margin: EdgeInsets.zero,
    );
  }

  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static OutlinedButtonThemeData _outlinedButtonTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        side: BorderSide(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  static final _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  static InputDecorationTheme _inputDecorationTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return InputDecorationTheme(
      filled: true,
      fillColor: isDark ? AppColors.inputBgDark : AppColors.inputBgLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        borderSide: const BorderSide(color: AppColors.error),
      ),
      labelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
      ),
      hintStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: isDark ? AppColors.textTertiaryDark : AppColors.textTertiaryLight,
      ),
    );
  }

  static ChipThemeData _chipTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return ChipThemeData(
      backgroundColor: isDark ? AppColors.chipBgDark : AppColors.chipBgLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      side: BorderSide.none,
      labelStyle: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w500),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    );
  }

  static DialogThemeData _dialogTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return DialogThemeData(
      elevation: 0,
      backgroundColor: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusRound),
      ),
      titleTextStyle: GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimaryLight,
      ),
      contentTextStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondaryLight,
      ),
    );
  }

  static SnackBarThemeData _snackBarTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: isDark ? AppColors.surfaceLight : AppColors.textPrimaryLight,
      contentTextStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.textPrimaryLight : Colors.white,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      ),
    );
  }

  static DividerThemeData _dividerTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return DividerThemeData(
      color: isDark ? AppColors.borderDark : AppColors.borderLight,
      thickness: 1,
      space: 0,
    );
  }

  static TooltipThemeData _tooltipTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return TooltipThemeData(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceLight : AppColors.textPrimaryLight,
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.textPrimaryLight : Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    );
  }

  static const _fabTheme = FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 2,
    shape: CircleBorder(),
  );

  static NavigationBarThemeData _navBarTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return NavigationBarThemeData(
      backgroundColor: isDark
          ? AppColors.surfaceDark.withValues(alpha: 0.92)
          : AppColors.surfaceLight.withValues(alpha: 0.92),
      indicatorColor: AppColors.primary.withValues(alpha: 0.1),
      elevation: 0,
      height: AppSpacing.bottomBarHeight,
    );
  }

  static PopupMenuThemeData _popupMenuTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return PopupMenuThemeData(
      color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        side: BorderSide(color: isDark ? AppColors.borderDark : AppColors.borderLight),
      ),
      textStyle: GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
