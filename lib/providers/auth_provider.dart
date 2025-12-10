import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/user_model.dart';

/// Provider для AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

/// Provider для FirestoreService
final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService();
});

/// Provider для отслеживания состояния аутентификации
final authStateProvider = StreamProvider<User?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
});

/// Provider для текущего пользователя (Firebase User)
final currentFirebaseUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.value;
});

/// Provider для текущего пользователя (UserModel из Firestore)
final currentUserProvider = StreamProvider<UserModel?>((ref) async* {
  final authState = ref.watch(authStateProvider);
  final user = authState.value;
  
  if (user == null) {
    yield null;
    return;
  }

  final firestoreService = ref.watch(firestoreServiceProvider);
  
  try {
    final userModel = await firestoreService.getUser(user.uid);
    yield userModel;
  } catch (e) {
    yield null;
  }
});

/// Provider для регистрации
final signUpProvider = Provider<Future<UserCredential?> Function({
  required String email,
  required String password,
  required String name,
})>((ref) {
  final authService = ref.watch(authServiceProvider);
  return ({
    required String email,
    required String password,
    required String name,
  }) async {
    return await authService.signUpWithEmail(
      email: email,
      password: password,
      name: name,
    );
  };
});

/// Provider для входа
final signInProvider = Provider<Future<UserCredential?> Function({
  required String email,
  required String password,
})>((ref) {
  final authService = ref.watch(authServiceProvider);
  return ({
    required String email,
    required String password,
  }) async {
    return await authService.signInWithEmail(
      email: email,
      password: password,
    );
  };
});

/// Provider для выхода
final signOutProvider = Provider<Future<void> Function()>((ref) {
  final authService = ref.watch(authServiceProvider);
  return () async {
    await authService.signOut();
  };
});

