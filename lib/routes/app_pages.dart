import 'package:get/get.dart';
import 'package:le_petit_davinci/features/authentication/bindings/auth_binding.dart';
import 'package:le_petit_davinci/features/authentication/views/error.dart';
import 'package:le_petit_davinci/features/authentication/views/goodmorning.dart';
import 'package:le_petit_davinci/features/authentication/views/login.dart';
import 'package:le_petit_davinci/features/authentication/views/pin.dart';
import 'package:le_petit_davinci/features/authentication/views/user_selection.dart';
import 'package:le_petit_davinci/features/authentication/views/welcome.dart';
import 'package:le_petit_davinci/features/rewards/bindings/rewards_binding.dart';
import 'package:le_petit_davinci/features/rewards/views/rewards.dart';
import 'package:le_petit_davinci/features/splash/splash_feature.dart';
import 'package:le_petit_davinci/features/authentication/views/question.dart';
import 'package:le_petit_davinci/features/authentication/views/question_finish.dart';
import 'package:le_petit_davinci/features/studio/bindings/studio_binding.dart';
import 'package:le_petit_davinci/features/studio/views/gallery_screen.dart';
import 'package:le_petit_davinci/features/studio/views/studio_main_screen.dart';
import 'package:le_petit_davinci/features/studio/views/template_selection_screen.dart';
import 'package:le_petit_davinci/features/navigation/views/main_navigation_screen.dart';
import 'package:le_petit_davinci/features/leaderboard/views/leaderboard_screen.dart';
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
      name: AppRoutes.goodMorning,
      page: () => const GoodMorningScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.error,
      page: () => const ErrorScreen(),
      transition: Transition.cupertino,
    ),
    // GetPage(
    //   name: AppRoutes.home,
    //   page: () => const HomeScreen(),
    //   transition: Transition.cupertino,
    //   binding: HomeBinding(),
    //   children: [
    //     // GetPage(
    //     //   name: AppRoutes.frenchIntro,
    //     //   page: () => const FrenchIntroScreen(),
    //     //   transition: Transition.rightToLeft,
    //     //   transitionDuration: const Duration(milliseconds: 500),
    //     //   binding: FrenchBinding(),
    //     // ),
    //     // GetPage(
    //     //   name: AppRoutes.frenchMap,
    //     //   page: () => const FrenchMapScreen(),
    //     //   transition: Transition.rightToLeft,
    //     //   transitionDuration: const Duration(milliseconds: 500),
    //     //   binding: FrenchBinding(),
    //     // ),
    //     // GetPage(
    //     //   name: AppRoutes.englishMap,
    //     //   page: () => const EnglishMapScreen(),
    //     //   transition: Transition.rightToLeft,
    //     //   transitionDuration: const Duration(milliseconds: 500),
    //     //   binding: EnglishBinding(),
    //     //   children: [
    //     //     GetPage(
    //     //       name: AppRoutes.listenAndMatch,
    //     //       page: () => const ListenAndMatch(),
    //     //       transition: Transition.rightToLeft,
    //     //       transitionDuration: const Duration(microseconds: 500),
    //     //     ),
    //     //     GetPage(
    //     //       name: AppRoutes.wordBuilder,
    //     //       page: () => PracticePage(type: PracticeType.wordBuilder),
    //     //       transition: Transition.rightToLeft,
    //     //       transitionDuration: const Duration(microseconds: 500),
    //     //     ),
    //     //     GetPage(
    //     //       name: AppRoutes.findTheWord,
    //     //       page: () => PracticePage(type: PracticeType.findTheWord),
    //     //       transition: Transition.rightToLeft,
    //     //       transitionDuration: const Duration(microseconds: 500),
    //     //     ),
    //     //   ],
    //     // ),
    //     // GetPage(
    //     //   name: AppRoutes.mathMap,
    //     //   page: () => const MathematicMapScreen(),
    //     //   transition: Transition.rightToLeft,
    //     //   transitionDuration: const Duration(milliseconds: 500),
    //     //   binding: MathBinding(),
    //     // ),
    //     GetPage(
    //       name: AppRoutes.dailyLifeMap,
    //       page: () => const VieQuotidienneScreen(),
    //       transition: Transition.rightToLeft,
    //       transitionDuration: const Duration(milliseconds: 500),
    //     ),
    //     GetPage(
    //       name: AppRoutes.games,
    //       page: () => const GamesScreen(),
    //       transition: Transition.rightToLeft,
    //       transitionDuration: const Duration(milliseconds: 500),
    //     ),
    //   ],
    // ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.userSelection,
      page: () => const UserSelectionScreen(),
      binding: AuthBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.pin,
      page: () => const PinEntryScreen(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: AppRoutes.question,
      page: () => const QuestionScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.questionFinish,
      page: () => const QuestionFinishScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.rewards,
      page: () => const RewardsScreen(),
      transition: Transition.rightToLeft,
      binding: RewardsBinding(),
    ),

    // Studio routes
    GetPage(
      name: AppRoutes.studio,
      page: () => const StudioMainScreen(),
      binding: StudioBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.studioMain,
      page: () => const StudioMainScreen(),
      binding: StudioBinding(),
      transition: Transition.rightToLeft,
    ),
    // GetPage(
    //   name: AppRoutes.drawingCanvas,
    //   page: () => const DrawingCanvasScreen(),
    //   binding: StudioBinding(),
    //   transition: Transition.rightToLeft,
    // ),
    GetPage(
      name: AppRoutes.studioGallery,
      page: () => const GalleryScreen(),
      binding: StudioBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.templateSelection,
      page: () => const TemplateSelectionScreen(),
      binding: StudioBinding(),
      transition: Transition.rightToLeft,
    ),
    
    // Main Navigation
    GetPage(
      name: AppRoutes.mainNavigation,
      page: () => const MainNavigationScreen(),
      transition: Transition.fadeIn,
    ),
    
    // Leaderboard
    GetPage(
      name: AppRoutes.leaderboard,
      page: () => const LeaderboardScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}
