import 'package:flutter/material.dart';

/// Application color palette - Antique Theme
///
/// Warm parchment tones with dark wood and brass accents.
/// Inspired by old manuscripts and classic libraries.
abstract class AppColors {
  // Primary colors - Dark wood/sepia
  static const Color primaryLight = Color(0xFF5D4037);
  static const Color primaryDark = Color(0xFF8D6E63);
  static const Color primaryContainerLight = Color(0xFF8D6E63);
  static const Color primaryContainerDark = Color(0xFF5D4037);

  // Secondary colors - Brass/gold accents
  static const Color secondaryLight = Color(0xFFB8860B);
  static const Color secondaryDark = Color(0xFFD4AF37);

  // Tertiary colors - Deep burgundy
  static const Color tertiaryLight = Color(0xFF6D1E1E);
  static const Color tertiaryDark = Color(0xFF8B3A3A);

  // Error colors
  static const Color errorLight = Color(0xFFA63D40);
  static const Color errorDark = Color(0xFFCF6679);

  // Success colors
  static const Color successLight = Color(0xFF4A7C59);
  static const Color successDark = Color(0xFF6B9F7E);

  // Warning colors
  static const Color warningLight = Color(0xFFBF8B2E);
  static const Color warningDark = Color(0xFFD4A84B);

  // Surface colors - Light theme (Parchment)
  static const Color surfaceLight = Color(0xFFF5E6C8);
  static const Color surfaceContainerLowestLight = Color(0xFFFAF3E0);
  static const Color surfaceContainerLowLight = Color(0xFFF5E6C8);
  static const Color surfaceContainerLight = Color(0xFFEDE0C8);
  static const Color surfaceContainerHighLight = Color(0xFFE5D4B5);
  static const Color surfaceContainerHighestLight = Color(0xFFD4C4A0);

  // Surface colors - Dark theme (Aged parchment)
  static const Color surfaceDark = Color(0xFF2A231C);
  static const Color surfaceContainerLowestDark = Color(0xFF1E1815);
  static const Color surfaceContainerLowDark = Color(0xFF2A231C);
  static const Color surfaceContainerDark = Color(0xFF362E25);
  static const Color surfaceContainerHighDark = Color(0xFF44392E);
  static const Color surfaceContainerHighestDark = Color(0xFF524538);

  // Outline colors
  static const Color outlineLight = Color(0xFF8D7355);
  static const Color outlineDark = Color(0xFF6D5840);
  static const Color outlineVariantLight = Color(0xFFB8A080);
  static const Color outlineVariantDark = Color(0xFF4A3D30);

  // On-surface colors
  static const Color onPrimaryLight = Color(0xFFFAF3E0);
  static const Color onPrimaryDark = Color(0xFFFAF3E0);
  static const Color onSecondaryLight = Color(0xFFFAF3E0);
  static const Color onSecondaryDark = Color(0xFF3E2723);
  static const Color onErrorLight = Color(0xFFFAF3E0);
  static const Color onErrorDark = Color(0xFF1E1815);

  // Text colors
  static const Color onSurfaceLight = Color(0xFF3E2723);
  static const Color onSurfaceDark = Color(0xFFE5D4B5);
  static const Color onSurfaceVariantLight = Color(0xFF5D4037);
  static const Color onSurfaceVariantDark = Color(0xFFB8A080);
}

/// Category colors for TODO items or tags - Antique palette
abstract class CategoryColors {
  static const Color burgundy = Color(0xFF6D1E1E);
  static const Color rust = Color(0xFF8B4513);
  static const Color copper = Color(0xFFB87333);
  static const Color brass = Color(0xFFB8860B);
  static const Color gold = Color(0xFFD4AF37);
  static const Color olive = Color(0xFF556B2F);
  static const Color sage = Color(0xFF6B8E63);
  static const Color teal = Color(0xFF2F6B6B);
  static const Color slate = Color(0xFF4A5568);
  static const Color navy = Color(0xFF2C3E50);
  static const Color plum = Color(0xFF5D3A5D);
  static const Color mahogany = Color(0xFF4E2728);
  static const Color espresso = Color(0xFF3C2415);
  static const Color walnut = Color(0xFF5D4037);
  static const Color bronze = Color(0xFF8D6E63);
  static const Color sepia = Color(0xFF704214);

  /// Get category color by index (wraps around)
  static Color byIndex(int index) {
    const colors = [
      burgundy,
      brass,
      sage,
      navy,
      copper,
      plum,
      olive,
      teal,
      rust,
      bronze,
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
      onSurface: AppColors.onSurfaceLight,
      onSurfaceVariant: AppColors.onSurfaceVariantLight,
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
      onSurface: AppColors.onSurfaceDark,
      onSurfaceVariant: AppColors.onSurfaceVariantDark,
    );
  }
}
