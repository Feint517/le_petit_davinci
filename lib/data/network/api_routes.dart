class ApiRoutes {
  // Development URLs
  // static const String baseUrl = "http://localhost:3000"; // Local development
  static const String baseUrl = "http://172.20.10.12:3000"; // Android emulator

  // Production URL
  // static const String baseUrl = "https://lepetitdavinci-api.vercel.app";

  //* Health and Status routes
  static const String ping = "/api/ping";
  static const String health = "/api/health";
  static const String status = "/api/status";

  //* Authentication routes
  static const String authHealth = "/auth/health";
  static const String register = "/auth/register";
  static const String login = "/auth/login";
  static const String logout = "/auth/logout";
  static const String refreshTokens = "/auth/refresh-tokens";
  static const String verifyEmail = "/auth/verify-email";
  static const String resendVerification = "/auth/resend-verification";
  static const String googleLogin = "/auth/google";
  static const String oauthCallback = "/auth/callback";

  //* User Management Routes

  // Profile routes
  static const String profiles = "/auth/profiles";
  static const String validateProfilePin = "/auth/profiles/validate-pin";
  static String profileById(String id) => "/auth/profiles/$id";

  // User routes
  static const String createChildProfile = '/api/child/create';
  static const String fetchChildData = "/api/child/fetch";

  // Security routes
  static const String securityEvents = "/auth/security/events";
}
