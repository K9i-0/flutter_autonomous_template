import 'package:flutter/material.dart';

/// Application color palette
///
/// Semantic colors for consistent theming across light and dark modes.
/// Use these colors instead of hardcoded values.
abstract class AppColors {
  // Primary colors - Brand identity
  static const Color primaryLight = Color(0xFF4F46E5);
  static const Color primaryDark = Color(0xFF818CF8);
  static const Color primaryContainerLight = Color(0xFFE0E7FF);
  static const Color primaryContainerDark = Color(0xFF4F46E5);

  // Secondary colors - Accents
  static const Color secondaryLight = Color(0xFF0891B2);
  static const Color secondaryDark = Color(0xFF22D3EE);

  // Tertiary colors - Highlights
  static const Color tertiaryLight = Color(0xFFDB2777);
  static const Color tertiaryDark = Color(0xFFF472B6);

  // Error colors
  static const Color errorLight = Color(0xFFDC2626);
  static const Color errorDark = Color(0xFFF87171);

  // Success colors
  static const Color successLight = Color(0xFF16A34A);
  static const Color successDark = Color(0xFF4ADE80);

  // Warning colors
  static const Color warningLight = Color(0xFFD97706);
  static const Color warningDark = Color(0xFFFBBF24);

  // Surface colors - Light theme
  static const Color surfaceLight = Color(0xFFFAFAFC);
  static const Color surfaceContainerLowestLight = Colors.white;
  static const Color surfaceContainerLowLight = Color(0xFFF8F9FB);
  static const Color surfaceContainerLight = Color(0xFFF1F5F9);
  static const Color surfaceContainerHighLight = Color(0xFFE2E8F0);
  static const Color surfaceContainerHighestLight = Color(0xFFCBD5E1);

  // Surface colors - Dark theme
  static const Color surfaceDark = Color(0xFF0D0D12);
  static const Color surfaceContainerLowestDark = Color(0xFF0D0D12);
  static const Color surfaceContainerLowDark = Color(0xFF141419);
  static const Color surfaceContainerDark = Color(0xFF1A1A21);
  static const Color surfaceContainerHighDark = Color(0xFF22222B);
  static const Color surfaceContainerHighestDark = Color(0xFF2A2A35);

  // Outline colors
  static const Color outlineLight = Color(0xFF94A3B8);
  static const Color outlineDark = Color(0xFF4A4A5A);
  static const Color outlineVariantLight = Color(0xFFE2E8F0);
  static const Color outlineVariantDark = Color(0xFF2A2A35);

  // On-surface colors
  static const Color onPrimaryLight = Colors.white;
  static const Color onPrimaryDark = Colors.white;
  static const Color onSecondaryLight = Colors.white;
  static const Color onSecondaryDark = Colors.black;
  static const Color onErrorLight = Colors.white;
  static const Color onErrorDark = Colors.black;
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

/// Discord brand colors
///
/// Official Discord color palette for theming.
abstract class DiscordColors {
  // Brand colors
  static const Color blurple = Color(0xFF5865F2);
  static const Color green = Color(0xFF3BA55C);
  static const Color yellow = Color(0xFFFEE75C);
  static const Color fuchsia = Color(0xFFEB459E);
  static const Color red = Color(0xFFED4245);

  // Light mode colors
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF2F3F5);
  static const Color surfaceHighLight = Color(0xFFE3E5E8);
  static const Color textPrimaryLight = Color(0xFF060607);
  static const Color textSecondaryLight = Color(0xFF4E5058);
  static const Color textMutedLight = Color(0xFF80848E);

  // Dark mode colors
  static const Color backgroundDark = Color(0xFF313338);
  static const Color surfaceDark = Color(0xFF2B2D31);
  static const Color surfaceHighDark = Color(0xFF1E1F22);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB5BAC1);
  static const Color textMutedDark = Color(0xFF949BA4);

  // Status colors
  static const Color online = Color(0xFF23A55A);
  static const Color idle = Color(0xFFF0B232);
  static const Color dnd = Color(0xFFF23F43);
  static const Color offline = Color(0xFF80848E);
}

/// Discord ColorScheme builders
extension DiscordColorScheme on DiscordColors {
  static ColorScheme lightScheme() {
    return ColorScheme.light(
      primary: DiscordColors.blurple,
      onPrimary: Colors.white,
      primaryContainer: DiscordColors.blurple.withValues(alpha: 0.1),
      secondary: DiscordColors.green,
      onSecondary: Colors.white,
      tertiary: DiscordColors.fuchsia,
      error: DiscordColors.red,
      onError: Colors.white,
      surface: DiscordColors.backgroundLight,
      onSurface: DiscordColors.textPrimaryLight,
      onSurfaceVariant: DiscordColors.textSecondaryLight,
      surfaceContainerLowest: DiscordColors.backgroundLight,
      surfaceContainerLow: DiscordColors.surfaceLight,
      surfaceContainer: DiscordColors.surfaceLight,
      surfaceContainerHigh: DiscordColors.surfaceHighLight,
      surfaceContainerHighest: DiscordColors.surfaceHighLight,
      outline: DiscordColors.textMutedLight,
      outlineVariant: DiscordColors.surfaceHighLight,
    );
  }

  static ColorScheme darkScheme() {
    return ColorScheme.dark(
      primary: DiscordColors.blurple,
      onPrimary: Colors.white,
      primaryContainer: DiscordColors.blurple.withValues(alpha: 0.2),
      secondary: DiscordColors.green,
      onSecondary: Colors.white,
      tertiary: DiscordColors.fuchsia,
      error: DiscordColors.red,
      onError: Colors.white,
      surface: DiscordColors.backgroundDark,
      onSurface: DiscordColors.textPrimaryDark,
      onSurfaceVariant: DiscordColors.textSecondaryDark,
      surfaceContainerLowest: DiscordColors.surfaceHighDark,
      surfaceContainerLow: DiscordColors.surfaceDark,
      surfaceContainer: DiscordColors.surfaceDark,
      surfaceContainerHigh: DiscordColors.backgroundDark,
      surfaceContainerHighest: DiscordColors.backgroundDark,
      outline: DiscordColors.textMutedDark,
      outlineVariant: DiscordColors.surfaceHighDark,
    );
  }
}
