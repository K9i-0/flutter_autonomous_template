import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_autonomous_template/features/todo/data/models/todo.dart';

/// Repository for managing TODO items persistence
class TodoRepository {
  TodoRepository(this._prefs);

  final SharedPreferences _prefs;
  static const _todosKey = 'todos';
  static const _uuid = Uuid();

  /// Get all TODO items
  List<Todo> getTodos() {
    final jsonString = _prefs.getString(_todosKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    return jsonList
        .map((e) => Todo.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Save all TODO items
  Future<void> saveTodos(List<Todo> todos) async {
    final jsonList = todos.map((e) => e.toJson()).toList();
    await _prefs.setString(_todosKey, json.encode(jsonList));
  }

  /// Create a new TODO item
  Future<Todo> createTodo({
    required String title,
    String description = '',
    DateTime? dueDate,
  }) async {
    final todo = Todo(
      id: _uuid.v4(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
      dueDate: dueDate,
    );

    final todos = getTodos();
    todos.add(todo);
    await saveTodos(todos);

    return todo;
  }

  /// Update an existing TODO item
  Future<void> updateTodo(Todo todo) async {
    final todos = getTodos();
    final index = todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      await saveTodos(todos);
    }
  }

  /// Delete a TODO item
  Future<void> deleteTodo(String id) async {
    final todos = getTodos();
    todos.removeWhere((t) => t.id == id);
    await saveTodos(todos);
  }

  /// Toggle TODO completion status
  Future<Todo> toggleTodoCompletion(String id) async {
    final todos = getTodos();
    final index = todos.indexWhere((t) => t.id == id);
    if (index != -1) {
      final todo = todos[index];
      final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
      todos[index] = updatedTodo;
      await saveTodos(todos);
      return updatedTodo;
    }
    throw Exception('Todo not found');
  }

  /// Clear all completed TODOs
  Future<void> clearCompleted() async {
    final todos = getTodos();
    todos.removeWhere((t) => t.isCompleted);
    await saveTodos(todos);
  }
}
