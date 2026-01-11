import 'package:talker_flutter/talker_flutter.dart';

import 'package:flutter_autonomous_template/core/debug/debug_settings.dart';
import 'package:flutter_autonomous_template/features/todo/data/models/category.dart';
import 'package:flutter_autonomous_template/features/todo/data/models/todo.dart';
import 'package:flutter_autonomous_template/features/todo/data/repositories/todo_repository_impl.dart';

/// Debug implementation of TodoRepository
///
/// Extends [TodoRepositoryImpl] and adds debug capabilities:
/// - Simulated network delay
/// - Simulated errors
/// - Logging
class DebugTodoRepository extends TodoRepositoryImpl {
  DebugTodoRepository(
    super.prefs,
    this._debugSettings, {
    Talker? talker,
  }) : _talker = talker ?? Talker();

  final DebugSettings _debugSettings;
  final Talker _talker;

  /// Simulate network delay if enabled
  Future<void> _simulateDelay() async {
    if (_debugSettings.simulateNetworkDelay) {
      _log('Simulating network delay (2s)...');
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  /// Throw error if simulation is enabled
  void _checkError(String operation) {
    if (_debugSettings.simulateError) {
      _log('Simulating error for: $operation', isError: true);
      throw Exception('Debug: Simulated error in $operation');
    }
  }

  /// Log message if logging is enabled
  void _log(String message, {bool isError = false}) {
    if (_debugSettings.showNetworkLogs) {
      if (isError) {
        _talker.error('[DebugRepo] $message');
      } else {
        _talker.debug('[DebugRepo] $message');
      }
    }
  }

  @override
  List<Todo> getTodos() {
    _log('getTodos() called');
    _checkError('getTodos');
    return super.getTodos();
  }

  @override
  Future<Todo> createTodo({
    required String title,
    String description = '',
    DateTime? dueDate,
    Category? category,
  }) async {
    _log('createTodo() called: $title');
    await _simulateDelay();
    _checkError('createTodo');
    return super.createTodo(
      title: title,
      description: description,
      dueDate: dueDate,
      category: category,
    );
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    _log('updateTodo() called: ${todo.id}');
    await _simulateDelay();
    _checkError('updateTodo');
    return super.updateTodo(todo);
  }

  @override
  Future<void> deleteTodo(String id) async {
    _log('deleteTodo() called: $id');
    await _simulateDelay();
    _checkError('deleteTodo');
    return super.deleteTodo(id);
  }

  @override
  Future<Todo> toggleTodoCompletion(String id) async {
    _log('toggleTodoCompletion() called: $id');
    await _simulateDelay();
    _checkError('toggleTodoCompletion');
    return super.toggleTodoCompletion(id);
  }

  @override
  Future<void> clearCompleted() async {
    _log('clearCompleted() called');
    await _simulateDelay();
    _checkError('clearCompleted');
    return super.clearCompleted();
  }
}
