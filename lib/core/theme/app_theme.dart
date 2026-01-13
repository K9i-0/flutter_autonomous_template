import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_radius.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';
import 'package:flutter_autonomous_template/core/theme/app_typography.dart';

/// Application theme configuration - Antique Theme
///
/// Uses Material 3 design system with warm parchment colors,
/// serif typography, and classic styling.
class AppTheme {
  /// Dark theme
  static ThemeData get darkTheme {
    final colorScheme = AppColorScheme.darkScheme();
    return _buildTheme(colorScheme, Brightness.dark);
  }

  /// Light theme
  static ThemeData get lightTheme {
    final colorScheme = AppColorScheme.lightScheme();
    return _buildTheme(colorScheme, Brightness.light);
  }

  static ThemeData _buildTheme(ColorScheme colorScheme, Brightness brightness) {
    final textTheme = AppTypography.buildTextTheme(colorScheme);

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      brightness: brightness,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.card,
          side: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
        color: colorScheme.surfaceContainerLow,
        clipBehavior: Clip.antiAlias,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 2,
        highlightElevation: 4,
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        shape: AppShapeBorder.fab,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: AppSpacing.buttonPadding,
          shape: AppShapeBorder.button,
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: AppSpacing.buttonPadding,
          side: BorderSide(color: colorScheme.secondary, width: 1.5),
          shape: AppShapeBorder.button,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: AppSpacing.buttonPaddingSmall,
          shape: AppShapeBorder.buttonSmall,
          foregroundColor: colorScheme.secondary,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(colorScheme.onPrimary),
        side: BorderSide(color: colorScheme.primary, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.checkbox),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        contentPadding: AppSpacing.inputPadding,
        border: OutlineInputBorder(
          borderRadius: AppRadius.input,
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppRadius.input,
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.input,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.input,
          borderSide: BorderSide(color: colorScheme.error, width: 1.5),
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(
          color: colorScheme.outline,
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
        floatingLabelStyle: textTheme.bodySmall?.copyWith(
          color: colorScheme.primary,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainer,
        selectedColor: colorScheme.secondary.withOpacity(0.2),
        labelStyle: textTheme.labelMedium,
        side: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.chip),
        padding: EdgeInsets.symmetric(
          horizontal: AppSpacing.sm + AppSpacing.xs,
          vertical: AppSpacing.sm,
        ),
        showCheckmark: true,
        checkmarkColor: colorScheme.primary,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: colorScheme.surfaceContainer,
          border: OutlineInputBorder(
            borderRadius: AppRadius.input,
            borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surfaceContainerLowest,
        elevation: 8,
        shape: AppShapeBorder.dialog,
        titleTextStyle: textTheme.headlineSmall?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outline.withOpacity(0.3),
        thickness: 1,
      ),
      iconTheme: IconThemeData(color: colorScheme.onSurface, size: 24),
      listTileTheme: ListTileThemeData(
        iconColor: colorScheme.primary,
        textColor: colorScheme.onSurface,
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        backgroundColor: colorScheme.surfaceContainer,
        indicatorColor: colorScheme.secondary.withOpacity(0.2),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return textTheme.labelMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w700,
            );
          }
          return textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(color: colorScheme.primary);
          }
          return IconThemeData(color: colorScheme.onSurfaceVariant);
        }),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.bottomSheet),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: colorScheme.surfaceContainerLowest,
        headerBackgroundColor: colorScheme.primary,
        headerForegroundColor: colorScheme.onPrimary,
        dayStyle: textTheme.bodyMedium,
        todayBorder: BorderSide(color: colorScheme.primary),
      ),
    );
  }
}
