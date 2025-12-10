# 🔥 Firebase Setup Guide

## Шаг 1: Создать Firebase проект

1. Перейдите на [Firebase Console](https://console.firebase.google.com/)
2. Нажмите "Add project" / "Создать проект"
3. Введите название: **FTC TeamHub**
4. Отключите Google Analytics (можно включить позже)
5. Нажмите "Create project"

---

## Шаг 2: Настроить iOS

### 2.1. Добавить iOS приложение

1. В Firebase Console выберите ваш проект
2. Нажмите на иконку iOS
3. Введите **Bundle ID**: `com.ftc.ftc_teamhub`
4. App nickname: `FTC TeamHub iOS` (опционально)
5. Нажмите "Register app"

### 2.2. Скачать GoogleService-Info.plist

1. Скачайте файл `GoogleService-Info.plist`
2. Переместите его в: `ios/Runner/GoogleService-Info.plist`
3. Откройте проект в Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```
4. Перетащите `GoogleService-Info.plist` в Xcode в папку `Runner`
5. Убедитесь, что выбран target "Runner"

### 2.3. Обновить firebase_service.dart

Откройте `lib/services/firebase_service.dart` и замените iOS конфигурацию:

```dart
if (defaultTargetPlatform == TargetPlatform.iOS) {
  return const FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',           // Из GoogleService-Info.plist
    appId: 'YOUR_IOS_APP_ID',             // Из GoogleService-Info.plist
    messagingSenderId: 'YOUR_SENDER_ID',   // Из GoogleService-Info.plist
    projectId: 'YOUR_PROJECT_ID',          // Из GoogleService-Info.plist
    storageBucket: 'YOUR_STORAGE_BUCKET',  // Из GoogleService-Info.plist
    iosBundleId: 'com.ftc.ftc_teamhub',
  );
}
```

---

## Шаг 3: Настроить Android

### 3.1. Добавить Android приложение

1. В Firebase Console нажмите на иконку Android
2. Введите **Package name**: `com.ftc.ftc_teamhub`
3. App nickname: `FTC TeamHub Android` (опционально)
4. Debug signing certificate SHA-1 (опционально для dev)
5. Нажмите "Register app"

### 3.2. Скачать google-services.json

1. Скачайте файл `google-services.json`
2. Переместите его в: `android/app/google-services.json`

### 3.3. Обновить build.gradle

Файл `android/build.gradle`:
```gradle
buildscript {
    dependencies {
        // ...
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

Файл `android/app/build.gradle`:
```gradle
// В самом низу файла добавьте:
apply plugin: 'com.google.gms.google-services'
```

### 3.4. Обновить firebase_service.dart

Откройте `lib/services/firebase_service.dart` и замените Android конфигурацию:

```dart
else if (defaultTargetPlatform == TargetPlatform.android) {
  return const FirebaseOptions(
    apiKey: 'YOUR_ANDROID_API_KEY',       // Из google-services.json
    appId: 'YOUR_ANDROID_APP_ID',         // Из google-services.json
    messagingSenderId: 'YOUR_SENDER_ID',   // Из google-services.json
    projectId: 'YOUR_PROJECT_ID',          // Из google-services.json
    storageBucket: 'YOUR_STORAGE_BUCKET',  // Из google-services.json
  );
}
```

---

## Шаг 4: Включить Authentication

1. В Firebase Console перейдите в **Authentication**
2. Нажмите "Get started"
3. Во вкладке "Sign-in method" включите:
   - ✅ **Email/Password** - нажмите "Enable" и сохраните
   - ✅ **Google** (опционально для будущего)

---

## Шаг 5: Настроить Firestore Database

1. В Firebase Console перейдите в **Firestore Database**
2. Нажмите "Create database"
3. Выберите режим:
   - **Test mode** (для разработки) - данные доступны всем на 30 дней
   - **Production mode** (для продакшена) - данные защищены
4. Выберите регион: **europe-west** (ближайший к Казахстану)
5. Нажмите "Enable"

### Firestore Rules (для начала):

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Пользователи могут читать и писать только свои данные
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Команды доступны участникам
    match /teams/{teamId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
    
    // Проекты, задачи, события, идеи, заметки
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

---

## Шаг 6: Настроить Firebase Storage

1. В Firebase Console перейдите в **Storage**
2. Нажмите "Get started"
3. Выберите "Start in test mode"
4. Выберите регион: **europe-west**
5. Нажмите "Done"

### Storage Rules (для начала):

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

---

## Шаг 7: Запустить приложение

```bash
# Очистить кеш
flutter clean

# Установить зависимости
flutter pub get

# Для iOS (дополнительно)
cd ios && pod install && cd ..

# Запустить
flutter run
```

---

## 🎉 Готово!

Теперь ваше приложение подключено к Firebase!

### Следующие шаги:

1. ✅ Тестируем регистрацию и вход
2. ✅ Создаем первую команду
3. ✅ Добавляем реальные данные

### Полезные ссылки:

- [Firebase Console](https://console.firebase.google.com/)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firestore Documentation](https://firebase.google.com/docs/firestore)

