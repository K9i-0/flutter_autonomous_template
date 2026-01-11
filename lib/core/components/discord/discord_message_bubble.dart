import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';

/// Discord-style message bubble for displaying TODO items as chat messages
///
/// Features:
/// - Avatar on the left
/// - Username and timestamp header
/// - Message content (title + description)
/// - Optional reaction bar
/// - Tap and long-press handlers
class DiscordMessageBubble extends StatelessWidget {
  const DiscordMessageBubble({
    super.key,
    required this.title,
    this.description,
    this.timestamp,
    this.avatarText,
    this.avatarColor,
    this.isCompleted = false,
    this.reactions,
    this.onTap,
    this.onLongPress,
    this.onReactionTap,
    this.trailing,
  });

  /// Main message title
  final String title;

  /// Optional description/body text
  final String? description;

  /// Timestamp to display (e.g., "9:30 AM", "Yesterday")
  final String? timestamp;

  /// Text to show in avatar (e.g., user initials)
  final String? avatarText;

  /// Avatar background color
  final Color? avatarColor;

  /// Whether this item is completed (applies strikethrough)
  final bool isCompleted;

  /// List of reactions to display
  final List<MessageReaction>? reactions;

  /// Called when the bubble is tapped
  final VoidCallback? onTap;

  /// Called when the bubble is long-pressed
  final VoidCallback? onLongPress;

  /// Called when a reaction is tapped
  final void Function(MessageReaction)? onReactionTap;

  /// Optional trailing widget (e.g., checkbox)
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? DiscordColors.textPrimaryDark : DiscordColors.textPrimaryLight;
    final mutedColor =
        isDark ? DiscordColors.textMutedDark : DiscordColors.textMutedLight;
    final hoverColor = isDark
        ? DiscordColors.surfaceDark.withValues(alpha: 0.5)
        : DiscordColors.surfaceLight.withValues(alpha: 0.5);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        hoverColor: hoverColor,
        splashColor: hoverColor,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              _buildAvatar(isDark),
              const HGap.md(),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: username + timestamp
                    _buildHeader(textColor, mutedColor),
                    const VGap.xs(),
                    // Message content
                    _buildContent(textColor, mutedColor),
                    // Reactions
                    if (reactions != null && reactions!.isNotEmpty) ...[
                      const VGap.sm(),
                      _buildReactions(isDark),
                    ],
                  ],
                ),
              ),
              // Trailing widget
              if (trailing != null) ...[
                const HGap.sm(),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(bool isDark) {
    final bgColor = avatarColor ?? DiscordColors.blurple;
    final text = avatarText ?? '?';

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text.isNotEmpty ? text[0].toUpperCase() : '?',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(Color textColor, Color mutedColor) {
    return Row(
      children: [
        Text(
          avatarText ?? 'You',
          style: TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (timestamp != null) ...[
          const HGap.sm(),
          Text(
            timestamp!,
            style: TextStyle(
              color: mutedColor,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildContent(Color textColor, Color mutedColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Text(
          title,
          style: TextStyle(
            color: isCompleted ? mutedColor : textColor,
            fontSize: 15,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        // Description
        if (description != null && description!.isNotEmpty) ...[
          const VGap.xs(),
          Text(
            description!,
            style: TextStyle(
              color: mutedColor,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildReactions(bool isDark) {
    final bgColor =
        isDark ? DiscordColors.surfaceDark : DiscordColors.surfaceLight;

    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: reactions!.map((reaction) {
        return GestureDetector(
          onTap: () => onReactionTap?.call(reaction),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: reaction.isSelected
                  ? DiscordColors.blurple.withValues(alpha: 0.2)
                  : bgColor,
              borderRadius: BorderRadius.circular(4),
              border: reaction.isSelected
                  ? Border.all(color: DiscordColors.blurple, width: 1)
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(reaction.emoji, style: const TextStyle(fontSize: 14)),
                if (reaction.count > 0) ...[
                  const HGap.xs(),
                  Text(
                    '${reaction.count}',
                    style: TextStyle(
                      color: reaction.isSelected
                          ? DiscordColors.blurple
                          : (isDark
                              ? DiscordColors.textMutedDark
                              : DiscordColors.textMutedLight),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// Represents a reaction on a message
class MessageReaction {
  const MessageReaction({
    required this.emoji,
    this.count = 0,
    this.isSelected = false,
    this.id,
  });

  final String emoji;
  final int count;
  final bool isSelected;
  final String? id;
}
