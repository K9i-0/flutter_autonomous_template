import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_autonomous_template/core/router/app_router.gr.dart';
import 'package:flutter_autonomous_template/core/router/auth_guard.dart';

/// Application router configuration
///
/// Deep link support:
/// - fluttertemplate://login -> Login screen
/// - fluttertemplate://todos -> TODO list (requires auth)
/// - fluttertemplate://settings -> Settings screen (requires auth)
/// - fluttertemplate://todo/edit/{id} -> Edit specific TODO (requires auth)
/// - fluttertemplate://todo/new -> Create new TODO (requires auth)
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter(this.ref);

  final Ref ref;

  @override
  List<AutoRoute> get routes => [
    // Login route (no auth required)
    AutoRoute(path: '/login', page: LoginRoute.page),

    // Main app routes (auth required)
    AutoRoute(
      path: '/',
      page: MainRoute.page,
      guards: [AuthGuard(ref)],
      children: [
        AutoRoute(path: 'todos', page: TodoListRoute.page, initial: true),
        AutoRoute(path: 'settings', page: SettingsRoute.page),
      ],
    ),

    // Edit existing TODO by ID (deep link: fluttertemplate://todo/edit/{id})
    AutoRoute(
      path: '/todo/edit/:id',
      page: TodoEditRoute.page,
      guards: [AuthGuard(ref)],
    ),

    // Create new TODO (deep link: fluttertemplate://todo/new)
    AutoRoute(
      path: '/todo/new',
      page: TodoEditRoute.page,
      guards: [AuthGuard(ref)],
    ),
  ];

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
}
