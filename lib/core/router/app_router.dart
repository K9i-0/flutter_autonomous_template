import 'package:auto_route/auto_route.dart';

import 'package:flutter_autonomous_template/core/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/',
          page: MainRoute.page,
          children: [
            AutoRoute(
              path: 'todos',
              page: TodoListRoute.page,
              initial: true,
            ),
            AutoRoute(
              path: 'settings',
              page: SettingsRoute.page,
            ),
          ],
        ),
        AutoRoute(
          path: '/todo/edit',
          page: TodoEditRoute.page,
        ),
      ];
}
