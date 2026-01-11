import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_autonomous_template/core/components/app_button.dart';
import 'package:flutter_autonomous_template/core/components/app_text_field.dart';
import 'package:flutter_autonomous_template/core/l10n/app_localizations.dart';
import 'package:flutter_autonomous_template/core/theme/app_spacing.dart';
import 'package:flutter_autonomous_template/features/todo/data/models/todo.dart';
import 'package:flutter_autonomous_template/features/todo/providers/todo_provider.dart';

@RoutePage()
class TodoEditScreen extends ConsumerStatefulWidget {
  const TodoEditScreen({
    super.key,
    this.todo,
    @PathParam('id') this.todoId,
  });

  final Todo? todo;
  final String? todoId;

  @override
  ConsumerState<TodoEditScreen> createState() => _TodoEditScreenState();
}

class _TodoEditScreenState extends ConsumerState<TodoEditScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  DateTime? _dueDate;
  bool _isLoading = false;
  Todo? _resolvedTodo;

  /// Check if we're editing an existing todo
  /// Either by direct Todo object or by resolving via todoId
  bool get isEditing => _resolvedTodo != null;

  @override
  void initState() {
    super.initState();
    // Resolve todo: either from direct parameter or by looking up via todoId
    _resolvedTodo = widget.todo ?? _findTodoById(widget.todoId);
    _titleController = TextEditingController(text: _resolvedTodo?.title);
    _descriptionController = TextEditingController(
      text: _resolvedTodo?.description,
    );
    _dueDate = _resolvedTodo?.dueDate;
  }

  /// Find todo by ID from the current todo list
  Todo? _findTodoById(String? id) {
    if (id == null) return null;
    final todosAsync = ref.read(todoListProvider);
    return todosAsync.whenOrNull(
      data: (todos) => todos.where((t) => t.id == id).firstOrNull,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? l10n.todoEdit : l10n.todoNew),
        actions: [
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _handleDelete,
            ),
        ],
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              controller: _titleController,
              label: l10n.todoTitle,
              hint: l10n.todoTitleHint,
              textInputAction: TextInputAction.next,
              autofocus: !isEditing,
            ),
            const VGap.md(),
            AppTextField(
              controller: _descriptionController,
              label: l10n.todoDescriptionOptional,
              hint: l10n.todoDescriptionHint,
              maxLines: 3,
              textInputAction: TextInputAction.newline,
            ),
            const VGap.md(),
            _buildDueDatePicker(context, l10n),
            const VGap.xl(),
            AppButton(
              label: isEditing ? l10n.saveChanges : l10n.todoAdd,
              onPressed: _handleSave,
              isLoading: _isLoading,
              isExpanded: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDueDatePicker(BuildContext context, AppLocalizations l10n) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: _pickDueDate,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: InputDecoration(labelText: l10n.todoDueDateOptional),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _dueDate != null ? _formatDate(_dueDate!, l10n) : l10n.todoDueDateNone,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: _dueDate != null
                    ? colorScheme.onSurface
                    : colorScheme.outline,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_dueDate != null)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _dueDate = null;
                      });
                    },
                  ),
                Icon(Icons.calendar_today, color: colorScheme.onSurfaceVariant),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDueDate() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    // Allow past dates when editing an existing TODO with past due date
    final firstDate = (_dueDate != null && _dueDate!.isBefore(today))
        ? _dueDate!
        : today;
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? today,
      firstDate: firstDate,
      lastDate: now.add(const Duration(days: 365 * 2)),
    );

    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  String _formatDate(DateTime date, AppLocalizations l10n) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);
    final diff = dateOnly.difference(today).inDays;

    if (diff == 0) {
      return l10n.dateToday;
    } else if (diff == 1) {
      return l10n.dateTomorrow;
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }

  Future<void> _handleSave() async {
    final l10n = AppLocalizations.of(context);
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.todoTitleRequired)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      if (isEditing) {
        final updatedTodo = _resolvedTodo!.copyWith(
          title: title,
          description: _descriptionController.text.trim(),
          dueDate: _dueDate,
        );
        await ref.read(todoListProvider.notifier).updateTodo(updatedTodo);
      } else {
        await ref
            .read(todoListProvider.notifier)
            .addTodo(
              title: title,
              description: _descriptionController.text.trim(),
              dueDate: _dueDate,
            );
      }

      if (mounted) {
        context.router.maybePop();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleDelete() async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.todoDeleteTitle),
        content: Text(l10n.todoDeleteConfirm(_resolvedTodo!.title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(todoListProvider.notifier).deleteTodo(_resolvedTodo!.id);
      if (mounted) {
        context.router.maybePop();
      }
    }
  }
}
