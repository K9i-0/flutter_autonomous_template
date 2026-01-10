// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:flutter_autonomous_template/features/main/ui/screens/main_screen.dart'
    as _i1;
import 'package:flutter_autonomous_template/features/settings/ui/screens/settings_screen.dart'
    as _i2;
import 'package:flutter_autonomous_template/features/todo/data/models/todo.dart'
    as _i7;
import 'package:flutter_autonomous_template/features/todo/ui/screens/todo_edit_screen.dart'
    as _i3;
import 'package:flutter_autonomous_template/features/todo/ui/screens/todo_list_screen.dart'
    as _i4;

/// generated route for
/// [_i1.MainScreen]
class MainRoute extends _i5.PageRouteInfo<void> {
  const MainRoute({List<_i5.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.MainScreen();
    },
  );
}

/// generated route for
/// [_i2.SettingsScreen]
class SettingsRoute extends _i5.PageRouteInfo<void> {
  const SettingsRoute({List<_i5.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i3.TodoEditScreen]
class TodoEditRoute extends _i5.PageRouteInfo<TodoEditRouteArgs> {
  TodoEditRoute({
    _i6.Key? key,
    _i7.Todo? todo,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         TodoEditRoute.name,
         args: TodoEditRouteArgs(key: key, todo: todo),
         initialChildren: children,
       );

  static const String name = 'TodoEditRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TodoEditRouteArgs>(
        orElse: () => const TodoEditRouteArgs(),
      );
      return _i3.TodoEditScreen(key: args.key, todo: args.todo);
    },
  );
}

class TodoEditRouteArgs {
  const TodoEditRouteArgs({this.key, this.todo});

  final _i6.Key? key;

  final _i7.Todo? todo;

  @override
  String toString() {
    return 'TodoEditRouteArgs{key: $key, todo: $todo}';
  }
}

/// generated route for
/// [_i4.TodoListScreen]
class TodoListRoute extends _i5.PageRouteInfo<void> {
  const TodoListRoute({List<_i5.PageRouteInfo>? children})
    : super(TodoListRoute.name, initialChildren: children);

  static const String name = 'TodoListRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.TodoListScreen();
    },
  );
}
