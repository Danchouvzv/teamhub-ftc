import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Сервис для инициализации Firebase
class FirebaseService {
  static Future<void> initialize() async {
    try {
      await Firebase.initializeApp(
        options: _getFirebaseOptions(),
      );
      if (kDebugMode) {
        print('✅ Firebase initialized successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Firebase initialization error: $e');
      }
      rethrow;
    }
  }

  /// Конфигурация Firebase для каждой платформы
  /// TODO: Заменить на реальные значения из Firebase Console
  static FirebaseOptions _getFirebaseOptions() {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return const FirebaseOptions(
        apiKey: 'YOUR_IOS_API_KEY',
        appId: 'YOUR_IOS_APP_ID',
        messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
        projectId: 'YOUR_PROJECT_ID',
        storageBucket: 'YOUR_STORAGE_BUCKET',
        iosBundleId: 'com.ftc.ftc_teamhub',
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return const FirebaseOptions(
        apiKey: 'YOUR_ANDROID_API_KEY',
        appId: 'YOUR_ANDROID_APP_ID',
        messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
        projectId: 'YOUR_PROJECT_ID',
        storageBucket: 'YOUR_STORAGE_BUCKET',
      );
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}

