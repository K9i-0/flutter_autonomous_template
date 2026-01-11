import 'package:flutter/material.dart';

/// Application color palette - Timee Style
///
/// Semantic colors for consistent theming across light and dark modes.
/// Based on Timee's yellow brand identity (#FFD700).
abstract class AppColors {
  // Primary colors - Timee Yellow Brand
  static const Color primaryLight = Color(0xFFFFD700);
  static const Color primaryDark = Color(0xFFFFE135);
  static const Color primaryContainerLight = Color(0xFFFFF8DC);
  static const Color primaryContainerDark = Color(0xFF5C4A00);

  // Secondary colors - Blue accent (for CTAs)
  static const Color secondaryLight = Color(0xFF0066FF);
  static const Color secondaryDark = Color(0xFF4D94FF);

  // Tertiary colors - Blue for info
  static const Color tertiaryLight = Color(0xFF1976D2);
  static const Color tertiaryDark = Color(0xFF64B5F6);

  // Error colors
  static const Color errorLight = Color(0xFFD32F2F);
  static const Color errorDark = Color(0xFFEF5350);

  // Success colors
  static const Color successLight = Color(0xFF4CAF50);
  static const Color successDark = Color(0xFF81C784);

  // Warning colors
  static const Color warningLight = Color(0xFFFF9800);
  static const Color warningDark = Color(0xFFFFB74D);

  // Surface colors - Light theme (clean white backgrounds)
  static const Color surfaceLight = Color(0xFFFAFAFA);
  static const Color surfaceContainerLowestLight = Colors.white;
  static const Color surfaceContainerLowLight = Color(0xFFF9F9F9);
  static const Color surfaceContainerLight = Color(0xFFF5F5F5);
  static const Color surfaceContainerHighLight = Color(0xFFEEEEEE);
  static const Color surfaceContainerHighestLight = Color(0xFFE0E0E0);

  // Surface colors - Dark theme
  static const Color surfaceDark = Color(0xFF121212);
  static const Color surfaceContainerLowestDark = Color(0xFF121212);
  static const Color surfaceContainerLowDark = Color(0xFF1E1E1E);
  static const Color surfaceContainerDark = Color(0xFF252525);
  static const Color surfaceContainerHighDark = Color(0xFF2C2C2C);
  static const Color surfaceContainerHighestDark = Color(0xFF333333);

  // Outline colors
  static const Color outlineLight = Color(0xFF999999);
  static const Color outlineDark = Color(0xFF5A5A5A);
  static const Color outlineVariantLight = Color(0xFFE8E8E8);
  static const Color outlineVariantDark = Color(0xFF3A3A3A);

  // On-surface colors
  static const Color onPrimaryLight = Color(0xFF333333); // Dark text on yellow
  static const Color onPrimaryDark = Color(0xFF333333);
  static const Color onSecondaryLight = Colors.white; // White text on blue
  static const Color onSecondaryDark = Colors.white;
  static const Color onErrorLight = Colors.white;
  static const Color onErrorDark = Colors.black;

  // Timee-specific semantic colors
  static const Color textPrimaryLight = Color(0xFF333333);
  static const Color textSecondaryLight = Color(0xFF999999);
  static const Color textDisabledLight = Color(0xFFCCCCCC);
  static const Color textPrimaryDark = Color(0xFFFAFAFA);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color textDisabledDark = Color(0xFF6A6A6A);

  // Timee accent colors
  static const Color accentPink = Color(0xFFFF6B6B);
  static const Color accentPurple = Color(0xFF9966FF);
  static const Color accentGreen = Color(0xFF66BB6A);
}

/// Category colors for TODO items or tags
abstract class CategoryColors {
  static const Color red = Color(0xFFEF4444);
  static const Color orange = Color(0xFFF97316);
  static const Color amber = Color(0xFFF59E0B);
  static const Color yellow = Color(0xFFEAB308);
  static const Color lime = Color(0xFF84CC16);
  static const Color green = Color(0xFF22C55E);
  static const Color emerald = Color(0xFF10B981);
  static const Color teal = Color(0xFF14B8A6);
  static const Color cyan = Color(0xFF06B6D4);
  static const Color sky = Color(0xFF0EA5E9);
  static const Color blue = Color(0xFF3B82F6);
  static const Color indigo = Color(0xFF6366F1);
  static const Color violet = Color(0xFF8B5CF6);
  static const Color purple = Color(0xFFA855F7);
  static const Color fuchsia = Color(0xFFD946EF);
  static const Color pink = Color(0xFFEC4899);
  static const Color rose = Color(0xFFF43F5E);

  /// Get category color by index (wraps around)
  static Color byIndex(int index) {
    const colors = [
      blue,
      green,
      purple,
      orange,
      pink,
      teal,
      amber,
      indigo,
      emerald,
      rose,
    ];
    return colors[index % colors.length];
  }
}

/// ColorScheme builders for theme construction
extension AppColorScheme on AppColors {
  static ColorScheme lightScheme() {
    return ColorScheme.light(
      surface: AppColors.surfaceLight,
      surfaceContainerLowest: AppColors.surfaceContainerLowestLight,
      surfaceContainerLow: AppColors.surfaceContainerLowLight,
      surfaceContainer: AppColors.surfaceContainerLight,
      surfaceContainerHigh: AppColors.surfaceContainerHighLight,
      surfaceContainerHighest: AppColors.surfaceContainerHighestLight,
      primary: AppColors.primaryLight,
      onPrimary: AppColors.onPrimaryLight,
      primaryContainer: AppColors.primaryContainerLight,
      secondary: AppColors.secondaryLight,
      onSecondary: AppColors.onSecondaryLight,
      tertiary: AppColors.tertiaryLight,
      error: AppColors.errorLight,
      onError: AppColors.onErrorLight,
      outline: AppColors.outlineLight,
      outlineVariant: AppColors.outlineVariantLight,
    );
  }

  static ColorScheme darkScheme() {
    return ColorScheme.dark(
      surface: AppColors.surfaceDark,
      surfaceContainerLowest: AppColors.surfaceContainerLowestDark,
      surfaceContainerLow: AppColors.surfaceContainerLowDark,
      surfaceContainer: AppColors.surfaceContainerDark,
      surfaceContainerHigh: AppColors.surfaceContainerHighDark,
      surfaceContainerHighest: AppColors.surfaceContainerHighestDark,
      primary: AppColors.primaryDark,
      onPrimary: AppColors.onPrimaryDark,
      primaryContainer: AppColors.primaryContainerDark,
      secondary: AppColors.secondaryDark,
      onSecondary: AppColors.onSecondaryDark,
      tertiary: AppColors.tertiaryDark,
      error: AppColors.errorDark,
      onError: AppColors.onErrorDark,
      outline: AppColors.outlineDark,
      outlineVariant: AppColors.outlineVariantDark,
    );
  }
}
