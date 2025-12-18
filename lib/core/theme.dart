import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Premium Dark Theme Palette
  static const Color background = Color(0xFF121212);
  static const Color surface = Color(0xFF1E1E1E);
  static const Color primary = Color(0xFFFF4B3A); // Vibrant Orange-Red
  static const Color secondary = Color(0xFFFFBC2C); // Gold/Yellow
  static const Color textHigh = Color(0xFFFFFFFF);
  static const Color textMedium = Color(0xB3FFFFFF);
  static const Color textLow = Color(0x66FFFFFF);
  
  // Glassmorphism
  static const Color glassBorder = Color(0x1AFFFFFF);
  static const Color glassFill = Color(0x0DFFFFFF);
}

class AppTextStyles {
  static TextStyle get displayLarge => GoogleFonts.playfairDisplay( // Premium Serif
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: AppColors.textHigh,
    letterSpacing: 0.5,
  );

  static TextStyle get titleLarge => GoogleFonts.playfairDisplay(
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: AppColors.textHigh,
  );

  static TextStyle get titleMedium => GoogleFonts.raleway( // Clean Sans-Serif
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.textHigh,
    letterSpacing: 0.5,
  );

  static TextStyle get bodyLarge => GoogleFonts.montserrat(
    fontSize: 16,
    fontWeight: FontWeight.w600, // Bold
    color: AppColors.textMedium,
  );

  static TextStyle get bodyMedium => GoogleFonts.montserrat(
    fontSize: 14,
    fontWeight: FontWeight.w600, // Bold
    color: AppColors.textMedium,
  );
  
  static TextStyle get price => GoogleFonts.montserrat(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
  );
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
      ),
      textTheme: TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
      ),
      useMaterial3: true,
    );
  }
}
