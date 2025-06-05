import 'package:get/get.dart';
import 'package:le_petit_davinci/features/authentication/auth_feature.dart';
import 'package:le_petit_davinci/features/authentication/bindings/auth_binding.dart';
import 'package:le_petit_davinci/features/authentication/views/error_screen.dart';
import 'package:le_petit_davinci/features/authentication/views/goodmorning_screen.dart';
import 'package:le_petit_davinci/features/authentication/views/pin_screen.dart';
import 'package:le_petit_davinci/features/authentication/views/user_selection_screen.dart';
import 'package:le_petit_davinci/features/authentication/views/welcome_screen.dart';
import 'package:le_petit_davinci/features/english/view/english_map_screen.dart';
import 'package:le_petit_davinci/features/french/view/french_map_screen.dart';
import 'package:le_petit_davinci/features/home/bindings/home_binding.dart';
import 'package:le_petit_davinci/features/home/home_feature.dart';
import 'package:le_petit_davinci/features/splash/splash_feature.dart';
import 'package:le_petit_davinci/features/onboarding/views/questions_intro_screen.dart';
import 'package:le_petit_davinci/features/authentication/views/question_screen.dart';
import 'package:le_petit_davinci/features/authentication/views/question_finish_screen.dart';
import 'package:le_petit_davinci/features/authentication/views/intro_screen.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class AppPages {
  static final List<GetPage> routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.welcome,
      page:
          () => WelcomeScreen(
            onContinue: () => Get.offAndToNamed(AppRoutes.intro),
          ),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.intro,
      page: () => const IntroScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.goodMorning,
      page: () => const GoodMorningScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.error,
      page: () => const ErrorScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      transition: Transition.cupertino,
      binding: HomeBinding(),
      children: [
        GetPage(
          name: AppRoutes.frenchMap,
          page: () => const FrenchMapScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: AppRoutes.englishMap,
          page: () => const EnglishMapScreen(),
          transition: Transition.rightToLeft,
        ),
      ],
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.userSelection,
      page: () => const UserSelectionPage(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.pin,
      page: () => const PinEntryPage(),
      transition: Transition.cupertino,
    ),
    // GetPage(
    //   name: AppRoutes.questionsIntro,
    //   page: () => const QuestionsIntroScreen(),
    //   transition: Transition.rightToLeft,
    // ),
    GetPage(
      name: AppRoutes.question,
      page: () => const QuestionScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.questionFinish,
      page: () => const WelcomeStatusScreen(),
      transition: Transition.fadeIn,
    ),
  ];
}
