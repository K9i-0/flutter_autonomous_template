import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_colors.dart';

/// Discord-style switch toggle
///
/// A switch component with Discord's visual style:
/// - Blurple accent when on
/// - Smooth transition animation
class DiscordSwitch extends StatelessWidget {
  const DiscordSwitch({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: DiscordColors.blurple,
      activeTrackColor: DiscordColors.blurple.withValues(alpha: 0.5),
      inactiveThumbColor:
          isDark ? DiscordColors.textMutedDark : DiscordColors.textMutedLight,
      inactiveTrackColor: isDark
          ? DiscordColors.surfaceHighDark
          : DiscordColors.surfaceHighLight,
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    );
  }
}

/// Discord-style switch list tile
///
/// Combines DiscordListTile styling with a switch toggle.
class DiscordSwitchListTile extends StatelessWidget {
  const DiscordSwitchListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? DiscordColors.textPrimaryDark : DiscordColors.textPrimaryLight;
    final mutedColor =
        isDark ? DiscordColors.textMutedDark : DiscordColors.textMutedLight;

    return InkWell(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        color: mutedColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            DiscordSwitch(
              value: value,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
