import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_radius.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';

/// Discord-style snackbar variants
enum DiscordSnackbarVariant {
  /// Default info style
  info,

  /// Success message (green)
  success,

  /// Warning message (yellow)
  warning,

  /// Error message (red)
  error,
}

/// Discord-style snackbar helper
///
/// Provides static methods to show Discord-styled snackbars.
class DiscordSnackbar {
  DiscordSnackbar._();

  /// Show a Discord-styled snackbar
  static void show(
    BuildContext context, {
    required String message,
    DiscordSnackbarVariant variant = DiscordSnackbarVariant.info,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = _getColors(variant, isDark);

    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              _getIcon(variant),
              color: colors.iconColor,
              size: 20,
            ),
            const HGap.sm(),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: colors.textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: colors.backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.discordCard,
        ),
        margin: const EdgeInsets.all(AppSpacing.md),
        duration: duration,
        action: action,
      ),
    );
  }

  /// Show an error snackbar
  static void showError(BuildContext context, String message) {
    show(context, message: message, variant: DiscordSnackbarVariant.error);
  }

  /// Show a success snackbar
  static void showSuccess(BuildContext context, String message) {
    show(context, message: message, variant: DiscordSnackbarVariant.success);
  }

  static IconData _getIcon(DiscordSnackbarVariant variant) {
    switch (variant) {
      case DiscordSnackbarVariant.info:
        return Icons.info_outline;
      case DiscordSnackbarVariant.success:
        return Icons.check_circle_outline;
      case DiscordSnackbarVariant.warning:
        return Icons.warning_amber_outlined;
      case DiscordSnackbarVariant.error:
        return Icons.error_outline;
    }
  }

  static _SnackbarColors _getColors(DiscordSnackbarVariant variant, bool isDark) {
    switch (variant) {
      case DiscordSnackbarVariant.info:
        return _SnackbarColors(
          backgroundColor:
              isDark ? DiscordColors.surfaceDark : DiscordColors.surfaceLight,
          textColor: isDark
              ? DiscordColors.textPrimaryDark
              : DiscordColors.textPrimaryLight,
          iconColor: DiscordColors.blurple,
        );
      case DiscordSnackbarVariant.success:
        return _SnackbarColors(
          backgroundColor: DiscordColors.green.withValues(alpha: 0.15),
          textColor: isDark
              ? DiscordColors.textPrimaryDark
              : DiscordColors.textPrimaryLight,
          iconColor: DiscordColors.green,
        );
      case DiscordSnackbarVariant.warning:
        return _SnackbarColors(
          backgroundColor: DiscordColors.yellow.withValues(alpha: 0.15),
          textColor: isDark
              ? DiscordColors.textPrimaryDark
              : DiscordColors.textPrimaryLight,
          iconColor: DiscordColors.yellow,
        );
      case DiscordSnackbarVariant.error:
        return _SnackbarColors(
          backgroundColor: DiscordColors.red.withValues(alpha: 0.15),
          textColor: isDark
              ? DiscordColors.textPrimaryDark
              : DiscordColors.textPrimaryLight,
          iconColor: DiscordColors.red,
        );
    }
  }
}

class _SnackbarColors {
  const _SnackbarColors({
    required this.backgroundColor,
    required this.textColor,
    required this.iconColor,
  });

  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
}
