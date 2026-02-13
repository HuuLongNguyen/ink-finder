# 🚀 InkFinder: Production Deployment Plan

This plan outlines the steps required to prepare, build, and submit **InkFinder** to the Apple App Store and Google Play Store.

---

## 🛠️ Phase 1: General Preparation
Essential branding and configuration steps for both platforms.

### 1.1 Branding Assets
- [ ] **App Icons**: Generate using `flutter_launcher_icons`.
    - Required: High-res logo (1024x1024).
- [ ] **Splash Screens**: Generate using `flutter_native_splash`.
- [ ] **App Name**: Confirm final localized name (InkFinder).

### 1.2 App IDs & Metadata
- [ ] **Bundle ID**: `com.inkfinder.app` (Confirm uniqueness).
- [ ] **Metadata**: Prepare descriptions (EN/VI), keywords, and support URL.
- [ ] **Privacy Policy**: Host a policy URL (required for both stores).

---

## 🤖 Phase 2: Google Play Store (Android)
Steps to generate a signed `.aab` (Android App Bundle).

### 2.1 Sign the App
- [ ] **Generate KeyStore**:
  ```bash
  keytool -genkey -v -keystore ~/inkfinder-release.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias inkfinder
  ```
- [ ] **Configure `android/key.properties`**: Link to the keystore.
- [ ] **Update `android/app/build.gradle`**: 
    - Set `signingConfigs` to use the release key.
    - Update `versionCode` and `versionName`.

### 2.2 Build & Upload
- [ ] **Build Bundle**: `flutter build appbundle --release`
- [ ] **Google Play Console**:
    - Create a new app project.
    - Set up "Internal Testing" track first.
    - Complete the "Initial Setup" checklist (Store listing, content rating, etc.).

---

## 🍎 Phase 3: Apple App Store (iOS)
Steps to archive and upload via Xcode.

### 3.1 Apple Developer Portal
- [ ] **App ID**: Create an explicit App ID with `com.inkfinder.app`.
- [ ] **Certificates**: Generate "Apple Distribution" certificate.
- [ ] **Provisioning Profile**: Create "App Store" distribution profile.

### 3.2 Xcode Configuration
- [ ] **Signing & Capabilities**: Select the correct Team and Profile.
- [ ] **Version/Build**: Update `1.0.0` and unique build number.
- [ ] **Runner.entitlements**: Ensure Map/Zalo permissions are included if needed.

### 3.3 Archive & Upload
- [ ] **Build iOS**: `flutter build ios --release`
- [ ] **Archive**: Open `ios/Runner.xcworkspace` in Xcode -> Product -> Archive.
- [ ] **Distribute**: Upload to App Store Connect.
- [ ] **TestFlight**: Distribute to internal testers for final verification.

---

## 📋 Phase 4: Submission Checklist
Final tasks before clicking "Submit for Review".

- [ ] **Screenshots**: 
    - Android: 2-8 images.
    - iOS: 6.5" and 5.5" (and iPad if supported).
- [ ] **App Access**: Provide a test account (Phone/OTP mock or real) for Apple/Google reviewers.
- [ ] **Age Rating**: Complete questionnaires for tattoo-related content (usually 12+ or 17+).
- [ ] **Store Listing**: Vietnamese and English translations.

---

## 🏁 Timeline Estimate
- **Preparation**: 1-2 days
- **Review (Android)**: 1-4 days
- **Review (Apple)**: 1-3 days
- **Total**: ~1 week for initial launch.
