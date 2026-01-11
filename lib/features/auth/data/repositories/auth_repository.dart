import 'package:flutter_autonomous_template/features/auth/data/models/user.dart';

/// Abstract repository interface for authentication
///
/// This interface allows for different implementations:
/// - [MockAuthRepository] for development/testing
/// - Future: Firebase, Supabase, or other auth providers
abstract class AuthRepository {
  /// Get the currently authenticated user
  User? get currentUser;

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges;

  /// Sign in with email and password
  Future<User> signIn({
    required String email,
    required String password,
  });

  /// Sign out the current user
  Future<void> signOut();
}
