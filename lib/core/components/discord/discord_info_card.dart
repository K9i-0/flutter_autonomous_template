import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_radius.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';

/// Discord-style info card
///
/// A card component for displaying informational content with:
/// - Icon and title header
/// - Description text
/// - Optional child widget
class DiscordInfoCard extends StatelessWidget {
  const DiscordInfoCard({
    super.key,
    required this.title,
    this.icon,
    this.description,
    this.child,
  });

  final String title;
  final IconData? icon;
  final String? description;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? DiscordColors.surfaceDark : DiscordColors.surfaceLight;
    final textColor =
        isDark ? DiscordColors.textPrimaryDark : DiscordColors.textPrimaryLight;
    final mutedColor =
        isDark ? DiscordColors.textMutedDark : DiscordColors.textMutedLight;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.discordCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 20,
                  color: DiscordColors.blurple,
                ),
                const HGap.sm(),
              ],
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (description != null) ...[
            const VGap.sm(),
            Text(
              description!,
              style: TextStyle(
                color: mutedColor,
                fontSize: 13,
              ),
            ),
          ],
          if (child != null) ...[
            const VGap.md(),
            child!,
          ],
        ],
      ),
    );
  }
}
