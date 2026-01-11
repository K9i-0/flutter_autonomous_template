import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_radius.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';

/// Discord-style card container
///
/// A card with Discord's surface styling:
/// - Rounded corners
/// - Subtle background
/// - Optional tap handling
class DiscordCard extends StatelessWidget {
  const DiscordCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.margin,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? DiscordColors.surfaceDark : DiscordColors.surfaceLight;

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        color: backgroundColor,
        borderRadius: AppRadius.discordCard,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: AppRadius.discordCard,
          child: Padding(
            padding: padding ?? AppSpacing.cardPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Discord-style checkbox
///
/// A circular checkbox with Discord styling:
/// - Blurple when checked
/// - Subtle border when unchecked
class DiscordCheckbox extends StatelessWidget {
  const DiscordCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.size = 24,
    this.semanticLabel,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final double size;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor =
        isDark ? DiscordColors.textMutedDark : DiscordColors.textMutedLight;

    return Semantics(
      label: semanticLabel,
      checked: value,
      child: GestureDetector(
        onTap: onChanged != null ? () => onChanged!(!value) : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: value ? DiscordColors.blurple : Colors.transparent,
            border: Border.all(
              color: value ? DiscordColors.blurple : borderColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(size / 4),
          ),
          child: value
              ? Icon(Icons.check, size: size * 0.65, color: Colors.white)
              : null,
        ),
      ),
    );
  }
}
