import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppColors {
  static const primary = Color(0xFF2563EB);
  static const primaryDark = Color(0xFF1D4ED8);
  static const secondary = Color(0xFFDBEAFE);
  static const background = Color(0xFFF5F8FC);
  static const surface = Colors.white;
  static const textPrimary = Color(0xFF172033);
  static const textSecondary = Color(0xFF64748B);
  static const border = Color(0xFFE2E8F0);
  static const success = Color(0xFF059669);
  static const warning = Color(0xFFD97706);
  static const error = Color(0xFFDC2626);
}

abstract final class AppTextStyles {
  static TextStyle heading({
    double? fontSize,
    FontWeight fontWeight = FontWeight.w700,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? AppColors.textPrimary,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}

abstract final class AppTheme {
  static ThemeData get light {
    final textTheme = GoogleFonts.interTextTheme().copyWith(
      displayLarge: AppTextStyles.heading(
        fontSize: 57,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: AppTextStyles.heading(
        fontSize: 45,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: AppTextStyles.heading(
        fontSize: 36,
        fontWeight: FontWeight.w700,
      ),
      headlineLarge: AppTextStyles.heading(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: AppTextStyles.heading(
        fontSize: 28,
        fontWeight: FontWeight.w700,
      ),
      headlineSmall: AppTextStyles.heading(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: AppTextStyles.heading(
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: AppTextStyles.heading(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: AppTextStyles.heading(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            surface: AppColors.surface,
          ).copyWith(
            primary: AppColors.primary,
            secondary: AppColors.primaryDark,
            error: AppColors.error,
          ),
      scaffoldBackgroundColor: AppColors.background,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: AppColors.surface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.heading(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 1,
        shadowColor: const Color(0x14172033),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surface,
          minimumSize: const Size(48, 48),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w700),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(48, 48),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w700),
          side: const BorderSide(color: AppColors.secondary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: GoogleFonts.inter(color: AppColors.textSecondary),
        prefixIconColor: AppColors.textSecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surface,
        side: const BorderSide(color: AppColors.border),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
