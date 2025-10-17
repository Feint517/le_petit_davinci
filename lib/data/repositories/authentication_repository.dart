import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/data/models/auth/profile.dart';
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
import 'package:le_petit_davinci/services/api_service.dart';
import 'package:le_petit_davinci/services/storage_service.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final _dio = ApiService().dio;
  final _storage = StorageService.instance;

  @override
  void onReady() async {
    await Future.delayed(const Duration(seconds: 2));
    screenRedirect();
  }

  void screenRedirect() async {
    final isLoggedIn = _storage.isLoggedIn();

    if (kDebugMode) {
      print('[Auth] isLoggedIn => $isLoggedIn');
    }

    if (isLoggedIn) {
      // Check if user has selected a profile
      final selectedProfile = _storage.getSelectedProfile();
      final profileToken = _storage.getProfileToken();

      if (selectedProfile != null && profileToken != null) {
        // User is fully authenticated with profile
        Get.offAll(() => const HomeScreen());
      } else {
        // User is logged in but needs to select profile
        // This will be handled by the login flow
        Get.offAll(() => const LoginScreen());
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

  /// Validate profile PIN and get profile token
  Future<ProfilePinResponse> validateProfilePin({
    required String profileId,
    required String pin,
  }) async {
    try {
      final response = await _dio.post(
        ApiRoutes.validateProfilePin,
        data:
            ValidateProfilePinRequest(profileId: profileId, pin: pin).toJson(),
      );

      if (response.statusCode == 200) {
        final pinResponse = ProfilePinResponse.fromJson(response.data);

        // Save profile token if validation was successful
        if (pinResponse.success && pinResponse.data != null) {
          await _storage.saveProfileToken(pinResponse.data!.profileToken);
          await _storage.saveSelectedProfile(pinResponse.data!.profile);
        }

        return pinResponse;
      } else {
        throw Exception(
          'PIN validation failed with status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? 'PIN validation failed: ${e.message}',
      );
    } catch (e) {
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
      await _dio.post(ApiRoutes.logout);
    } catch (e) {
      print('Logout API error: $e');
      // Continue with local logout even if API fails
    } finally {
      // Clear all local auth data
      await _storage.clearAuthData();
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
