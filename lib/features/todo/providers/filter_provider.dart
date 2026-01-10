import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_autonomous_template/features/todo/data/models/todo.dart';

/// Provider for the current filter state
final filterProvider = NotifierProvider<FilterNotifier, TodoFilter>(
  FilterNotifier.new,
);

/// Notifier for managing filter state
class FilterNotifier extends Notifier<TodoFilter> {
  @override
  TodoFilter build() {
    return TodoFilter.all;
  }

  void setFilter(TodoFilter filter) {
    state = filter;
  }
}
