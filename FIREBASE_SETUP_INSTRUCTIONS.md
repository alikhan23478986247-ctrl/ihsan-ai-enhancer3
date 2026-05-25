# IHSAN AI Enhancer — Complete Setup & Build Guide

---

## What Was Fixed & Configured

| File | Change |
|---|---|
| lib/firebase_options.dart | GENERATED from your google-services.json credentials |
| lib/main.dart | Firebase now initialised with DefaultFirebaseOptions.currentPlatform |
| lib/presentation/providers/auth_provider.dart | Full signInWithGoogle() method + clean error messages |
| android/app/google-services.json | Placed in the correct android/app/ directory |
| android/app/build.gradle | Firebase BoM 32.7.0, Google Sign-In, MultiDex, proguard |
| android/build.gradle | Google Services classpath confirmed |
| android/settings.gradle | Flutter plugin loader added |
| android/app/src/main/kotlin/.../MainActivity.kt | Standard Flutter MainActivity created |
| android/app/proguard-rules.pro | Firebase + Kotlin + Google Sign-In ProGuard rules |
| android/app/src/main/AndroidManifest.xml | INTERNET, camera, storage, Google Sign-In activity |
| pubspec.yaml | Fixed before_after to 3.2.0, intl to 0.19.0 for Dart 3 compat |
| .github/workflows/build_apk.yml | GitHub Actions workflow to auto-build the APK |
| build_local.sh | One-command local build script |

---

## STEP 1 — Firebase Console Setup (Required Before Building)

### A. Enable Email/Password Authentication
1. Open Firebase Console at https://console.firebase.google.com
2. Select project ihsan-ai-enhancer
3. Click Authentication in the left menu
4. Click Sign-in method tab
5. Click Email/Password, enable it, and click Save

### B. Enable Google Sign-In and Get SHA-1
Google Sign-In on Android requires your app's SHA-1 fingerprint registered in Firebase.

Get your debug SHA-1 (run this in your terminal on your own machine):

  On macOS/Linux:
    keytool -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore -storepass android -keypass android

  On Windows:
    keytool -list -v -alias androiddebugkey -keystore %USERPROFILE%\.android\debug.keystore -storepass android -keypass android

Copy the SHA1 value from the output.

Then in Firebase Console:
1. Click the gear icon (Project Settings)
2. Under "Your apps", find the Android app (com.ihsan.aienhancer)
3. Click "Add fingerprint" and paste your SHA-1
4. Click Save
5. Click Authentication in left menu, Sign-in method, click Google, enable it, Save
6. Download the updated google-services.json from Project Settings
7. Replace android/app/google-services.json with the newly downloaded file

---

## STEP 2 — Build the APK

You have two options. Choose whichever is easier for you.

---

### Option A — GitHub Actions (No Local Setup Needed, Recommended)

The file .github/workflows/build_apk.yml is already included in the project.
Every push to your main branch automatically builds and uploads the APK.

How to use:
1. Create a free account at github.com
2. Create a new repository (can be private)
3. Upload this project folder to the repository
4. Go to your repository page, click the "Actions" tab
5. Click the "Build Release APK" workflow
6. Wait ~5 minutes for the build to finish (green checkmark)
7. Scroll down to "Artifacts" and click "IHSAN-AI-Enhancer-APK" to download your APK

That's it! No Flutter installation required on your machine.

---

### Option B — Build Locally on Your Machine

Requirements: Flutter SDK installed (https://flutter.dev/docs/get-started/install)

Run one command from inside the ihsan_ai_enhancer folder:

  On macOS/Linux:
    ./build_local.sh

  On Windows (in Flutter-enabled Command Prompt):
    flutter pub get
    flutter build apk --release

Your APK will be at:
  release_builds/IHSAN_AI_Enhancer_v1.0.0.apk
  (or build/app/outputs/flutter-apk/app-release.apk)

---

### Option C — Install Flutter Then Build

1. Download Flutter: https://flutter.dev/docs/get-started/install
2. Open terminal, navigate to the ihsan_ai_enhancer folder
3. Run: flutter pub get
4. Run: flutter build apk --release
5. Find APK at: build/app/outputs/flutter-apk/app-release.apk

---

## STEP 3 — Install APK on Your Android Device

Method 1 (USB cable + ADB):
  adb install IHSAN_AI_Enhancer_v1.0.0.apk

Method 2 (no USB):
  Copy the APK file to your Android phone via any file transfer method.
  Open it on the phone and tap Install.
  (Enable "Install from unknown sources" in phone Settings if prompted.)

---

## API Keys (Optional — Fill These In for Real AI Features)

Edit lib/core/constants/app_constants.dart and replace these placeholders:

  static const String replicateApiKey = 'YOUR_REPLICATE_API_KEY';
  static const String removeBgApiKey  = 'YOUR_REMOVE_BG_API_KEY';

Get your keys:
  Replicate (AI enhancement): https://replicate.com — sign up, go to API section
  Remove.bg (background removal): https://www.remove.bg/api — sign up for free tier
