# IHSAN AI Enhancer

A complete professional Flutter Android application for AI-powered photo enhancement.

## Features

- **Professional Dark UI**: Premium modern design with smooth animations.
- **Firebase Integration**: Authentication, Firestore history, and Cloud Storage.
- **Email Verification**: Secure signup flow with email verification.
- **AI Photo Enhancer**: Restore old photos and enhance quality to HD.
- **Background Remover**: Accurate edge cutout and HD PNG export.
- **AI Filters**: Cinematic and portrait enhancement filters.
- **Compare Feature**: Smooth before/after slider for results.
- **AI Cleanup**: Smart object remover tool.
- **History System**: Save and manage your processing history.

## Setup Instructions

### 1. Firebase Configuration
- Create a new project on [Firebase Console](https://console.firebase.google.com/).
- Add an Android app with package name `com.ihsan.aienhancer`.
- Download `google-services.json` and place it in `android/app/`.
- Enable Email/Password and Google Sign-In in Firebase Auth.
- Enable Cloud Firestore and Firebase Storage.

### 2. API Keys
- Open `lib/core/constants/app_constants.dart`.
- Replace `YOUR_REPLICATE_API_KEY` with your [Replicate API key](https://replicate.com/).
- Replace `YOUR_REMOVE_BG_API_KEY` with your [Remove.bg API key](https://www.remove.bg/api).

### 3. Build & Run
```bash
flutter pub get
flutter run
```

### 4. Play Store Release
- Update the version in `pubspec.yaml`.
- Configure your release signing in `android/app/build.gradle`.
- Build the app bundle:
```bash
flutter build appbundle
```

## Architecture
The project follows a clean architecture pattern:
- `core/`: Constants, themes, and shared utilities.
- `data/`: Models and services (Firebase, APIs).
- `presentation/`: UI screens, widgets, and state management (Providers).

## Important Fixes Included
- **Email Verification**: Users cannot log in until they verify their email.
- **Splash Flow**: Correct navigation from Splash -> Auth Check -> Login/Home.
- **Play Store Ready**: Optimized manifest, target SDK 34, and release-ready build config.
