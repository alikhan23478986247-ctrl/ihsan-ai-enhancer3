#!/usr/bin/env bash
# ============================================================
#  IHSAN AI Enhancer — Local APK Build Script
#  Run this on your own machine (macOS / Linux / WSL)
#  Requirements: Flutter SDK installed, Android SDK installed
# ============================================================
set -e

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$PROJECT_DIR"

echo "=================================================="
echo " IHSAN AI Enhancer — Building Release APK"
echo "=================================================="

# 1. Verify Flutter
if ! command -v flutter &>/dev/null; then
  echo "ERROR: Flutter not found. Install from https://flutter.dev/docs/get-started/install"
  exit 1
fi
flutter --version

# 2. Install dependencies
echo ""
echo "[ Step 1/3 ] Installing dependencies..."
flutter pub get

# 3. Build APK
echo ""
echo "[ Step 2/3 ] Building release APK..."
flutter build apk --release

# 4. Copy to project root for easy access
echo ""
echo "[ Step 3/3 ] Copying APK to project root..."
mkdir -p release_builds
cp build/app/outputs/flutter-apk/app-release.apk \
   release_builds/IHSAN_AI_Enhancer_v1.0.0.apk

echo ""
echo "=================================================="
echo " ✅ BUILD SUCCESSFUL!"
echo " APK: release_builds/IHSAN_AI_Enhancer_v1.0.0.apk"
echo "=================================================="
echo ""
echo "Install on a connected Android device:"
echo "  adb install release_builds/IHSAN_AI_Enhancer_v1.0.0.apk"
