// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:flutter_autonomous_template/features/auth/ui/screens/login_screen.dart'
    as _i1;
import 'package:flutter_autonomous_template/features/main/ui/screens/main_screen.dart'
    as _i2;
import 'package:flutter_autonomous_template/features/settings/ui/screens/settings_screen.dart'
    as _i3;
import 'package:flutter_autonomous_template/features/todo/data/models/todo.dart'
    as _i8;
import 'package:flutter_autonomous_template/features/todo/ui/screens/todo_edit_screen.dart'
    as _i4;
import 'package:flutter_autonomous_template/features/todo/ui/screens/todo_list_screen.dart'
    as _i5;

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.LoginScreen();
    },
  );
}

/// generated route for
/// [_i2.MainScreen]
class MainRoute extends _i6.PageRouteInfo<void> {
  const MainRoute({List<_i6.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.MainScreen();
    },
  );
}

/// generated route for
/// [_i3.SettingsScreen]
class SettingsRoute extends _i6.PageRouteInfo<void> {
  const SettingsRoute({List<_i6.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i4.TodoEditScreen]
class TodoEditRoute extends _i6.PageRouteInfo<TodoEditRouteArgs> {
  TodoEditRoute({
    _i7.Key? key,
    _i8.Todo? todo,
    String? todoId,
    List<_i6.PageRouteInfo>? children,
  }) : super(
         TodoEditRoute.name,
         args: TodoEditRouteArgs(key: key, todo: todo, todoId: todoId),
         rawPathParams: {'id': todoId},
         initialChildren: children,
       );

  static const String name = 'TodoEditRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TodoEditRouteArgs>(
        orElse: () => TodoEditRouteArgs(todoId: pathParams.optString('id')),
      );
      return _i4.TodoEditScreen(
        key: args.key,
        todo: args.todo,
        todoId: args.todoId,
      );
    },
  );
}

class TodoEditRouteArgs {
  const TodoEditRouteArgs({this.key, this.todo, this.todoId});

  final _i7.Key? key;

  final _i8.Todo? todo;

  final String? todoId;

  @override
  String toString() {
    return 'TodoEditRouteArgs{key: $key, todo: $todo, todoId: $todoId}';
  }
}

/// generated route for
/// [_i5.TodoListScreen]
class TodoListRoute extends _i6.PageRouteInfo<void> {
  const TodoListRoute({List<_i6.PageRouteInfo>? children})
    : super(TodoListRoute.name, initialChildren: children);

  static const String name = 'TodoListRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.TodoListScreen();
    },
  );
}
