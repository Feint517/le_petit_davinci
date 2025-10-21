# Supabase Authentication Integration Guide

## 🎯 Overview

This document describes the complete Supabase authentication integration between the Flutter client and Node.js backend.

## 📋 What Was Implemented

### 1. **API Configuration** ✅
- Updated base URL to `http://localhost:3000`
- Added all auth endpoints (register, login, logout, refresh tokens, profiles)
- Configured proper HTTP methods and routes

### 2. **Data Models** ✅
Created Freezed models for:
- **Auth Models:**
  - `SupabaseSession` - Session with access/refresh tokens
  - `SupabaseUser` - User data from Supabase
  - `Profile` - User profile with PIN

- **Request Models:**
  - `RegisterRequest` - Registration data
  - `LoginRequest` - Login credentials
  - `RefreshTokenRequest` - Token refresh
  - `ValidateProfilePinRequest` - PIN validation

- **Response Models:**
  - `AuthResponse` - Login/register response
  - `ProfilePinResponse` - PIN validation response
  - `RefreshTokenResponse` - Token refresh response

### 3. **Storage Service** ✅
Enhanced `StorageService` to handle:
- Session tokens (access & refresh)
- User data
- Profiles list
- Selected profile
- Profile token
- Complete auth data cleanup on logout

### 4. **Dio Interceptors** ✅
Created `AuthInterceptor` that:
- Automatically adds Bearer token to requests
- Adds Profile token for profile-protected routes
- Handles 401 errors with automatic token refresh
- Retries failed requests after token refresh

### 5. **Authentication Repository** ✅
Complete rewrite with methods:
- `register()` - Create new account with Supabase
- `loginWithEmailAndPassword()` - Login and get profiles
- `validateProfilePin()` - Validate profile PIN
- `refreshToken()` - Refresh access token
- `logout()` - Logout and clear data
- `getProfiles()` - Fetch user profiles
- Helper methods for auth state

### 6. **Controllers** ✅

**LoginController:**
- Validates credentials
- Calls backend API
- Handles profile navigation
- Auto-selects if only 1 profile

**SignupController:**
- Creates new account
- Handles default profile creation
- Navigates to PIN entry

**PinEntryController:**
- Handles PIN input (4 digits)
- Auto-selects profile if only one exists
- Validates PIN with backend
- Navigates to home on success
- Clears PIN on failure

### 7. **UI Updates** ✅
- Transformed `UserSelectionScreen` into a loading screen
- Auto-navigates to login after 1.5 seconds
- Updated all error messages to French
- Added proper loading states and feedback

## 🔐 Authentication Flow

### Registration Flow:
1. User enters: email, password, firstName, lastName
2. API creates Supabase account + default profile
3. Session tokens saved to storage
4. Navigate to PIN entry → Home

### Login Flow:
1. User enters: email, password
2. API validates and returns session + profiles
3. Session tokens saved to storage
4. **If 1 profile:** Auto-select → PIN entry
5. **If multiple profiles:** Show selection → PIN entry
6. PIN validated → Profile token saved
7. Navigate to Home

### Auto-Refresh Flow:
1. API call returns 401 (unauthorized)
2. Interceptor catches error
3. Calls refresh token endpoint
4. Updates stored tokens
5. Retries original request
6. If refresh fails → logout

## 🧪 Testing Guide

### Prerequisites:
1. ✅ Backend running on `http://localhost:3000`
2. ✅ Supabase configured in backend
3. ✅ Test user created in Supabase

### Test Steps:

#### 1. Test Registration:
```dart
// Navigate to SignupScreen
// Fill in form:
// - First Name: John
// - Last Name: Doe  
// - Email: test@example.com
// - Password: Test1234!
// - Confirm Password: Test1234!
// Click "Create Account"

// Expected:
// ✅ Loading dialog appears
// ✅ Success message: "Compte créé avec succès!"
// ✅ Navigates to PIN entry screen
// ✅ Default profile "John's Profile" created with PIN 0000
```

#### 2. Test Login:
```dart
// Navigate to LoginScreen
// Enter credentials:
// - Email: test@example.com
// - Password: Test1234!
// Click "Connect"

// Expected:
// ✅ Loading dialog appears
// ✅ Success message: "Connexion réussie!"
// ✅ Navigates to PIN entry screen
// ✅ If 1 profile: auto-selected
```

#### 3. Test PIN Entry:
```dart
// On PIN screen
// Enter: 0000 (default PIN)

// Expected:
// ✅ PIN auto-submits after 4 digits
// ✅ Loading dialog appears
// ✅ Success message: "PIN validé avec succès"
// ✅ Navigates to HomeScreen
// ✅ Profile token saved
```

#### 4. Test Wrong PIN:
```dart
// Enter: 1234 (wrong PIN)

// Expected:
// ✅ Error message: "PIN incorrect"
// ✅ PIN clears automatically
// ✅ Stays on PIN screen
```

#### 5. Test Token Refresh:
```dart
// Wait for access token to expire (~1 hour)
// Make any API call

// Expected:
// ✅ Interceptor catches 401
// ✅ Automatically refreshes token
// ✅ Request retries successfully
// ✅ User stays logged in
```

#### 6. Test Logout:
```dart
// Call authRepo.logout()

// Expected:
// ✅ All local data cleared
// ✅ Navigates to LoginScreen
// ✅ Backend session invalidated
```

### Debug Tips:

**Check Dio Logs:**
```dart
// ApiService has PrettyDioLogger enabled
// Check console for:
// - Request headers (Bearer token)
// - Request body
// - Response data
// - Errors
```

**Check Storage:**
```dart
// In code:
final storage = StorageService.instance;
print('Access Token: ${storage.getAccessToken()}');
print('Refresh Token: ${storage.getRefreshToken()}');
print('Profiles: ${storage.getProfiles()}');
print('Selected Profile: ${storage.getSelectedProfile()}');
```

**Common Issues:**

1. **Connection Refused:**
   - Ensure backend is running on port 3000
   - Check `http://localhost:3000/auth/health`

2. **401 Errors:**
   - Check if access token is being sent
   - Verify Supabase config in backend

3. **Model Parsing Errors:**
   - Ensure backend response matches model structure
   - Check Freezed generation completed

## 📁 File Structure

```
lib/
├── core/
│   └── network/
│       └── auth_interceptor.dart        # Token injection & refresh
├── data/
│   ├── models/
│   │   ├── auth/
│   │   │   ├── profile.dart             # Profile model
│   │   │   ├── supabase_session.dart    # Session model
│   │   │   └── supabase_user.dart       # User model
│   │   ├── requests/
│   │   │   ├── register_request.dart
│   │   │   ├── login_request.dart
│   │   │   ├── refresh_token_request.dart
│   │   │   └── validate_profile_pin_request.dart
│   │   └── responses/
│   │       ├── auth_response.dart
│   │       ├── profile_pin_response.dart
│   │       └── refresh_token_response.dart
│   ├── network/
│   │   └── api_routes.dart              # API endpoints
│   └── repositories/
│       └── authentication_repository.dart
├── features/
│   └── authentication/
│       ├── controllers/
│       │   ├── login_controller.dart
│       │   ├── signup_controller.dart
│       │   └── pin_entry_controller.dart
│       └── views/
│           ├── login.dart
│           ├── signup.dart
│           ├── pin.dart
│           └── user_selection.dart       # Now a loading screen
└── services/
    ├── api_service.dart                 # Dio configuration
    └── storage_service.dart             # Local storage

```

## 🔧 Configuration

### Backend (.env):
```env
PORT=3000
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_anon_key
ACCESS_TOKEN_SECRET=your_secret
```

### Flutter:
```dart
// api_routes.dart
static const String baseUrl = "http://localhost:3000";
```

## 🚀 Next Steps

1. **Test with real backend** - Start Node.js server and test all flows
2. **Handle edge cases** - Network errors, expired sessions, etc.
3. **Add profile selection UI** - For users with multiple profiles
4. **Implement password reset** - Supabase password recovery
5. **Add OAuth flows** - Google, Facebook, Microsoft login
6. **Production deployment** - Update baseUrl for production

## 📝 Notes

- **PIN Security:** Default PIN is `0000` - users should change it
- **Token Expiry:** Access token expires in 1 hour, refresh token in 7 days
- **Auto-Select:** If only 1 profile exists, it's auto-selected
- **Error Handling:** All errors show user-friendly French messages
- **Loading States:** All API calls show loading dialogs
- **Storage:** Using GetStorage (consider flutter_secure_storage for production)

## ✅ Testing Checklist

- [ ] Backend running on localhost:3000
- [ ] Registration creates account + default profile
- [ ] Login returns session + profiles
- [ ] PIN validation works with correct PIN
- [ ] PIN validation fails with wrong PIN
- [ ] Token refresh works automatically
- [ ] Logout clears all data
- [ ] App redirects properly on startup
- [ ] Loading states show correctly
- [ ] Error messages display properly
- [ ] Auto-select works with 1 profile

---

**Integration Status:** ✅ Complete and Ready for Testing

**Date:** October 16, 2025
**Author:** AI Assistant

