import 'package:flutter/material.dart';

/// Application color palette - McDonald's Style
///
/// McDonald's-inspired colors for consistent theming across light and dark modes.
/// Use these colors instead of hardcoded values.
abstract class AppColors {
  // Primary colors - McDonald's Red
  static const Color primaryLight = Color(0xFFDA291C);
  static const Color primaryDark = Color(0xFFE74C3C);
  static const Color primaryContainerLight = Color(0xFFFDE8E7);
  static const Color primaryContainerDark = Color(0xFF8B1A12);

  // Secondary colors - McDonald's Yellow/Gold
  static const Color secondaryLight = Color(0xFFFFC72C);
  static const Color secondaryDark = Color(0xFFF1C40F);

  // Tertiary colors - Brown accent
  static const Color tertiaryLight = Color(0xFF8B4513);
  static const Color tertiaryDark = Color(0xFFA0522D);

  // Error colors
  static const Color errorLight = Color(0xFFDC3545);
  static const Color errorDark = Color(0xFFE74C3C);

  // Success colors
  static const Color successLight = Color(0xFF28A745);
  static const Color successDark = Color(0xFF2ECC71);

  // Warning colors - McDonald's Yellow
  static const Color warningLight = Color(0xFFFFC72C);
  static const Color warningDark = Color(0xFFF1C40F);

  // Surface colors - Light theme (McDonald's Light)
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceContainerLowestLight = Color(0xFFFFFFFF);
  static const Color surfaceContainerLowLight = Color(0xFFFCFCFC);
  static const Color surfaceContainerLight = Color(0xFFF8F8F8);
  static const Color surfaceContainerHighLight = Color(0xFFF2F2F2);
  static const Color surfaceContainerHighestLight = Color(0xFFECECEC);

  // Surface colors - Dark theme (McDonald's Dark)
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color surfaceContainerLowestDark = Color(0xFF121212);
  static const Color surfaceContainerLowDark = Color(0xFF1E1E1E);
  static const Color surfaceContainerDark = Color(0xFF2D2D2D);
  static const Color surfaceContainerHighDark = Color(0xFF383838);
  static const Color surfaceContainerHighestDark = Color(0xFF444444);

  // Outline colors
  static const Color outlineLight = Color(0xFFD0D0D0);
  static const Color outlineDark = Color(0xFF4A4A4A);
  static const Color outlineVariantLight = Color(0xFFE5E5E5);
  static const Color outlineVariantDark = Color(0xFF3A3A3A);

  // On-surface colors
  static const Color onPrimaryLight = Colors.white;
  static const Color onPrimaryDark = Colors.white;
  static const Color onSecondaryLight = Color(0xFF292929);
  static const Color onSecondaryDark = Color(0xFF292929);
  static const Color onErrorLight = Colors.white;
  static const Color onErrorDark = Colors.white;

  // Text colors - Light theme
  static const Color onSurfaceLight = Color(0xFF292929);
  static const Color onSurfaceVariantLight = Color(0xFF6B6B6B);

  // Text colors - Dark theme
  static const Color onSurfaceDark = Color(0xFFFFFFFF);
  static const Color onSurfaceVariantDark = Color(0xFFB3B3B3);
}

/// Category colors for TODO items or tags - McDonald's-style
abstract class CategoryColors {
  static const Color red = Color(0xFFDA291C);
  static const Color orange = Color(0xFFFF6B35);
  static const Color amber = Color(0xFFFFC72C);
  static const Color yellow = Color(0xFFFFD700);
  static const Color lime = Color(0xFF8BC34A);
  static const Color green = Color(0xFF28A745);
  static const Color emerald = Color(0xFF00BFA5);
  static const Color teal = Color(0xFF009688);
  static const Color cyan = Color(0xFF00BCD4);
  static const Color sky = Color(0xFF03A9F4);
  static const Color blue = Color(0xFF2196F3);
  static const Color indigo = Color(0xFF3F51B5);
  static const Color violet = Color(0xFF9C27B0);
  static const Color purple = Color(0xFF673AB7);
  static const Color fuchsia = Color(0xFFE91E63);
  static const Color pink = Color(0xFFFF4081);
  static const Color rose = Color(0xFFDA291C);

  /// Get category color by index (wraps around)
  static Color byIndex(int index) {
    const colors = [
      red,
      amber,
      green,
      blue,
      purple,
      orange,
      teal,
      indigo,
      pink,
      cyan,
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
