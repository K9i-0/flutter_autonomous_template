import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/components/discord/discord_pill_button.dart';
import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_radius.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';

/// Discord-style bottom sheet
///
/// A modal bottom sheet with optional illustration, title, description,
/// and action buttons, following Discord's design language.
class DiscordBottomSheet extends StatelessWidget {
  const DiscordBottomSheet({
    required this.title,
    super.key,
    this.description,
    this.illustration,
    this.primaryAction,
    this.secondaryAction,
    this.content,
  });

  final String title;
  final String? description;
  final Widget? illustration;
  final DiscordBottomSheetAction? primaryAction;
  final DiscordBottomSheetAction? secondaryAction;
  final Widget? content;

  /// Show the bottom sheet
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    String? description,
    Widget? illustration,
    DiscordBottomSheetAction? primaryAction,
    DiscordBottomSheetAction? secondaryAction,
    Widget? content,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      builder:
          (context) => DiscordBottomSheet(
            title: title,
            description: description,
            illustration: illustration,
            primaryAction: primaryAction,
            secondaryAction: secondaryAction,
            content: content,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? DiscordColors.backgroundDark : DiscordColors.backgroundLight;
    final textColor =
        isDark
            ? DiscordColors.textPrimaryDark
            : DiscordColors.textPrimaryLight;
    final subtitleColor =
        isDark
            ? DiscordColors.textSecondaryDark
            : DiscordColors.textSecondaryLight;

    return Container(
      margin: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.discordSheet,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle indicator
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? DiscordColors.surfaceHighDark
                          : DiscordColors.surfaceHighLight,
                  borderRadius: AppRadius.fullAll,
                ),
              ),
              const VGap.lg(),

              // Illustration
              if (illustration != null) ...[
                illustration!,
                const VGap.lg(),
              ],

              // Title
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),

              // Description
              if (description != null) ...[
                const VGap.sm(),
                Text(
                  description!,
                  style: TextStyle(color: subtitleColor, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],

              // Custom content
              if (content != null) ...[
                const VGap.lg(),
                content!,
              ],

              // Actions
              if (primaryAction != null || secondaryAction != null) ...[
                const VGap.xl(),
                if (primaryAction != null)
                  DiscordPillButton(
                    label: primaryAction!.label,
                    onPressed: () {
                      primaryAction!.onPressed?.call();
                      if (primaryAction!.dismissOnPress) {
                        Navigator.of(context).pop(true);
                      }
                    },
                    variant: DiscordButtonVariant.filled,
                    isExpanded: true,
                  ),
                if (primaryAction != null && secondaryAction != null)
                  const VGap.sm(),
                if (secondaryAction != null)
                  DiscordPillButton(
                    label: secondaryAction!.label,
                    onPressed: () {
                      secondaryAction!.onPressed?.call();
                      if (secondaryAction!.dismissOnPress) {
                        Navigator.of(context).pop(false);
                      }
                    },
                    variant: DiscordButtonVariant.gray,
                    isExpanded: true,
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Action for Discord bottom sheet
class DiscordBottomSheetAction {
  const DiscordBottomSheetAction({
    required this.label,
    this.onPressed,
    this.dismissOnPress = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool dismissOnPress;
}

/// Discord-style confirmation bottom sheet
///
/// A convenience wrapper for confirmation dialogs.
class DiscordConfirmSheet {
  /// Show a confirmation bottom sheet
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    String? description,
    Widget? illustration,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool isDestructive = false,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _DiscordConfirmSheetContent(
        title: title,
        description: description,
        illustration: illustration,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        onConfirm: onConfirm,
        onCancel: onCancel,
        isDestructive: isDestructive,
      ),
    );
  }
}

/// Internal widget for confirmation sheet content
class _DiscordConfirmSheetContent extends StatelessWidget {
  const _DiscordConfirmSheetContent({
    required this.title,
    this.description,
    this.illustration,
    required this.confirmLabel,
    required this.cancelLabel,
    this.onConfirm,
    this.onCancel,
    required this.isDestructive,
  });

  final String title;
  final String? description;
  final Widget? illustration;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? DiscordColors.backgroundDark : DiscordColors.backgroundLight;
    final textColor =
        isDark
            ? DiscordColors.textPrimaryDark
            : DiscordColors.textPrimaryLight;
    final subtitleColor =
        isDark
            ? DiscordColors.textSecondaryDark
            : DiscordColors.textSecondaryLight;

    return Container(
      margin: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.discordSheet,
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle indicator
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color:
                      isDark
                          ? DiscordColors.surfaceHighDark
                          : DiscordColors.surfaceHighLight,
                  borderRadius: AppRadius.fullAll,
                ),
              ),
              const VGap.lg(),

              // Illustration
              if (illustration != null) ...[
                illustration!,
                const VGap.lg(),
              ],

              // Title
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),

              // Description
              if (description != null) ...[
                const VGap.sm(),
                Text(
                  description!,
                  style: TextStyle(color: subtitleColor, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],

              const VGap.xl(),

              // Confirm button
              DiscordPillButton(
                label: confirmLabel,
                onPressed: () {
                  onConfirm?.call();
                  Navigator.of(context).pop(true);
                },
                variant: isDestructive
                    ? DiscordButtonVariant.destructive
                    : DiscordButtonVariant.filled,
                isExpanded: true,
              ),
              const VGap.sm(),

              // Cancel button
              DiscordPillButton(
                label: cancelLabel,
                onPressed: () {
                  onCancel?.call();
                  Navigator.of(context).pop(false);
                },
                variant: DiscordButtonVariant.gray,
                isExpanded: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
