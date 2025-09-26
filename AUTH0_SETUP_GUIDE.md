# Auth0 Integration Setup Guide

This guide will help you complete the Auth0 integration with your Flutter app and backend.

## 1. Backend Configuration

Your backend is already configured with Auth0! Here's what you have:

### Auth0 Endpoints Available:
- `POST /auth/auth0/callback` - Process Auth0 user after authentication
- `GET /auth/profile` - Get user profile (requires Auth0 token)
- `PUT /auth/profile` - Update user profile (requires Auth0 token)
- `POST /auth/profile/sync` - Sync profile with Auth0 (requires Auth0 token)
- `DELETE /auth/account` - Delete account (requires Auth0 token)

### Environment Variables Needed:
```env
AUTH0_DOMAIN=your-domain.auth0.com
AUTH0_CLIENT_ID=your-client-id
AUTH0_CLIENT_SECRET=your-client-secret
AUTH0_AUDIENCE=your-api-audience
```

## 2. Flutter Configuration

### Step 1: Update Auth0 Configuration
Edit `lib/core/constants/auth0_config.dart`:

```dart
class Auth0Config {
  // Replace with your actual Auth0 values
  static const String domain = 'your-domain.auth0.com';
  static const String clientId = 'your-auth0-client-id';
  static const String audience = 'your-api-audience';
  
  // Replace with your backend URL
  static const String baseUrl = 'https://your-backend-url.com';
  
  // Social connections (already configured)
  static const List<String> socialConnections = [
    'google-oauth2',
    'facebook',
    'windowslive',
  ];
  
  // Scopes (already configured)
  static const List<String> scopes = [
    'openid',
    'profile',
    'email',
    'offline_access',
  ];
}
```

### Step 2: Install Dependencies
Run this command in your Flutter project:
```bash
flutter pub get
```

### Step 3: Configure Auth0 Dashboard

1. **Go to your Auth0 Dashboard**
2. **Applications > Your App > Settings**
3. **Add these URLs:**
   - Allowed Callback URLs: `https://your-domain.auth0.com/android/{package-name}/callback`
   - Allowed Logout URLs: `https://your-domain.auth0.com/android/{package-name}/logout`
   - Allowed Web Origins: `https://your-domain.auth0.com`

4. **Enable Social Connections:**
   - Go to Authentication > Social
   - Enable Google, Facebook, Microsoft
   - Configure each with their respective credentials

### Step 4: Update Android Configuration

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<activity
    android:name="com.auth0.android.provider.RedirectActivity"
    android:exported="true"
    android:launchMode="singleTask">
    <intent-filter>
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="https" android:host="your-domain.auth0.com" />
    </intent-filter>
</activity>
```

### Step 5: Update iOS Configuration

Add to `ios/Runner/Info.plist`:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>auth0</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>https://your-domain.auth0.com</string>
        </array>
    </dict>
</array>
```

## 3. Usage Examples

### Basic Login Flow:
```dart
// In your login screen
final auth0Controller = Get.find<Auth0Controller>();

// Login with Google
await auth0Controller.loginWithGoogle();

// Login with Facebook
await auth0Controller.loginWithFacebook();

// Login with Microsoft
await auth0Controller.loginWithMicrosoft();

// Universal Auth0 login
await auth0Controller.login();
```

### Check Authentication Status:
```dart
final auth0Controller = Get.find<Auth0Controller>();

if (auth0Controller.isLoggedIn.value) {
  // User is logged in
  print('User: ${auth0Controller.userName.value}');
  print('Email: ${auth0Controller.userEmail.value}');
} else {
  // User is not logged in
}
```

### Get User Profile:
```dart
final profile = await auth0Controller.getUserProfile();
if (profile != null) {
  print('Profile: $profile');
}
```

### Logout:
```dart
await auth0Controller.logout();
```

## 4. Navigation Setup

Add these routes to your app:

```dart
// In your routes file
GetPage(
  name: '/auth0-login',
  page: () => const Auth0LoginView(),
  binding: Auth0Binding(),
),
GetPage(
  name: '/enhanced-login',
  page: () => const EnhancedLoginScreen(),
  binding: Auth0Binding(),
),
GetPage(
  name: '/profile',
  page: () => const Auth0ProfileView(),
  binding: Auth0Binding(),
),
```

## 5. Testing

1. **Test Social Logins:**
   - Google: Should open Google OAuth
   - Facebook: Should open Facebook OAuth
   - Microsoft: Should open Microsoft OAuth

2. **Test Universal Login:**
   - Should open Auth0 Universal Login page
   - Should allow email/password login
   - Should allow social logins

3. **Test Backend Integration:**
   - Check if user data is synced to your backend
   - Verify profile endpoints work
   - Test logout functionality

## 6. Troubleshooting

### Common Issues:

1. **"Invalid redirect URI"**
   - Check your Auth0 dashboard callback URLs
   - Ensure package name matches

2. **"Invalid audience"**
   - Verify AUTH0_AUDIENCE in backend
   - Check Auth0Config.audience in Flutter

3. **"Token verification failed"**
   - Check AUTH0_DOMAIN configuration
   - Verify JWT token format

4. **Social logins not working**
   - Enable social connections in Auth0 dashboard
   - Configure OAuth apps (Google, Facebook, Microsoft)

### Debug Tips:

1. **Enable logging:**
   ```dart
   // Add to your main.dart
   Auth0Service.instance.initialize();
   ```

2. **Check network requests:**
   - Use browser dev tools
   - Check Flutter debug console

3. **Verify tokens:**
   ```dart
   final token = Auth0Service.instance.accessToken;
   print('Access Token: $token');
   ```

## 7. Security Considerations

1. **Never commit sensitive data:**
   - Use environment variables
   - Keep client secrets secure

2. **Validate tokens:**
   - Always verify JWT tokens on backend
   - Check token expiration

3. **Handle errors gracefully:**
   - Show user-friendly error messages
   - Implement retry mechanisms

## 8. Next Steps

1. **Customize UI:**
   - Update colors and styling
   - Add your branding

2. **Add features:**
   - Profile editing
   - Account linking
   - Multi-factor authentication

3. **Monitor usage:**
   - Set up Auth0 analytics
   - Track user engagement

## Support

- Auth0 Documentation: https://auth0.com/docs
- Flutter Auth0 SDK: https://pub.dev/packages/auth0_flutter
- Your Backend API: Check your backend routes for available endpoints
