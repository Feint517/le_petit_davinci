// ignore_for_file: constant_identifier_names
class AppRoutes {
  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String login = '/login';
  static const String userSelection = '/user-selection';
  static const String parentOnboarding = '/parent-onboarding';
  static const String childSetup = '/child-setup';
  static const String forgotPassword = '/forgot-password';
  static const String pin = '/pin';
}

// Alias for easier access (following GetX convention)
class Routes {
  static const String SPLASH = AppRoutes.splash;
  static const String WELCOME = AppRoutes.welcome;
  static const String HOME = AppRoutes.home;
  static const String LOGIN = AppRoutes.login;
  static const String USER_SELECTION = AppRoutes.userSelection;
  static const String PARENT_ONBOARDING = AppRoutes.parentOnboarding;
  static const String CHILD_SETUP = AppRoutes.childSetup;
  static const String FORGOT_PASSWORD = AppRoutes.forgotPassword;
  static const String PIN = AppRoutes.pin;
}