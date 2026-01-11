import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_autonomous_template/core/components/app_empty_state.dart';
import 'package:flutter_autonomous_template/core/components/app_loading.dart';
import 'package:flutter_autonomous_template/core/l10n/app_localizations.dart';
import 'package:flutter_autonomous_template/core/router/app_router.gr.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';
import 'package:flutter_autonomous_template/features/todo/data/models/todo.dart';
import 'package:flutter_autonomous_template/features/todo/providers/filter_provider.dart';
import 'package:flutter_autonomous_template/features/todo/providers/todo_provider.dart';
import 'package:flutter_autonomous_template/features/todo/ui/widgets/todo_tile.dart';

@RoutePage()
class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredTodos = ref.watch(filteredTodosProvider);
    final currentFilter = ref.watch(filterProvider);
    final stats = ref.watch(todoStatsProvider);
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLow,
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            _buildHeader(context, ref, stats, l10n),
            // Date navigation (Timee-style)
            _buildDateNavigation(context),
            // Filter chips
            _buildFilterChips(context, ref, currentFilter, stats, l10n),
            // Promotional banner
            _buildPromoBanner(context),
            // Todo list
            Expanded(
              child: filteredTodos.when(
                data: (todos) => _buildTodoList(context, ref, todos, l10n),
                loading: () => const AppLoadingOverlay(),
                error: (error, stack) => AppErrorState(
                  error: error,
                  onRetry: () => ref.invalidate(todoListProvider),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.router.push(TodoEditRoute());
        },
        backgroundColor: theme.colorScheme.secondary,
        foregroundColor: theme.colorScheme.onSecondary,
        icon: const Icon(Icons.add),
        label: const Text('New Task'),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    WidgetRef ref,
    ({int total, int completed, int active}) stats,
    AppLocalizations l10n,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.todos,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${stats.active} tasks remaining',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
          if (stats.completed > 0)
            TextButton.icon(
              onPressed: () {
                ref.read(todoListProvider.notifier).clearCompleted();
              },
              icon: const Icon(Icons.cleaning_services_outlined, size: 18),
              label: Text(l10n.clearCompleted),
              style: TextButton.styleFrom(
                foregroundColor: theme.colorScheme.error,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDateNavigation(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final days = List.generate(7, (i) => now.add(Duration(days: i)));
    final weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: days.length,
        itemBuilder: (context, index) {
          final day = days[index];
          final isToday = index == 0;
          final weekday = weekdays[day.weekday % 7];

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Container(
              width: 56,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isToday
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: isToday
                    ? null
                    : Border.all(color: theme.colorScheme.outlineVariant),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isToday ? 'Today' : weekday,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isToday
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.outline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${day.day}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: isToday
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterChips(
    BuildContext context,
    WidgetRef ref,
    TodoFilter currentFilter,
    ({int total, int completed, int active}) stats,
    AppLocalizations l10n,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _buildFilterChip(
            context,
            label: l10n.filterAllCount(stats.total),
            isSelected: currentFilter == TodoFilter.all,
            onTap: () =>
                ref.read(filterProvider.notifier).setFilter(TodoFilter.all),
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            context,
            label: l10n.filterActiveCount(stats.active),
            isSelected: currentFilter == TodoFilter.active,
            onTap: () =>
                ref.read(filterProvider.notifier).setFilter(TodoFilter.active),
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            context,
            label: l10n.filterDoneCount(stats.completed),
            isSelected: currentFilter == TodoFilter.completed,
            onTap: () => ref
                .read(filterProvider.notifier)
                .setFilter(TodoFilter.completed),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected) ...[
              Icon(
                Icons.check,
                size: 16,
                color: theme.colorScheme.onPrimary,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanner(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.tips_and_updates,
              color: theme.colorScheme.onPrimary,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Stay Productive!',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Complete your tasks and earn rewards',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList(
    BuildContext context,
    WidgetRef ref,
    List<Todo> todos,
    AppLocalizations l10n,
  ) {
    if (todos.isEmpty) {
      return AppEmptyState(
        icon: Icons.check_circle_outline,
        title: l10n.todoEmptyTitle,
        description: l10n.todoEmptyDescription,
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
      itemCount: todos.length,
      separatorBuilder: (context, index) => const VGap.sm(),
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoTile(
          todo: todo,
          onToggle: () {
            ref.read(todoListProvider.notifier).toggleCompletion(todo.id);
          },
          onTap: () {
            context.router.push(TodoEditRoute(todo: todo));
          },
          onDelete: () {
            ref.read(todoListProvider.notifier).deleteTodo(todo.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.todoDeleted(todo.title)),
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
