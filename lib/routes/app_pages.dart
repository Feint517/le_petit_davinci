import 'package:get/get.dart';
import 'package:le_petit_davinci/features/authentication/auth_feature.dart';
import 'package:le_petit_davinci/features/authentication/bindings/auth_binding.dart';
import 'package:le_petit_davinci/features/authentication/views/pin_page.dart';
import 'package:le_petit_davinci/features/authentication/views/user_selection.dart';
import 'package:le_petit_davinci/features/authentication/views/welcome_screen.dart';
import 'package:le_petit_davinci/features/home/home_feature.dart';
import 'package:le_petit_davinci/features/splash/splash_feature.dart';
import 'package:le_petit_davinci/features/onboarding/views/questions_intro_screen.dart';
import 'package:le_petit_davinci/features/questions/views/question_screen.dart';
import 'package:le_petit_davinci/features/questions/views/question_two_screen.dart';
import 'package:le_petit_davinci/features/questions/views/question_three_screen.dart';
import 'package:le_petit_davinci/features/questions/views/question_four_screen.dart';
import 'package:le_petit_davinci/features/questions/views/question_five_screen.dart';
import 'package:le_petit_davinci/features/home/views/welcome_status_screen.dart';
import 'package:le_petit_davinci/features/home/views/intro_screen.dart';
import 'package:le_petit_davinci/features/home/bindings/welcome_status_binding.dart';
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
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.pin,
      page: () => const PinEntryPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.questionsIntro,
      page: () => const QuestionsIntroScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.question,
      page: () => const QuestionScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.questionTwo,
      page: () => const QuestionTwoScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.questionThree,
      page: () => const QuestionThreeScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.questionFour,
      page: () => const QuestionFourScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.questionFive,
      page: () => const QuestionFiveScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.welcomeStatus,
      page: () => const WelcomeStatusScreen(),
      binding: WelcomeStatusBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}
