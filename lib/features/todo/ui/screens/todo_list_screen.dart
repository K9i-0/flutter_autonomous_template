import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_autonomous_template/core/components/app_empty_state.dart';
import 'package:flutter_autonomous_template/core/components/app_loading.dart';
import 'package:flutter_autonomous_template/core/components/discord/discord_components.dart';
import 'package:flutter_autonomous_template/core/l10n/app_localizations.dart';
import 'package:flutter_autonomous_template/core/router/app_router.gr.dart';
import 'package:flutter_autonomous_template/core/theme/app_colors.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? DiscordColors.backgroundDark : DiscordColors.backgroundLight;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(l10n.todos),
        backgroundColor: backgroundColor,
        actions: [
          if (stats.completed > 0)
            TextButton(
              onPressed: () {
                ref.read(todoListProvider.notifier).clearCompleted();
              },
              child: Text(
                l10n.clearCompleted,
                style: const TextStyle(color: DiscordColors.blurple),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterChips(context, ref, currentFilter, stats, l10n),
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
      floatingActionButton: DiscordFAB(
        onPressed: () {
          context.router.push(TodoEditRoute());
        },
        tooltip: l10n.todoAdd,
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
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          DiscordChip(
            label: l10n.filterAllCount(stats.total),
            isSelected: currentFilter == TodoFilter.all,
            onTap: () =>
                ref.read(filterProvider.notifier).setFilter(TodoFilter.all),
          ),
          const HGap.sm(),
          DiscordChip(
            label: l10n.filterActiveCount(stats.active),
            isSelected: currentFilter == TodoFilter.active,
            onTap: () =>
                ref.read(filterProvider.notifier).setFilter(TodoFilter.active),
          ),
          const HGap.sm(),
          DiscordChip(
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
      padding: AppSpacing.screenPadding,
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
            DiscordSnackbar.show(
              context,
              message: l10n.todoDeleted(todo.title),
              variant: DiscordSnackbarVariant.info,
            );
          },
        );
      },
    );
  }
}
