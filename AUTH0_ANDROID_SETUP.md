# Auth0 Android Setup Guide

## ✅ Fixed Issues
The Android manifest placeholder errors have been resolved by adding the required Auth0 configuration.

## 🔧 Configuration Steps

### 1. Update Auth0 Configuration
Edit `lib/core/constants/auth0_config.dart` and replace the placeholder values:

```dart
class Auth0Config {
  // Replace these with your actual Auth0 values
  static const String domain = 'your-actual-domain.auth0.com';
  static const String clientId = 'your-actual-client-id';
  static const String audience = 'your-actual-api-audience';
  
  // Your backend URL
  static const String baseUrl = 'https://your-backend-url.com';
  
  // ... rest of the configuration
}
```

### 2. Update Android Build Configuration
Edit `android/app/build.gradle.kts` and replace the placeholder values:

```kotlin
defaultConfig {
    // ... other configuration
    
    // Auth0 Configuration - Replace with your actual Auth0 values
    manifestPlaceholders["auth0Domain"] = "your-actual-domain.auth0.com"
    manifestPlaceholders["auth0Scheme"] = "com.example.le_petit_davinci"
}
```

### 3. Auth0 Dashboard Configuration

#### Step 1: Create Auth0 Application
1. Go to [Auth0 Dashboard](https://manage.auth0.com/)
2. Navigate to **Applications** > **Applications**
3. Click **Create Application**
4. Choose **Native** as the application type
5. Name it "Le Petit Davinci Mobile"

#### Step 2: Configure Application Settings
In your Auth0 application settings, add these URLs:

**Allowed Callback URLs:**
```
com.example.le_petit_davinci://your-actual-domain.auth0.com/android/com.example.le_petit_davinci/callback
```

**Allowed Logout URLs:**
```
com.example.le_petit_davinci://your-actual-domain.auth0.com/android/com.example.le_petit_davinci/callback
```

**Allowed Origins (CORS):**
```
com.example.le_petit_davinci://your-actual-domain.auth0.com
```

#### Step 3: Configure Social Connections
1. Go to **Authentication** > **Social**
2. Enable the connections you want:
   - Google
   - Facebook  
   - Microsoft Account

### 4. Install Auth0 Flutter Package

Add the Auth0 Flutter package to your `pubspec.yaml`:

```yaml
dependencies:
  auth0_flutter: ^2.0.0
```

Then run:
```bash
flutter pub get
```

### 5. Update Auth0 Service

Once you have the `auth0_flutter` package installed, update `lib/core/services/auth0_service.dart`:

```dart
// Uncomment this line:
import 'package:auth0_flutter/auth0_flutter.dart';

// Remove the placeholder classes and use the real Auth0 classes
```

### 6. Test the Configuration

Run your Flutter app:
```bash
flutter run
```

## 🔍 Troubleshooting

### If you still get manifest errors:
1. Clean your project:
   ```bash
   flutter clean
   flutter pub get
   cd android && ./gradlew clean && cd ..
   ```

2. Rebuild:
   ```bash
   flutter run
   ```

### If Auth0 login doesn't work:
1. Check that your Auth0 domain and client ID are correct
2. Verify the callback URLs in your Auth0 dashboard
3. Make sure the package name matches in both Auth0 dashboard and your app

## 📱 Package Name Configuration

Your current package name is: `com.example.le_petit_davinci`

If you want to change it:
1. Update `android/app/build.gradle.kts`:
   ```kotlin
   applicationId = "your.new.package.name"
   ```

2. Update the Auth0 scheme in the same file:
   ```kotlin
   manifestPlaceholders["auth0Scheme"] = "your.new.package.name"
   ```

3. Update the callback URLs in your Auth0 dashboard accordingly

## 🚀 Next Steps

1. Replace all placeholder values with your actual Auth0 credentials
2. Install the `auth0_flutter` package
3. Update the Auth0 service to use the real package
4. Test the authentication flow

The build errors should now be resolved! 🎉

