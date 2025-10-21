class AuthConfig {
  // Frontend-only authentication configuration

  // App configuration
  static const String appName = 'Le Petit Davinci';
  static const String appVersion = '1.0.0';

  // Local storage keys
  static const String isLoggedInKey = 'is_logged_in';
  static const String authTokenKey = 'auth_token';
  static const String userEmailKey = 'user_email';
  static const String userNameKey = 'user_name';
  static const String userPictureKey = 'user_picture';

  // Social login providers (for frontend-only implementation)
  static const List<String> socialProviders = [
    'google',
    'facebook',
    'microsoft',
  ];

  // User preferences
  static const List<String> supportedLanguages = ['en', 'fr', 'es'];
}
