class ApiRoutes {
  static const String baseUrl = "http://localhost:3000";

  // Authentication routes
  static const String register = "/auth/register";
  static const String login = "/auth/login";
  static const String logout = "/auth/logout";
  static const String refreshTokens = "/auth/refresh-tokens";
  static const String verifyEmail = "/auth/verify-email";
  static const String resendVerification = "/auth/resend-verification";
  static const String googleLogin = "/auth/google";
  static const String oauthCallback = "/auth/callback";

  // Profile routes
  static const String profiles = "/auth/profiles";
  static const String validateProfilePin = "/auth/profiles/validate-pin";
  static String profileById(String id) => "/auth/profiles/$id";

  // User routes
  static const String createChildProfile = '/child/create';
  static const String fetchChildData = "/child/fetch";

  // Security routes
  static const String securityEvents = "/auth/security/events";
}
