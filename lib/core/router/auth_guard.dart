import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_autonomous_template/core/router/app_router.gr.dart';
import 'package:flutter_autonomous_template/features/auth/providers/auth_provider.dart';

/// Guard that checks if user is authenticated
///
/// Redirects to [LoginRoute] if not authenticated.
class AuthGuard extends AutoRouteGuard {
  AuthGuard(this.ref);

  final Ref ref;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isAuthenticated = ref.read(isAuthenticatedProvider);

    if (isAuthenticated) {
      // User is authenticated, allow navigation
      resolver.next(true);
    } else {
      // User is not authenticated, redirect to login
      resolver.redirect(const LoginRoute());
    }
  }
}
