import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_autonomous_template/features/todo/data/models/category.dart';
import 'package:flutter_autonomous_template/features/todo/data/models/todo.dart';
import 'package:flutter_autonomous_template/features/todo/data/repositories/todo_repository.dart';

/// Production implementation of [TodoRepository]
///
/// Uses SharedPreferences for local persistence.
class TodoRepositoryImpl implements TodoRepository {
  TodoRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;
  static const _todosKey = 'todos';
  static const _uuid = Uuid();

  @override
  List<Todo> getTodos() {
    final jsonString = _prefs.getString(_todosKey);
    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    return jsonList
        .map((e) => Todo.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Save all TODO items (internal use)
  Future<void> saveTodos(List<Todo> todos) async {
    final jsonList = todos.map((e) => e.toJson()).toList();
    await _prefs.setString(_todosKey, json.encode(jsonList));
  }

  @override
  Future<Todo> createTodo({
    required String title,
    String description = '',
    DateTime? dueDate,
    Category? category,
  }) async {
    final todo = Todo(
      id: _uuid.v4(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
      dueDate: dueDate,
      category: category,
    );

    final todos = getTodos();
    todos.add(todo);
    await saveTodos(todos);

    return todo;
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final todos = getTodos();
    final index = todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      await saveTodos(todos);
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = getTodos();
    todos.removeWhere((t) => t.id == id);
    await saveTodos(todos);
  }

  @override
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

  @override
  Future<void> clearCompleted() async {
    final todos = getTodos();
    todos.removeWhere((t) => t.isCompleted);
    await saveTodos(todos);
  }
}
