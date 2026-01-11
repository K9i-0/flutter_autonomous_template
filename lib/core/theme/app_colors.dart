import 'package:flutter/material.dart';

/// Application color palette - Discord Style
///
/// Discord-inspired colors for consistent theming across light and dark modes.
/// Use these colors instead of hardcoded values.
abstract class AppColors {
  // Primary colors - Discord Blurple
  static const Color primaryLight = Color(0xFF5865F2);
  static const Color primaryDark = Color(0xFF7289DA);
  static const Color primaryContainerLight = Color(0xFFE8EAFD);
  static const Color primaryContainerDark = Color(0xFF4752C4);

  // Secondary colors - Discord Green
  static const Color secondaryLight = Color(0xFF3BA55C);
  static const Color secondaryDark = Color(0xFF57F287);

  // Tertiary colors - Discord Link Blue
  static const Color tertiaryLight = Color(0xFF00AFF4);
  static const Color tertiaryDark = Color(0xFF00D4FF);

  // Error colors - Discord Red
  static const Color errorLight = Color(0xFFED4245);
  static const Color errorDark = Color(0xFFF04747);

  // Success colors - Discord Green
  static const Color successLight = Color(0xFF3BA55C);
  static const Color successDark = Color(0xFF57F287);

  // Warning colors - Discord Yellow
  static const Color warningLight = Color(0xFFFAA61A);
  static const Color warningDark = Color(0xFFFEE75C);

  // Surface colors - Light theme (Discord Light)
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceContainerLowestLight = Color(0xFFFFFFFF);
  static const Color surfaceContainerLowLight = Color(0xFFF9FAFB);
  static const Color surfaceContainerLight = Color(0xFFF2F3F5);
  static const Color surfaceContainerHighLight = Color(0xFFEBEDEF);
  static const Color surfaceContainerHighestLight = Color(0xFFE3E5E8);

  // Surface colors - Dark theme (Discord Dark)
  static const Color surfaceDark = Color(0xFF313338);
  static const Color surfaceContainerLowestDark = Color(0xFF1E1F22);
  static const Color surfaceContainerLowDark = Color(0xFF232428);
  static const Color surfaceContainerDark = Color(0xFF2B2D31);
  static const Color surfaceContainerHighDark = Color(0xFF383A40);
  static const Color surfaceContainerHighestDark = Color(0xFF404249);

  // Outline colors
  static const Color outlineLight = Color(0xFFB5BAC1);
  static const Color outlineDark = Color(0xFF4E5058);
  static const Color outlineVariantLight = Color(0xFFE3E5E8);
  static const Color outlineVariantDark = Color(0xFF383A40);

  // On-surface colors
  static const Color onPrimaryLight = Colors.white;
  static const Color onPrimaryDark = Colors.white;
  static const Color onSecondaryLight = Colors.white;
  static const Color onSecondaryDark = Colors.black;
  static const Color onErrorLight = Colors.white;
  static const Color onErrorDark = Colors.black;

  // Text colors - Light theme
  static const Color onSurfaceLight = Color(0xFF2E3338);
  static const Color onSurfaceVariantLight = Color(0xFF6D6F78);

  // Text colors - Dark theme
  static const Color onSurfaceDark = Color(0xFFDBDEE1);
  static const Color onSurfaceVariantDark = Color(0xFF949BA4);
}

/// Category colors for TODO items or tags - Discord-style
abstract class CategoryColors {
  static const Color red = Color(0xFFED4245);
  static const Color orange = Color(0xFFFAA61A);
  static const Color amber = Color(0xFFFEE75C);
  static const Color yellow = Color(0xFFFEE75C);
  static const Color lime = Color(0xFF57F287);
  static const Color green = Color(0xFF3BA55C);
  static const Color emerald = Color(0xFF1ABC9C);
  static const Color teal = Color(0xFF1ABC9C);
  static const Color cyan = Color(0xFF00AFF4);
  static const Color sky = Color(0xFF00AFF4);
  static const Color blue = Color(0xFF5865F2);
  static const Color indigo = Color(0xFF5865F2);
  static const Color violet = Color(0xFF9B59B6);
  static const Color purple = Color(0xFF9B59B6);
  static const Color fuchsia = Color(0xFFEB459E);
  static const Color pink = Color(0xFFEB459E);
  static const Color rose = Color(0xFFED4245);

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
      onSurface: AppColors.onSurfaceLight,
      onSurfaceVariant: AppColors.onSurfaceVariantLight,
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
      onSurface: AppColors.onSurfaceDark,
      onSurfaceVariant: AppColors.onSurfaceVariantDark,
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
