import 'dart:async';

import 'package:flutter_autonomous_template/features/auth/data/models/user.dart';
import 'package:flutter_autonomous_template/features/auth/data/repositories/auth_repository.dart';

/// Mock implementation of [AuthRepository]
///
/// Simulates authentication for development and testing.
/// Any email/password combination will succeed after a short delay.
class MockAuthRepository implements AuthRepository {
  MockAuthRepository() {
    _authStateController.add(null);
  }

  final _authStateController = StreamController<User?>.broadcast();
  User? _currentUser;

  @override
  User? get currentUser => _currentUser;

  @override
  Stream<User?> get authStateChanges => _authStateController.stream;

  @override
  Future<User> signIn({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1500));

    // Create mock user from email
    _currentUser = User(
      id: 'mock-user-${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      name: _extractNameFromEmail(email),
    );

    _authStateController.add(_currentUser);
    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    _currentUser = null;
    _authStateController.add(null);
  }

  /// Extract a display name from email
  /// e.g., "john.doe@example.com" -> "John Doe"
  String _extractNameFromEmail(String email) {
    final localPart = email.split('@').first;
    final words = localPart.split(RegExp(r'[._-]'));
    return words
        .map((word) => word.isEmpty
            ? ''
            : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
        .join(' ')
        .trim();
  }

  /// Dispose the stream controller
  void dispose() {
    _authStateController.close();
  }
}
