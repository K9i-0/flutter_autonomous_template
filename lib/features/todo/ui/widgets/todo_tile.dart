import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/core/theme/app_radius.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';
import 'package:flutter_autonomous_template/features/todo/data/models/todo.dart';

/// A tile widget displaying a single TODO item
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
        child: Icon(
          Icons.delete_outline,
          color: colorScheme.onError,
        ),
      ),
      child: Material(
        color: colorScheme.surfaceContainerHigh,
        borderRadius: AppRadius.card,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.card,
          child: Padding(
            padding: AppSpacing.cardPadding,
            child: Row(
              children: [
                _buildCheckbox(context),
                const HGap.md(),
                Expanded(child: _buildContent(context)),
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

  Widget _buildCheckbox(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: todo.isCompleted ? colorScheme.primary : Colors.transparent,
          border: Border.all(
            color: todo.isCompleted ? colorScheme.primary : colorScheme.outline,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: todo.isCompleted
            ? Icon(
                Icons.check,
                size: 16,
                color: colorScheme.onPrimary,
              )
            : null,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          todo.title,
          style: theme.textTheme.titleMedium?.copyWith(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: todo.isCompleted
                ? colorScheme.onSurfaceVariant
                : colorScheme.onSurface,
          ),
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
        if (todo.dueDate != null) ...[
          const VGap.xs(),
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14,
                color: _isDueOverdue()
                    ? colorScheme.error
                    : colorScheme.onSurfaceVariant,
              ),
              const HGap.xs(),
              Text(
                _formatDueDate(),
                style: theme.textTheme.labelSmall?.copyWith(
                  color: _isDueOverdue()
                      ? colorScheme.error
                      : colorScheme.onSurfaceVariant,
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
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }

  bool _isDueOverdue() {
    if (todo.dueDate == null || todo.isCompleted) return false;
    return todo.dueDate!.isBefore(DateTime.now());
  }

  String _formatDueDate() {
    if (todo.dueDate == null) return '';
    final now = DateTime.now();
    final date = todo.dueDate!;
    final diff = date.difference(now);

    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Tomorrow';
    } else if (diff.inDays == -1) {
      return 'Yesterday';
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      return 'In ${diff.inDays} days';
    } else if (diff.inDays < 0 && diff.inDays > -7) {
      return '${-diff.inDays} days ago';
    } else {
      return '${date.month}/${date.day}';
    }
  }
}
