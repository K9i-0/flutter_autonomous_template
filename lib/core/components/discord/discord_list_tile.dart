import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_radius.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';

/// Discord-style list tile
///
/// A list item with avatar, title, subtitle, and trailing widget,
/// following Discord's design language.
class DiscordListTile extends StatelessWidget {
  const DiscordListTile({
    required this.title,
    super.key,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.showDivider = false,
    this.dense = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool showDivider;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark
            ? DiscordColors.textPrimaryDark
            : DiscordColors.textPrimaryLight;
    final subtitleColor =
        isDark
            ? DiscordColors.textSecondaryDark
            : DiscordColors.textSecondaryLight;

    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            onLongPress: onLongPress,
            borderRadius: AppRadius.discordInput,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: dense ? AppSpacing.sm : AppSpacing.md,
              ),
              child: Row(
                children: [
                  if (leading != null) ...[
                    leading!,
                    const HGap.md(),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            color: textColor,
                            fontSize: dense ? 14 : 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const VGap.xxs(),
                          Text(
                            subtitle!,
                            style: TextStyle(
                              color: subtitleColor,
                              fontSize: dense ? 12 : 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (trailing != null) ...[
                    const HGap.sm(),
                    trailing!,
                  ],
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            indent: leading != null ? 56 : 16,
            endIndent: 16,
            color:
                isDark
                    ? DiscordColors.surfaceHighDark
                    : DiscordColors.surfaceHighLight,
          ),
      ],
    );
  }
}

/// Discord-style avatar
///
/// A circular avatar with optional status indicator.
class DiscordAvatar extends StatelessWidget {
  const DiscordAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.backgroundColor,
    this.size = 40,
    this.status,
  });

  final String? imageUrl;
  final String? initials;
  final Color? backgroundColor;
  final double size;
  final DiscordStatus? status;

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? DiscordColors.blurple;

    return Stack(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            image:
                imageUrl != null
                    ? DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    )
                    : null,
          ),
          child:
              imageUrl == null && initials != null
                  ? Center(
                    child: Text(
                      initials!.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size * 0.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                  : null,
        ),
        if (status != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size * 0.3,
              height: size * 0.3,
              decoration: BoxDecoration(
                color: _getStatusColor(status!),
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? DiscordColors.backgroundDark
                          : DiscordColors.backgroundLight,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Color _getStatusColor(DiscordStatus status) {
    switch (status) {
      case DiscordStatus.online:
        return DiscordColors.online;
      case DiscordStatus.idle:
        return DiscordColors.idle;
      case DiscordStatus.dnd:
        return DiscordColors.dnd;
      case DiscordStatus.offline:
        return DiscordColors.offline;
    }
  }
}

/// Discord status types
enum DiscordStatus { online, idle, dnd, offline }
