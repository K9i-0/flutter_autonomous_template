import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_autonomous_template/core/debug/debug_settings_provider.dart';
import 'package:flutter_autonomous_template/features/todo/data/models/category.dart';
import 'package:flutter_autonomous_template/features/todo/data/models/todo.dart';
import 'package:flutter_autonomous_template/features/todo/data/repositories/debug_todo_repository.dart';
import 'package:flutter_autonomous_template/features/todo/data/repositories/todo_repository.dart';
import 'package:flutter_autonomous_template/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:flutter_autonomous_template/features/todo/providers/filter_provider.dart';

/// SharedPreferences provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Must be overridden in ProviderScope');
});

/// TodoRepository provider
///
/// In debug mode, switches between [TodoRepositoryImpl] and [DebugTodoRepository]
/// based on [debugSettingsProvider].
final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);

  // In debug mode, check if debug repository is enabled
  if (kDebugMode) {
    final debugSettings = ref.watch(debugSettingsProvider);
    if (debugSettings.useDebugRepository) {
      return DebugTodoRepository(prefs, debugSettings);
    }
  }

  return TodoRepositoryImpl(prefs);
});

/// Provider for the list of TODOs
final todoListProvider = AsyncNotifierProvider<TodoListNotifier, List<Todo>>(
  TodoListNotifier.new,
);

/// Notifier for managing TODO list state
class TodoListNotifier extends AsyncNotifier<List<Todo>> {
  TodoRepository get _repository => ref.read(todoRepositoryProvider);

  @override
  Future<List<Todo>> build() async {
    // Watch the repository provider to rebuild when it changes
    ref.watch(todoRepositoryProvider);
    return _repository.getTodos();
  }

  /// Add a new TODO
  Future<void> addTodo({
    required String title,
    String description = '',
    DateTime? dueDate,
    Category? category,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.createTodo(
        title: title,
        description: description,
        dueDate: dueDate,
        category: category,
      );
      return [..._repository.getTodos()];
    });
  }

  /// Update an existing TODO
  Future<void> updateTodo(Todo todo) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.updateTodo(todo);
      return _repository.getTodos();
    });
  }

  /// Delete a TODO
  Future<void> deleteTodo(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.deleteTodo(id);
      return _repository.getTodos();
    });
  }

  /// Toggle TODO completion status
  Future<void> toggleCompletion(String id) async {
    // Optimistic update
    final previousState = state;
    state = state.whenData((todos) {
      return todos.map((todo) {
        if (todo.id == id) {
          return todo.copyWith(isCompleted: !todo.isCompleted);
        }
        return todo;
      }).toList();
    });

    try {
      await _repository.toggleTodoCompletion(id);
    } catch (e) {
      // Rollback on error
      state = previousState;
      rethrow;
    }
  }

  /// Clear all completed TODOs
  Future<void> clearCompleted() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.clearCompleted();
      return _repository.getTodos();
    });
  }
}

/// Provider for filtered TODOs
final filteredTodosProvider = Provider<AsyncValue<List<Todo>>>((ref) {
  final todosAsync = ref.watch(todoListProvider);
  final filter = ref.watch(filterProvider);

  return todosAsync.whenData((todos) {
    switch (filter) {
      case TodoFilter.all:
        return todos;
      case TodoFilter.active:
        return todos.where((t) => !t.isCompleted).toList();
      case TodoFilter.completed:
        return todos.where((t) => t.isCompleted).toList();
    }
  });
});

/// Provider for TODO statistics
final todoStatsProvider = Provider<({int total, int completed, int active})>((
  ref,
) {
  final todosAsync = ref.watch(todoListProvider);

  return todosAsync.when(
    data: (todos) => (
      total: todos.length,
      completed: todos.where((t) => t.isCompleted).length,
      active: todos.where((t) => !t.isCompleted).length,
    ),
    loading: () => (total: 0, completed: 0, active: 0),
    error: (_, _) => (total: 0, completed: 0, active: 0),
  );
});
