import 'package:dio/dio.dart';
import 'package:le_petit_davinci/services/storage_service.dart';
import 'package:le_petit_davinci/data/network/api_routes.dart';
import 'package:le_petit_davinci/data/models/requests/refresh_token_request.dart';
import 'package:le_petit_davinci/data/models/responses/refresh_token_response.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final StorageService _storage = StorageService.instance;

  AuthInterceptor(this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip auth for public routes
    final publicRoutes = [
      ApiRoutes.login,
      ApiRoutes.register,
      ApiRoutes.refreshTokens,
    ];

    final isPublicRoute = publicRoutes.any(
      (route) => options.path.contains(route),
    );

    if (!isPublicRoute) {
      // Add access token to header
      final accessToken = _storage.getAccessToken();
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }

      // Add profile token if available (for profile-protected routes)
      final profileToken = _storage.getProfileToken();
      if (profileToken != null) {
        options.headers['X-Profile-Token'] = profileToken;
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 (Unauthorized) - try to refresh token
    if (err.response?.statusCode == 401) {
      final refreshToken = _storage.getRefreshToken();

      if (refreshToken != null) {
        try {
          // Try to refresh the token
          final newSession = await _refreshToken(refreshToken);

          if (newSession != null) {
            // Save new session
            await _storage.saveSession(newSession);

            // Retry the original request with new token
            final options = err.requestOptions;
            options.headers['Authorization'] =
                'Bearer ${newSession.accessToken}';

            final response = await _dio.fetch(options);
            return handler.resolve(response);
          }
        } catch (e) {
          // Refresh failed - clear auth data and redirect to login
          await _storage.clearAuthData();
          // The app will handle navigation based on isLoggedIn status
        }
      }
    }

    handler.next(err);
  }

  Future<dynamic> _refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        ApiRoutes.refreshTokens,
        data: RefreshTokenRequest(refreshToken: refreshToken).toJson(),
      );

      if (response.statusCode == 200) {
        final refreshResponse = RefreshTokenResponse.fromJson(response.data);
        if (refreshResponse.success && refreshResponse.data != null) {
          return refreshResponse.data!.session;
        }
      }
      return null;
    } catch (e) {
      print('🔴 Token refresh error: $e');
      return null;
    }
  }
}
