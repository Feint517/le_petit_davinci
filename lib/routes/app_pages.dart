import 'package:get/get.dart';
import 'package:le_petit_davinci/features/authentication/auth_feature.dart';
import 'package:le_petit_davinci/features/home/home_feature.dart';
import 'package:le_petit_davinci/features/splash/splash_feature.dart';
import 'package:le_petit_davinci/features/welcome/welcome_feature.dart';
import 'package:le_petit_davinci/features/onboarding/views/user_selection_page.dart';
import 'package:le_petit_davinci/features/onboarding/bindings/user_selection_binding.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

/// App pages configuration
class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.welcome,
      page: () => WelcomeScreen(
        onContinue: () => Get.offAndToNamed(AppRoutes.userSelection),
      ),
      binding: WelcomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.userSelection,
      page: () => const UserSelectionPage(),
      binding: UserSelectionBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}