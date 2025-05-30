import 'package:flutter/material.dart';
import 'package:paainet/utils/themeData/const.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.button,
      splashColor: AppColors.buttonHover.withOpacity(0.2),
      highlightColor: Colors.transparent,
      hoverColor: AppColors.buttonHover.withOpacity(0.1),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.text, fontSize: 16),
        bodyMedium: TextStyle(color: AppColors.text, fontSize: 14),
        titleLarge: TextStyle(
            color: AppColors.text, fontWeight: FontWeight.bold, fontSize: 18),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.button,
          foregroundColor: AppColors.buttonText,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ).copyWith(
          overlayColor: WidgetStateProperty.all(AppColors.buttonHover),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.secondaryButtonBorder),
          foregroundColor: AppColors.secondaryButtonText,
          backgroundColor: AppColors.secondaryButtonBg,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.success,
        contentTextStyle: const TextStyle(color: AppColors.buttonText),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.secondaryButtonBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.button),
        ),
        hintStyle: TextStyle(color: AppColors.text.withOpacity(0.5)),
      ),
    );
  }
}
