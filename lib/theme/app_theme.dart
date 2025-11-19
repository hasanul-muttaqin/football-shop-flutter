import 'package:flutter/material.dart';

class BrandColors {
  static const Color primary = Color(0xFF1D4ED8);
  static const Color primaryDark = Color(0xFF1E3A8A);
  static const Color accent = Color(0xFFDC2626);
  static const Color surface = Color(0xFFF8FAFF);
  static const Color textPrimary = Color(0xFF1E3A8A);
  static const Color textMuted = Color(0xFF475569);
  static const Color success = Color(0xFF16A34A);
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: BrandColors.primary,
        primary: BrandColors.primary,
        secondary: BrandColors.accent,
        background: BrandColors.surface,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: BrandColors.surface,
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: BrandColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: base.textTheme.titleLarge?.copyWith(
          color: BrandColors.textPrimary,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: BrandColors.textPrimary,
        displayColor: BrandColors.textPrimary,
      ),
      chipTheme: base.chipTheme.copyWith(
        labelStyle: const TextStyle(color: BrandColors.textPrimary),
        backgroundColor: Colors.white,
        side: const BorderSide(color: Color(0xFFE1E6F5)),
        selectedColor: BrandColors.primary.withOpacity(0.1),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFFE1E6F5)),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: BrandColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: BrandColors.primary,
          elevation: 0,
          side: const BorderSide(color: Color(0xFFE1E6F5)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: BrandColors.primary,
          side: BorderSide(color: BrandColors.primary.withOpacity(0.3)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE1E6F5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFE1E6F5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: BrandColors.primary),
        ),
        labelStyle: const TextStyle(color: BrandColors.textMuted),
        hintStyle: const TextStyle(color: BrandColors.textMuted),
      ),
    );
  }
}
