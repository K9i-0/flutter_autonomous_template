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

@RoutePage()
class TodoListScreen extends ConsumerStatefulWidget {
  const TodoListScreen({super.key});

  @override
  ConsumerState<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends ConsumerState<TodoListScreen> {
  final _inputController = TextEditingController();

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          _buildFilterChips(context, currentFilter, stats, l10n),
          Expanded(
            child: filteredTodos.when(
              data: (todos) => _buildMessageList(context, todos, l10n),
              loading: () => const AppLoadingOverlay(),
              error: (error, stack) => AppErrorState(
                error: error,
                onRetry: () => ref.invalidate(todoListProvider),
              ),
            ),
          ),
          // Discord-style input bar at the bottom
          DiscordInputBarWithSend(
            hintText: l10n.todoTitleHint,
            onSend: _handleQuickAdd,
            onLeadingPressed: () => context.router.push(TodoEditRoute()),
          ),
        ],
      ),
    );
  }

  void _handleQuickAdd(String title) {
    if (title.trim().isEmpty) return;

    ref.read(todoListProvider.notifier).addTodo(
          title: title.trim(),
        );
  }

  Widget _buildFilterChips(
    BuildContext context,
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

  Widget _buildMessageList(
    BuildContext context,
    List<Todo> todos,
    AppLocalizations l10n,
  ) {
    if (todos.isEmpty) {
      return AppEmptyState(
        icon: Icons.chat_bubble_outline,
        title: l10n.todoEmptyTitle,
        description: l10n.todoEmptyDescription,
      );
    }

    // Group todos by date
    final groupedTodos = _groupTodosByDate(todos);
    final dateKeys = groupedTodos.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      itemCount: dateKeys.length,
      itemBuilder: (context, index) {
        final dateKey = dateKeys[index];
        final todosForDate = groupedTodos[dateKey]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date separator
            DiscordDateSeparator(
              label: _formatDateKey(dateKey, l10n),
            ),
            // Todos for this date
            ...todosForDate.map(
              (todo) => _buildTodoMessage(context, todo, l10n),
            ),
          ],
        );
      },
    );
  }

  Map<String, List<Todo>> _groupTodosByDate(List<Todo> todos) {
    final grouped = <String, List<Todo>>{};

    for (final todo in todos) {
      // Use due date if available, otherwise use created date
      final date = todo.dueDate ?? todo.createdAt;
      final dateKey = _getDateKey(date);

      grouped.putIfAbsent(dateKey, () => []);
      grouped[dateKey]!.add(todo);
    }

    // Sort by date (most recent first)
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    return {for (final key in sortedKeys) key: grouped[key]!};
  }

  String _getDateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  String _formatDateKey(String dateKey, AppLocalizations l10n) {
    final parts = dateKey.split('-');
    final date = DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final diff = today.difference(date).inDays;

    if (diff == 0) {
      return l10n.dateToday;
    } else if (diff == 1) {
      return l10n.dateYesterday;
    } else if (diff == -1) {
      return l10n.dateTomorrow;
    } else {
      return date.toDiscordDateLabel();
    }
  }

  Widget _buildTodoMessage(
    BuildContext context,
    Todo todo,
    AppLocalizations l10n,
  ) {
    // Build reactions based on category and priority
    final reactions = <MessageReaction>[];

    if (todo.category != null) {
      reactions.add(MessageReaction(
        emoji: _getCategoryEmoji(todo.category!.colorIndex),
        id: 'category',
      ));
    }

    // Add due date indicator if overdue
    if (todo.dueDate != null && !todo.isCompleted) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final dueDate = DateTime(
        todo.dueDate!.year,
        todo.dueDate!.month,
        todo.dueDate!.day,
      );
      if (dueDate.isBefore(today)) {
        reactions.add(const MessageReaction(emoji: '⚠️', id: 'overdue'));
      }
    }

    return DiscordMessageBubble(
      title: todo.title,
      description: todo.description.isNotEmpty ? todo.description : null,
      timestamp: _formatTimestamp(todo.createdAt),
      avatarText: todo.title.isNotEmpty ? todo.title[0] : '?',
      avatarColor: _getAvatarColor(todo),
      isCompleted: todo.isCompleted,
      reactions: reactions.isNotEmpty ? reactions : null,
      onTap: () => context.router.push(TodoEditRoute(todo: todo)),
      onLongPress: () => _showTodoActions(context, todo, l10n),
      trailing: DiscordCheckbox(
        value: todo.isCompleted,
        onChanged: (_) {
          ref.read(todoListProvider.notifier).toggleCompletion(todo.id);
        },
        semanticLabel: todo.isCompleted ? l10n.markIncomplete : l10n.markComplete,
      ),
    );
  }

  Color _getAvatarColor(Todo todo) {
    if (todo.category != null) {
      return CategoryColors.byIndex(todo.category!.colorIndex);
    }
    // Generate a color based on the title
    final hash = todo.title.hashCode;
    final colors = [
      DiscordColors.blurple,
      DiscordColors.green,
      DiscordColors.yellow,
      const Color(0xFFEB459E), // Fuchsia
      const Color(0xFF9B59B6), // Purple
    ];
    return colors[hash.abs() % colors.length];
  }

  String _getCategoryEmoji(int colorIndex) {
    const emojis = ['🔴', '🟠', '🟡', '🟢', '🔵', '🟣', '⚪'];
    return emojis[colorIndex % emojis.length];
  }

  String _formatTimestamp(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  void _showTodoActions(BuildContext context, Todo todo, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => DiscordBottomSheet(
        title: todo.title,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DiscordListTile(
              leading: const Icon(Icons.edit_outlined),
              title: l10n.todoEdit,
              onTap: () {
                Navigator.pop(context);
                this.context.router.push(TodoEditRoute(todo: todo));
              },
            ),
            DiscordListTile(
              leading: Icon(
                todo.isCompleted
                    ? Icons.radio_button_unchecked
                    : Icons.check_circle_outline,
              ),
              title: todo.isCompleted ? l10n.markIncomplete : l10n.markComplete,
              onTap: () {
                Navigator.pop(context);
                ref.read(todoListProvider.notifier).toggleCompletion(todo.id);
              },
            ),
            DiscordListTile(
              leading: const Icon(Icons.delete_outline, color: DiscordColors.red),
              title: l10n.delete,
              titleStyle: const TextStyle(color: DiscordColors.red),
              onTap: () async {
                Navigator.pop(context);
                final confirmed = await DiscordConfirmSheet.show(
                  context: this.context,
                  title: l10n.todoDeleteTitle,
                  description: l10n.todoDeleteConfirm(todo.title),
                  confirmLabel: l10n.delete,
                  cancelLabel: l10n.cancel,
                  isDestructive: true,
                );
                if (confirmed == true) {
                  ref.read(todoListProvider.notifier).deleteTodo(todo.id);
                  if (this.context.mounted) {
                    DiscordSnackbar.show(
                      this.context,
                      message: l10n.todoDeleted(todo.title),
                      variant: DiscordSnackbarVariant.info,
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
