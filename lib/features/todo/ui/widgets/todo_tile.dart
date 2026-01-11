import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/l10n/app_localizations.dart';
import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_radius.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';
import 'package:flutter_autonomous_template/features/todo/data/models/todo.dart';

/// A tile widget displaying a single TODO item - McDonald's Style
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final categoryColor = todo.category != null
        ? CategoryColors.byIndex(todo.category!.colorIndex)
        : colorScheme.primary;

    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete?.call(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.md),
        decoration: BoxDecoration(
          color: colorScheme.error,
          borderRadius: AppRadius.card,
        ),
        child: Icon(Icons.delete_outline, color: colorScheme.onError),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: AppRadius.card,
          border: Border(
            left: BorderSide(
              color: categoryColor,
              width: 4,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: AppRadius.card,
            child: Padding(
              padding: AppSpacing.cardPadding,
              child: Row(
                children: [
                  _buildCheckbox(context, l10n),
                  const HGap.md(),
                  Expanded(child: _buildContent(context, l10n)),
                  const HGap.sm(),
                  _buildPriorityBadge(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox(BuildContext context, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: todo.isCompleted ? l10n.markIncomplete : l10n.markComplete,
      checked: todo.isCompleted,
      child: GestureDetector(
        onTap: onToggle,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: todo.isCompleted ? colorScheme.primary : Colors.transparent,
            border: Border.all(
              color: todo.isCompleted
                  ? colorScheme.primary
                  : colorScheme.outline,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: todo.isCompleted
              ? Icon(Icons.check, size: 16, color: colorScheme.onPrimary)
              : null,
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                todo.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                  color: todo.isCompleted
                      ? colorScheme.onSurfaceVariant
                      : colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
        if (todo.description.isNotEmpty) ...[
          const VGap.xs(),
          Text(
            todo.description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const VGap.xs(),
        Row(
          children: [
            if (todo.dueDate != null) ...[
              Icon(
                Icons.schedule,
                size: 14,
                color: _isDueOverdue()
                    ? colorScheme.error
                    : colorScheme.onSurfaceVariant,
              ),
              const HGap.xs(),
              Text(
                _formatDueDate(l10n),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: _isDueOverdue()
                      ? colorScheme.error
                      : colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (todo.category != null) ...[
              if (todo.dueDate != null) const HGap.md(),
              _buildCategoryChip(context),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryChip(BuildContext context) {
    final theme = Theme.of(context);
    final color = CategoryColors.byIndex(todo.category!.colorIndex);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: AppRadius.badge,
      ),
      child: Text(
        todo.category!.name,
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Determine priority based on due date proximity
    final priority = _getPriority();
    final (badgeColor, badgeText, badgeIcon) = switch (priority) {
      'high' => (colorScheme.primary, 'HIGH', Icons.priority_high),
      'medium' => (colorScheme.secondary, 'MED', Icons.remove),
      _ => (colorScheme.outline, 'LOW', Icons.arrow_downward),
    };

    if (todo.isCompleted) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: AppRadius.badge,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, size: 14, color: Colors.green),
            const HGap.xs(),
            Text(
              'DONE',
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: AppRadius.badge,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badgeIcon, size: 14, color: badgeColor),
          const HGap.xs(),
          Text(
            badgeText,
            style: theme.textTheme.labelSmall?.copyWith(
              color: badgeColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _getPriority() {
    if (todo.dueDate == null) return 'low';
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDate = DateTime(
      todo.dueDate!.year,
      todo.dueDate!.month,
      todo.dueDate!.day,
    );
    final diff = dueDate.difference(today).inDays;

    if (diff < 0 || diff == 0) return 'high'; // Overdue or today
    if (diff <= 3) return 'medium'; // Within 3 days
    return 'low';
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
