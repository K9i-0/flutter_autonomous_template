import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_radius.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';

/// Discord-style chip for filtering and selection
///
/// A pill-shaped chip with Discord styling:
/// - Blurple accent when selected
/// - Subtle background when not selected
class DiscordChip extends StatelessWidget {
  const DiscordChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isSelected
        ? DiscordColors.blurple
        : (isDark
            ? DiscordColors.surfaceHighDark
            : DiscordColors.surfaceHighLight);

    final textColor = isSelected
        ? Colors.white
        : (isDark
            ? DiscordColors.textPrimaryDark
            : DiscordColors.textPrimaryLight);

    return Material(
      color: backgroundColor,
      borderRadius: AppRadius.pillAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppRadius.pillAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16, color: textColor),
                const HGap.xs(),
              ],
              Text(
                label,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
