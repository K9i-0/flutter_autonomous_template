import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_radius.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';

/// Discord-style pill button variants
enum DiscordButtonVariant {
  /// Filled button with Blurple background
  filled,

  /// Outlined button with transparent background
  outlined,

  /// Gray button for secondary actions
  gray,

  /// Destructive button with red background
  destructive,
}

/// Discord-style pill button
///
/// A fully rounded button following Discord's design language.
/// Supports filled, outlined, and gray variants.
class DiscordPillButton extends StatelessWidget {
  const DiscordPillButton({
    required this.label,
    super.key,
    this.onPressed,
    this.variant = DiscordButtonVariant.filled,
    this.isLoading = false,
    this.isExpanded = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final DiscordButtonVariant variant;
  final bool isLoading;
  final bool isExpanded;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    return SizedBox(
      width: isExpanded ? double.infinity : null,
      height: 48,
      child: _buildButton(context, isEnabled),
    );
  }

  Widget _buildButton(BuildContext context, bool isEnabled) {
    switch (variant) {
      case DiscordButtonVariant.filled:
        return _buildFilledButton(context, isEnabled);
      case DiscordButtonVariant.outlined:
        return _buildOutlinedButton(context, isEnabled);
      case DiscordButtonVariant.gray:
        return _buildGrayButton(context, isEnabled);
      case DiscordButtonVariant.destructive:
        return _buildDestructiveButton(context, isEnabled);
    }
  }

  Widget _buildFilledButton(BuildContext context, bool isEnabled) {
    return FilledButton(
      onPressed: isEnabled ? onPressed : null,
      style: FilledButton.styleFrom(
        backgroundColor: DiscordColors.blurple,
        foregroundColor: Colors.white,
        disabledBackgroundColor: DiscordColors.blurple.withValues(alpha: 0.5),
        disabledForegroundColor: Colors.white.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.pillAll),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      ),
      child: _buildContent(Colors.white),
    );
  }

  Widget _buildOutlinedButton(BuildContext context, bool isEnabled) {
    final colorScheme = Theme.of(context).colorScheme;

    return OutlinedButton(
      onPressed: isEnabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.onSurface,
        side: BorderSide(
          color:
              isEnabled
                  ? colorScheme.outline
                  : colorScheme.outline.withValues(alpha: 0.5),
        ),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.pillAll),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      ),
      child: _buildContent(colorScheme.onSurface),
    );
  }

  Widget _buildGrayButton(BuildContext context, bool isEnabled) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FilledButton(
      onPressed: isEnabled ? onPressed : null,
      style: FilledButton.styleFrom(
        backgroundColor:
            isDark ? DiscordColors.surfaceDark : DiscordColors.surfaceLight,
        foregroundColor: colorScheme.onSurface,
        disabledBackgroundColor:
            isDark
                ? DiscordColors.surfaceDark.withValues(alpha: 0.5)
                : DiscordColors.surfaceLight.withValues(alpha: 0.5),
        disabledForegroundColor: colorScheme.onSurface.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.pillAll),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      ),
      child: _buildContent(colorScheme.onSurface),
    );
  }

  Widget _buildDestructiveButton(BuildContext context, bool isEnabled) {
    return FilledButton(
      onPressed: isEnabled ? onPressed : null,
      style: FilledButton.styleFrom(
        backgroundColor: DiscordColors.red,
        foregroundColor: Colors.white,
        disabledBackgroundColor: DiscordColors.red.withValues(alpha: 0.5),
        disabledForegroundColor: Colors.white.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(borderRadius: AppRadius.pillAll),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      ),
      child: _buildContent(Colors.white),
    );
  }

  Widget _buildContent(Color color) {
    if (isLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const HGap.sm(),
          Text(label),
        ],
      );
    }

    return Text(label);
  }
}
