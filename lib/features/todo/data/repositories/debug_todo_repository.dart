import 'package:flutter_autonomous_template/features/todo/data/models/category.dart';
import 'package:flutter_autonomous_template/features/todo/data/models/todo.dart';
import 'package:flutter_autonomous_template/features/todo/data/repositories/todo_repository.dart';

/// Debug implementation of TodoRepository
///
/// Extends [TodoRepository] and provides dummy data for screenshots
/// and UI demonstrations. Other operations delegate to super.
class DebugTodoRepository extends TodoRepository {
  DebugTodoRepository(super.prefs);

  /// Returns dummy TODOs for screenshots and demonstrations
  @override
  List<Todo> getTodos() {
    final now = DateTime.now();

    return [
      Todo(
        id: 'dummy-1',
        title: 'Buy groceries',
        description: 'Milk, eggs, bread, vegetables',
        createdAt: now.subtract(const Duration(days: 2)),
        dueDate: now.add(const Duration(days: 1)),
        category: DefaultCategories.shopping,
      ),
      Todo(
        id: 'dummy-2',
        title: 'Finish project report',
        description: 'Complete the quarterly report for the team meeting',
        createdAt: now.subtract(const Duration(days: 1)),
        dueDate: now.add(const Duration(days: 3)),
        category: DefaultCategories.work,
      ),
      Todo(
        id: 'dummy-3',
        title: 'Call mom',
        description: '',
        createdAt: now.subtract(const Duration(hours: 5)),
        category: DefaultCategories.personal,
        isCompleted: true,
      ),
      Todo(
        id: 'dummy-4',
        title: 'Go to the gym',
        description: 'Leg day workout',
        createdAt: now.subtract(const Duration(days: 3)),
        dueDate: now,
        category: DefaultCategories.health,
      ),
      Todo(
        id: 'dummy-5',
        title: 'Read Flutter documentation',
        description: 'Learn about new features in Flutter 3.x',
        createdAt: now.subtract(const Duration(days: 4)),
        category: DefaultCategories.personal,
        isCompleted: true,
      ),
      Todo(
        id: 'dummy-6',
        title: 'Prepare presentation',
        description: 'Slides for the client meeting on Friday',
        createdAt: now.subtract(const Duration(hours: 12)),
        dueDate: now.add(const Duration(days: 2)),
        category: DefaultCategories.work,
      ),
    ];
  }
}
