import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:flutter_autonomous_template/features/todo/data/models/category.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

/// TODO item model
@freezed
sealed class Todo with _$Todo {
  const factory Todo({
    required String id,
    required String title,
    @Default('') String description,
    @Default(false) bool isCompleted,
    required DateTime createdAt,
    DateTime? dueDate,
    Category? category,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

/// Filter options for TODOs
enum TodoFilter { all, active, completed }
