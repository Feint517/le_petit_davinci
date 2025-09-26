# 🔐 How to Get Your Auth0 Client Secret

## **Step 1: Go to Auth0 Dashboard**
1. Visit [Auth0 Dashboard](https://manage.auth0.com/)
2. Sign in to your account

## **Step 2: Navigate to Your Application**
1. Go to **Applications** → **Applications**
2. Find your application: **le_petit_davinci** (or whatever you named it)
3. Click on the application name

## **Step 3: Get Client Secret**
1. In your application settings, you'll see:
   - **Domain**: `petit-davinci.us.auth0.com` ✅ (you already have this)
   - **Client ID**: `LhI5BCHCZjhURXGbRmQGLdA9yb05qRYx` ✅ (you already have this)
   - **Client Secret**: `[HIDDEN]` ⚠️ (you need to reveal this)

2. Click on the **eye icon** or **"Show"** button next to the Client Secret
3. Copy the client secret value

## **Step 4: Update Your Auth0Config**
Replace `'your-client-secret'` in `lib/core/constants/auth0_config.dart`:

```dart
class Auth0Config {
  static const String domain = 'petit-davinci.us.auth0.com'; // ✅ Already set
  static const String clientId = 'LhI5BCHCZjhURXGbRmQGLdA9yb05qRYx'; // ✅ Already set
  static const String clientSecret = 'YOUR_ACTUAL_CLIENT_SECRET_HERE'; // ⚠️ Replace this
  static const String audience = 'your-api-audience'; // ⚠️ Optional - you can leave as is
}
```

## **Step 5: Configure Callback URLs**
In your Auth0 application settings, add:
- **Allowed Callback URLs**: `com.example.le_petit_davinci://login-callback`
- **Allowed Logout URLs**: `com.example.le_petit_davinci://login-callback`

## **Step 6: Enable Social Connections**
1. Go to **Authentication** → **Social**
2. Enable **Google**, **Facebook**, **Microsoft**
3. Configure each with their respective credentials

## **🎯 Once you update the client secret, your social login will work!**

The client secret is required for Auth0 to properly authenticate your application. It's like a password that proves your app is legitimate. 🔐

