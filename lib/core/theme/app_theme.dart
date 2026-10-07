import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_study_lab/core/constants/app_constants.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.primaryLight,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSurface: AppColors.textDark,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        displayLarge: GoogleFonts.playfairDisplay(
          fontSize: 48,
          fontWeight: FontWeight.normal,
          color: AppColors.textDark,
          letterSpacing: -1.0,
        ),
        displayMedium: GoogleFonts.playfairDisplay(
          fontSize: 36,
          fontWeight: FontWeight.normal,
          color: AppColors.textDark,
          letterSpacing: -0.5,
        ),
        headlineLarge: GoogleFonts.playfairDisplay(
          fontSize: 28,
          fontWeight: FontWeight.w500,
          color: AppColors.textDark,
        ),
        headlineMedium: GoogleFonts.playfairDisplay(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textDark,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 15,
          color: AppColors.textDark,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.textMuted,
          height: 1.4,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
        labelSmall: GoogleFonts.jetBrainsMono(
          fontSize: 11,
          letterSpacing: 0.8,
          color: AppColors.textMuted,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withValues(alpha: 0.9),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
    );
  }
}
