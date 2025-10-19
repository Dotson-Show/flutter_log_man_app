import 'package:flutter/material.dart';

class AppTheme {
  // Color Palette
  static const Color greyPrimary = Color(0xFFCDD1D1);
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyDark = Color(0xFF8B8B8B);
  static const Color greyMedium = Color(0xFFD4D4D4);

  // Accent Colors
  static const Color accentBlue = Color(0xFF0052CC);
  static const Color accentGreen = Color(0xFF00A86B);
  static const Color accentOrange = Color(0xFFFF6B35);
  static const Color accentRed = Color(0xFFE63946);
  static const Color accentPurple = Color(0xFF6B5B95);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: greyPrimary,
        primary: accentBlue,
        secondary: accentGreen,
        tertiary: accentOrange,
        surface: Colors.white,
        background: greyLight,
        error: accentRed,
      ),
      scaffoldBackgroundColor: greyLight,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          color: Color(0xFF1A1A1A),
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Color(0xFF1A1A1A)),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: greyMedium, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: greyLight,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: greyMedium),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: greyMedium, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentRed, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: accentRed, width: 2),
        ),
        labelStyle: const TextStyle(color: greyDark),
        hintStyle: TextStyle(color: greyDark.withOpacity(0.6)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accentBlue,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accentBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentBlue,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: accentBlue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: const Color(0xFF1A1A1A),
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
        displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
        headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
        headlineMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A)),
        headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A)),
        titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A)),
        titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A)),
        titleSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A)),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Color(0xFF333333)),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Color(0xFF555555)),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.normal, color: Color(0xFF777777)),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1A1A1A)),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) return accentBlue;
          return greyMedium;
        }),
        side: const BorderSide(color: greyMedium),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      dividerTheme: const DividerThemeData(
        color: greyMedium,
        thickness: 1,
        space: 16,
      ),
    );
  }
}