import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';

/// Discord-style date separator for grouping messages by date
///
/// Displays a horizontal line with a date label in the center,
/// similar to Discord's message grouping.
class DiscordDateSeparator extends StatelessWidget {
  const DiscordDateSeparator({
    super.key,
    required this.label,
    this.padding,
  });

  /// The date label to display (e.g., "Today", "Yesterday", "January 15, 2025")
  final String label;

  /// Optional custom padding
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lineColor = isDark
        ? DiscordColors.textMutedDark.withValues(alpha: 0.3)
        : DiscordColors.textMutedLight.withValues(alpha: 0.3);
    final textColor =
        isDark ? DiscordColors.textMutedDark : DiscordColors.textMutedLight;

    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 1,
              color: lineColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 1,
              color: lineColor,
            ),
          ),
        ],
      ),
    );
  }
}

/// Extension to format DateTime for Discord-style date separators
extension DiscordDateFormatting on DateTime {
  /// Returns a Discord-style date label
  /// - "Today" for today
  /// - "Yesterday" for yesterday
  /// - "January 15, 2025" for other dates
  String toDiscordDateLabel() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(year, month, day);
    final diff = today.difference(dateOnly).inDays;

    if (diff == 0) {
      return 'Today';
    } else if (diff == 1) {
      return 'Yesterday';
    } else if (diff == -1) {
      return 'Tomorrow';
    } else {
      return _formatFullDate();
    }
  }

  String _formatFullDate() {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${months[month - 1]} $day, $year';
  }
}
