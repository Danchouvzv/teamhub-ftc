import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Сервис для аутентификации пользователей
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Текущий пользователь
  User? get currentUser => _auth.currentUser;

  /// Стрим для отслеживания состояния аутентификации
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Регистрация нового пользователя
  Future<UserCredential?> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Обновляем имя пользователя
      await credential.user?.updateDisplayName(name);

      if (kDebugMode) {
        print('✅ User registered: ${credential.user?.email}');
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('❌ Registration error: ${e.code} - ${e.message}');
      }
      rethrow;
    }
  }

  /// Вход с email и паролем
  Future<UserCredential?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (kDebugMode) {
        print('✅ User signed in: ${credential.user?.email}');
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('❌ Sign in error: ${e.code} - ${e.message}');
      }
      rethrow;
    }
  }

  /// Выход из системы
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      if (kDebugMode) {
        print('✅ User signed out');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Sign out error: $e');
      }
      rethrow;
    }
  }

  /// Сброс пароля
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      if (kDebugMode) {
        print('✅ Password reset email sent to: $email');
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('❌ Password reset error: ${e.code} - ${e.message}');
      }
      rethrow;
    }
  }

  /// Получить ошибку в читаемом формате
  String getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Этот email уже используется';
      case 'invalid-email':
        return 'Некорректный email';
      case 'operation-not-allowed':
        return 'Операция не разрешена';
      case 'weak-password':
        return 'Слишком слабый пароль';
      case 'user-disabled':
        return 'Пользователь заблокирован';
      case 'user-not-found':
        return 'Пользователь не найден';
      case 'wrong-password':
        return 'Неверный пароль';
      case 'invalid-credential':
        return 'Неверные учетные данные';
      case 'network-request-failed':
        return 'Ошибка сети. Проверьте подключение';
      default:
        return 'Произошла ошибка: ${e.message}';
    }
  }
}

