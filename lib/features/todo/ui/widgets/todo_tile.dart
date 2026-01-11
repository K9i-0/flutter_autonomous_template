import 'package:flutter/material.dart';

import 'package:flutter_autonomous_template/core/l10n/app_localizations.dart';
import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
import 'package:flutter_autonomous_template/features/todo/data/models/todo.dart';

/// A tile widget displaying a single TODO item - Timee style
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
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: colorScheme.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_outline, color: colorScheme.onError, size: 28),
            const SizedBox(height: 4),
            Text(
              'Delete',
              style: theme.textTheme.labelSmall?.copyWith(
                color: colorScheme.onError,
              ),
            ),
          ],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Row(
            children: [
              // Left color indicator
              Container(
                width: 4,
                height: 100,
                color: categoryColor,
              ),
              // Main content
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTap,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category icon
                          _buildCategoryIcon(context, categoryColor),
                          const SizedBox(width: 12),
                          // Content
                          Expanded(
                            child: _buildContent(context, l10n, categoryColor),
                          ),
                          // Checkbox
                          _buildCheckbox(context, l10n),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryIcon(BuildContext context, Color categoryColor) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: categoryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        _getCategoryIcon(),
        color: categoryColor,
        size: 24,
      ),
    );
  }

  IconData _getCategoryIcon() {
    if (todo.category == null) return Icons.task_alt;
    // Map category to icons based on name or index
    final icons = [
      Icons.work_outline,
      Icons.person_outline,
      Icons.school_outlined,
      Icons.shopping_cart_outlined,
      Icons.favorite_outline,
      Icons.fitness_center_outlined,
      Icons.local_cafe_outlined,
      Icons.flight_outlined,
    ];
    return icons[todo.category!.colorIndex % icons.length];
  }

  Widget _buildContent(
    BuildContext context,
    AppLocalizations l10n,
    Color categoryColor,
  ) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title row with badge
        Row(
          children: [
            Expanded(
              child: Text(
                todo.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  decoration:
                      todo.isCompleted ? TextDecoration.lineThrough : null,
                  color: todo.isCompleted
                      ? colorScheme.onSurfaceVariant
                      : colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (todo.category != null) ...[
              const SizedBox(width: 8),
              _buildCategoryBadge(context, categoryColor),
            ],
          ],
        ),
        // Description
        if (todo.description.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            todo.description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const SizedBox(height: 8),
        // Bottom row with date and status
        Row(
          children: [
            if (todo.dueDate != null) ...[
              _buildDueDateChip(context, l10n),
              const SizedBox(width: 8),
            ],
            if (todo.isCompleted)
              _buildStatusChip(
                context,
                label: 'Completed',
                color: AppColors.accentGreen,
                icon: Icons.check_circle_outline,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryBadge(BuildContext context, Color categoryColor) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: categoryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        todo.category?.name ?? '',
        style: theme.textTheme.labelSmall?.copyWith(
          color: categoryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDueDateChip(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final isOverdue = _isDueOverdue();
    final color = isOverdue ? AppColors.accentPink : AppColors.accentPurple;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.schedule,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            _formatDueDate(l10n),
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(
    BuildContext context, {
    required String label,
    required Color color,
    required IconData icon,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
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
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: todo.isCompleted ? colorScheme.primary : Colors.transparent,
            border: Border.all(
              color: todo.isCompleted
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: todo.isCompleted
              ? Icon(Icons.check, size: 18, color: colorScheme.onPrimary)
              : null,
        ),
      ),
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
