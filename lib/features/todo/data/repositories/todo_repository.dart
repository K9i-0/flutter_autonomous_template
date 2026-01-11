import 'package:flutter_autonomous_template/features/todo/data/models/category.dart';
import 'package:flutter_autonomous_template/features/todo/data/models/todo.dart';

/// Abstract repository interface for TODO items
///
/// This interface allows for different implementations:
/// - [TodoRepositoryImpl] for production
/// - [DebugTodoRepository] for debugging/testing
abstract class TodoRepository {
  /// Get all TODO items
  List<Todo> getTodos();

  /// Create a new TODO item
  Future<Todo> createTodo({
    required String title,
    String description = '',
    DateTime? dueDate,
    Category? category,
  });

  /// Update an existing TODO item
  Future<void> updateTodo(Todo todo);

  /// Delete a TODO item
  Future<void> deleteTodo(String id);

  /// Toggle TODO completion status
  Future<Todo> toggleTodoCompletion(String id);

  /// Clear all completed TODOs
  Future<void> clearCompleted();
}
