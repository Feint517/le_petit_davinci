import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/data/models/auth/profile.dart';
import 'package:le_petit_davinci/data/models/auth/supabase_session.dart';
import 'package:le_petit_davinci/data/models/auth/supabase_user.dart';
import 'package:le_petit_davinci/data/models/requests/login_request.dart';
import 'package:le_petit_davinci/data/models/requests/register_request.dart';
import 'package:le_petit_davinci/data/models/requests/refresh_token_request.dart';
import 'package:le_petit_davinci/data/models/requests/validate_profile_pin_request.dart';
import 'package:le_petit_davinci/data/models/requests/verify_email_request.dart';
import 'package:le_petit_davinci/data/models/requests/resend_verification_request.dart';
import 'package:le_petit_davinci/data/models/responses/auth_response.dart';
import 'package:le_petit_davinci/data/models/responses/profile_pin_response.dart';
import 'package:le_petit_davinci/data/models/responses/refresh_token_response.dart';
import 'package:le_petit_davinci/data/models/responses/verification_response.dart';
import 'package:le_petit_davinci/data/network/api_routes.dart';
import 'package:le_petit_davinci/features/authentication/views/login.dart';
import 'package:le_petit_davinci/features/home/views/home.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';
import 'package:le_petit_davinci/services/api_service.dart';
import 'package:le_petit_davinci/services/storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _dio = ApiService().dio;
  final _storage = StorageService.instance;

  // Flag to prevent multiple redirects
  bool _hasRedirected = false;

  @override
  void onReady() async {
    await Future.delayed(const Duration(seconds: 2));
    // Only redirect on initial app launch
    if (!_hasRedirected) {
      screenRedirect();
    }
  }

  void screenRedirect() async {
    // Prevent multiple redirects
    if (_hasRedirected) return;
    _hasRedirected = true;
    final isLoggedIn = _storage.isLoggedIn();
    final selectedProfile = _storage.getSelectedProfile();
    final profileToken = _storage.getProfileToken();

    if (kDebugMode) {
      print('[Auth] isLoggedIn => $isLoggedIn');
      print('[Auth] selectedProfile => ${selectedProfile?.profileName}');
      print(
        '[Auth] profileToken => ${profileToken != null ? 'exists' : 'null'}',
      );
    }

    if (isLoggedIn && selectedProfile != null && profileToken != null) {
      // User is fully authenticated with profile
      Get.offAll(() => const HomeScreen());
    } else if (isLoggedIn) {
      // User is logged in but needs to select/validate profile
      final profiles = _storage.getProfiles();
      if (profiles != null && profiles.isNotEmpty) {
        // Always show PIN screen, even for single profile
        Get.offAllNamed(
          AppRoutes.pin,
          arguments: {'profiles': profiles, 'autoSelect': false},
        );
      } else {
        Get.offAllNamed(AppRoutes.createProfile);
      }
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  /// Register new user with Supabase
  Future<AuthResponse> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await _dio.post(
        ApiRoutes.register,
        data:
            RegisterRequest(
              email: email,
              password: password,
              firstName: firstName,
              lastName: lastName,
            ).toJson(),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(response.data);

        // Save session if registration was successful
        if (authResponse.success && authResponse.data.session != null) {
          await _storage.saveSession(authResponse.data.session!);

          // Save profiles if available
          if (authResponse.data.profiles != null) {
            await _storage.saveProfiles(authResponse.data.profiles!);
          }
        }

        return authResponse;
      } else {
        throw Exception(
          'Registration failed with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Registration failed: ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Login with email and password
  Future<AuthResponse> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        ApiRoutes.login,
        data: LoginRequest(email: email, password: password).toJson(),
      );

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(response.data);

        // Save session if login was successful
        if (authResponse.success && authResponse.data.session != null) {
          await _storage.saveSession(authResponse.data.session!);

          // Save profiles if available
          if (authResponse.data.profiles != null) {
            await _storage.saveProfiles(authResponse.data.profiles!);
          }
        }

        return authResponse;
      } else {
        throw Exception(
          'Login failed with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Login failed: ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Login with Google OAuth (opens external browser)
  Future<AuthResponse> loginWithGoogle() async {
    try {
      if (kDebugMode) {
        print('🔐 [Auth] Starting Google OAuth (external browser)');
      }

      // Initiate OAuth flow with Supabase (opens browser)
      final response = await supabase.Supabase.instance.client.auth
          .signInWithOAuth(
            supabase.OAuthProvider.google,
            redirectTo: 'io.supabase.lepetitdavinci://login-callback',
            authScreenLaunchMode: supabase.LaunchMode.externalApplication,
          );

      if (!response) {
        throw Exception('Failed to initiate OAuth');
      }

      if (kDebugMode) {
        print('🔐 [Auth] OAuth initiated, waiting for callback via deep link');
      }

      // Wait for auth state change when user returns to app
      final authState = await supabase
          .Supabase
          .instance
          .client
          .auth
          .onAuthStateChange
          .firstWhere(
            (event) => event.event == supabase.AuthChangeEvent.signedIn,
          )
          .timeout(
            const Duration(seconds: 120),
            onTimeout:
                () =>
                    throw Exception('OAuth timeout - user may have cancelled'),
          );

      final session = authState.session;
      if (session == null) {
        throw Exception('No session returned from OAuth');
      }

      if (kDebugMode) {
        print('🔐 [Auth] OAuth successful, user: ${session.user.email}');
        print('🔐 [Auth] Fetching profiles from backend');
      }

      // Get user's profiles from backend
      final profilesResponse = await _dio.get(
        ApiRoutes.profiles,
        options: Options(
          headers: {'Authorization': 'Bearer ${session.accessToken}'},
        ),
      );

      final profilesData = profilesResponse.data['data'];
      final profiles =
          (profilesData['profiles'] as List?)
              ?.map((p) => Profile.fromJson(p))
              .toList() ??
          [];

      if (kDebugMode) {
        print('🔐 [Auth] Fetched ${profiles.length} profiles');
      }

      // Convert to app models
      final supabaseSession = SupabaseSession(
        accessToken: session.accessToken,
        refreshToken: session.refreshToken ?? '',
        expiresIn: session.expiresIn ?? 3600,
        tokenType: session.tokenType,
        user: SupabaseUser(
          id: session.user.id,
          email: session.user.email ?? '',
          phone: session.user.phone,
          userMetadata: session.user.userMetadata,
          appMetadata: session.user.appMetadata,
          emailConfirmedAt: session.user.emailConfirmedAt,
          phoneConfirmedAt: session.user.phoneConfirmedAt,
          createdAt: session.user.createdAt,
          updatedAt: session.user.updatedAt,
        ),
      );

      // Save to local storage
      await _storage.saveSession(supabaseSession);
      await _storage.saveProfiles(profiles);

      if (kDebugMode) {
        print('🔐 [Auth] Google OAuth complete');
      }

      return AuthResponse(
        success: true,
        message: 'Google authentication successful',
        data: AuthData(
          session: supabaseSession,
          user: supabaseSession.user,
          profiles: profiles,
          profileCount: profiles.length,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print('🔐 [Auth] Google OAuth error: $e');
      }
      throw Exception('Google sign-in failed: $e');
    }
  }

  /// Validate profile PIN and get profile token
  Future<ProfilePinResponse> validateProfilePin({
    required String profileId,
    required String pin,
  }) async {
    try {
      if (kDebugMode) {
        print('🔐 [Repo] Validating PIN for profile: $profileId');
      }

      final response = await _dio.post(
        ApiRoutes.validateProfilePin,
        data:
            ValidateProfilePinRequest(profileId: profileId, pin: pin).toJson(),
      );

      if (response.statusCode == 200) {
        final pinResponse = ProfilePinResponse.fromJson(response.data);

        if (kDebugMode) {
          print('🔐 [Repo] PIN Response success: ${pinResponse.success}');
          print(
            '🔐 [Repo] Profile token exists: ${pinResponse.data?.profileToken != null}',
          );
        }

        // Save profile token if validation was successful
        if (pinResponse.success && pinResponse.data != null) {
          await _storage.saveProfileToken(pinResponse.data!.profileToken);
          await _storage.saveSelectedProfile(pinResponse.data!.profile);

          if (kDebugMode) {
            print('🔐 [Repo] Saved profile token and profile');
            print(
              '🔐 [Repo] Verifying storage - token exists: ${_storage.getProfileToken() != null}',
            );
            print(
              '🔐 [Repo] Verifying storage - profile exists: ${_storage.getSelectedProfile() != null}',
            );
          }
        }

        return pinResponse;
      } else {
        throw Exception(
          'PIN validation failed with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('🔐 [Repo] DioException: ${e.response?.data}');
      }
      throw Exception(
        e.response?.data['message'] ?? 'PIN validation failed: ${e.message}',
      );
    } catch (e) {
      if (kDebugMode) {
        print('🔐 [Repo] Exception: $e');
      }
      throw Exception('Unexpected error: $e');
    }
  }

  /// Refresh access token
  Future<RefreshTokenResponse> refreshToken() async {
    try {
      final refreshToken = _storage.getRefreshToken();

      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }

      final response = await _dio.post(
        ApiRoutes.refreshTokens,
        data: RefreshTokenRequest(refreshToken: refreshToken).toJson(),
      );

      if (response.statusCode == 200) {
        final refreshResponse = RefreshTokenResponse.fromJson(response.data);

        // Save new session
        if (refreshResponse.success && refreshResponse.data != null) {
          await _storage.saveSession(refreshResponse.data!.session);
        }

        return refreshResponse;
      } else {
        throw Exception(
          'Token refresh failed with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Token refresh failed: ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Logout user
  Future<void> logout() async {
    try {
      // Call backend logout if tokens exist
      if (_storage.getAccessToken() != null) {
        await _dio.post(ApiRoutes.logout);
      }
    } catch (e) {
      print('Logout API error: $e');
      // Continue with local logout even if API fails
    } finally {
      // Clear all local auth data
      await _storage.clearAuthData();
      // Reset redirect flag to allow login again
      _hasRedirected = false;
      // Navigate to login screen
      Get.offAll(() => const LoginScreen());
    }
  }

  /// Get user profiles
  Future<List<Profile>> getProfiles() async {
    try {
      final response = await _dio.get(ApiRoutes.profiles);

      if (response.statusCode == 200) {
        final data = response.data['data'];
        final profilesList =
            (data['profiles'] as List)
                .map((json) => Profile.fromJson(json))
                .toList();

        // Save profiles to local storage
        await _storage.saveProfiles(profilesList);

        return profilesList;
      } else {
        throw Exception('Failed to fetch profiles');
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch profiles: ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Create new profile
  Future<Profile> createProfile({
    required String profileName,
    required String pin,
    String? avatar,
  }) async {
    try {
      if (kDebugMode) {
        print('🔐 [Repo] Creating profile: $profileName');
        print(
          '🔐 [Repo] Access token exists: ${_storage.getAccessToken() != null}',
        );
        print('🔐 [Repo] User logged in: ${_storage.isLoggedIn()}');
      }

      final response = await _dio.post(
        ApiRoutes.profiles,
        data: {'profile_name': profileName, 'pin': pin, 'avatar': avatar},
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data['data'];
        final profile = Profile.fromJson(data['profile']);

        // Refresh profiles list
        await getProfiles();

        return profile;
      } else {
        throw Exception('Failed to create profile');
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'Failed to create profile: ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Verify email with code
  Future<VerificationResponse> verifyEmail({
    required String email,
    required String code,
    String? password,
  }) async {
    try {
      final response = await _dio.post(
        ApiRoutes.verifyEmail,
        data:
            VerifyEmailRequest(
              email: email,
              code: code,
              password: password,
            ).toJson(),
      );

      if (response.statusCode == 200) {
        final verificationResponse = VerificationResponse.fromJson(
          response.data,
        );

        // If verification successful and session provided, save it
        if (verificationResponse.success &&
            verificationResponse.data?.session != null) {
          await _storage.saveSession(verificationResponse.data!.session!);
        }

        return verificationResponse;
      } else {
        throw Exception('Email verification failed');
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ??
            'Email verification failed: ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Resend verification code
  Future<VerificationResponse> resendVerificationCode({
    required String email,
  }) async {
    try {
      final response = await _dio.post(
        ApiRoutes.resendVerification,
        data: ResendVerificationRequest(email: email).toJson(),
      );

      if (response.statusCode == 200) {
        return VerificationResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to resend verification code');
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ??
            'Failed to resend verification code: ${e.message}',
      );
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  /// Check if user is authenticated
  bool isAuthenticated() => _storage.isLoggedIn();

  /// Get stored profiles
  List<Profile>? getStoredProfiles() => _storage.getProfiles();

  /// Get selected profile
  Profile? getSelectedProfile() => _storage.getSelectedProfile();
}
