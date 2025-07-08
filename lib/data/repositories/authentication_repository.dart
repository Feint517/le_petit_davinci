import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:le_petit_davinci/core/utils/platform_utils.dart';
import 'package:le_petit_davinci/features/authentication/views/login_screen.dart';
import 'package:le_petit_davinci/features/home/views/home_screen.dart';
import 'package:le_petit_davinci/features/onboarding/views/questions_intro.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //* variables
  final deviceStorage = GetStorage();

  @override
  void onReady() async{
    await Future.delayed(const Duration(seconds: 2));
    if (PlatformUtils.isIOS) {
      Get.to(() => const HomeScreen());
    } else {
      screenRedirect();
    }
  }

  void screenRedirect() async {
    var isFirstTime = deviceStorage.read('is_first_time') ?? true;
    var isLoggedIn = deviceStorage.read('is_logged_in') ?? false;

    if (PlatformUtils.isIOS) {
      isFirstTime = true;
    }
    if (kDebugMode) {
      print('isFirstTime => $isFirstTime');
      print('isLoggedIn => $isLoggedIn');
    }

    if (isFirstTime) {
      Get.offAll(() => const QuestionsIntroScreen());
    } else if (isLoggedIn) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  // Optional: call this when the intro is completed
  void completeIntro() async {
    await deviceStorage.write('is_first_time', false);
  }

  // Optional: call this when login is successful
  void setLoggedIn(bool value) {
    deviceStorage.write('is_logged_in', value);
  }
}
