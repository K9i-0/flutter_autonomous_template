import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/components/discord/discord_components.dart';
import 'package:flutter_autonomous_template/core/l10n/app_localizations.dart';
import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_radius.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';
import 'package:flutter_autonomous_template/features/todo/data/models/todo.dart';

/// A tile widget displaying a single TODO item with Discord styling
class TodoTile extends StatelessWidget {
  const TodoTile({
    required this.todo,
    required this.onToggle,
    super.key,
    this.onTap,
    this.onDelete,
  });

  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final backgroundColor =
        isDark ? DiscordColors.surfaceDark : DiscordColors.surfaceLight;

    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete?.call(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.md),
        decoration: BoxDecoration(
          color: DiscordColors.red,
          borderRadius: AppRadius.discordCard,
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      child: Material(
        color: backgroundColor,
        borderRadius: AppRadius.discordCard,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.discordCard,
          child: Padding(
            padding: AppSpacing.cardPadding,
            child: Row(
              children: [
                DiscordCheckbox(
                  value: todo.isCompleted,
                  onChanged: (_) => onToggle(),
                  semanticLabel:
                      todo.isCompleted ? l10n.markIncomplete : l10n.markComplete,
                ),
                const HGap.md(),
                Expanded(child: _buildContent(context, l10n)),
                if (todo.category != null) ...[
                  const HGap.sm(),
                  _buildCategoryIndicator(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor =
        isDark ? DiscordColors.textPrimaryDark : DiscordColors.textPrimaryLight;
    final mutedColor =
        isDark ? DiscordColors.textMutedDark : DiscordColors.textMutedLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          todo.title,
          style: TextStyle(
            color: todo.isCompleted ? mutedColor : textColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        if (todo.description.isNotEmpty) ...[
          const VGap.xs(),
          Text(
            todo.description,
            style: TextStyle(
              color: mutedColor,
              fontSize: 14,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        if (todo.dueDate != null) ...[
          const VGap.xs(),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14,
                color: _isDueOverdue() ? DiscordColors.red : mutedColor,
              ),
              const HGap.xs(),
              Text(
                _formatDueDate(l10n),
                style: TextStyle(
                  color: _isDueOverdue() ? DiscordColors.red : mutedColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildCategoryIndicator() {
    final color = CategoryColors.byIndex(todo.category!.colorIndex);
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  bool _isDueOverdue() {
    if (todo.dueDate == null || todo.isCompleted) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDate = DateTime(
      todo.dueDate!.year,
      todo.dueDate!.month,
      todo.dueDate!.day,
    );
    return dueDate.isBefore(today);
  }

  String _formatDueDate(AppLocalizations l10n) {
    if (todo.dueDate == null) return '';
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = todo.dueDate!;
    final dateOnly = DateTime(date.year, date.month, date.day);
    final diff = dateOnly.difference(today).inDays;

    if (diff == 0) {
      return l10n.dateToday;
    } else if (diff == 1) {
      return l10n.dateTomorrow;
    } else if (diff == -1) {
      return l10n.dateYesterday;
    } else if (diff > 0 && diff < 7) {
      return l10n.dateInDays(diff);
    } else if (diff < 0 && diff > -7) {
      return l10n.dateDaysAgo(-diff);
    } else {
      return '${date.month}/${date.day}';
    }
  }
}
