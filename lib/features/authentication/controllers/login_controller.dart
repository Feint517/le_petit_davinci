import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/network/network_manager.dart';
import 'package:le_petit_davinci/core/styles/loaders.dart';
import 'package:le_petit_davinci/core/widgets/popups/fullscreen_loader.dart';
import 'package:le_petit_davinci/data/repositories/authentication_repository.dart';
import 'package:le_petit_davinci/features/home/views/home_screen.dart';

class LoginController extends GetxController {
  final email = TextEditingController(text: 'arselene.dev@gmail.com');
  final password = TextEditingController(text: '1234A324@');
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Future<void> login() async {
    try {
      //* start loading
      CustomFullscreenLoader.openLoadingDialog(
        'Logging in...',
        LottieAssets.loadingDots,
      );

      //* check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      //* form validation
      if (!loginFormKey.currentState!.validate()) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(
            email: email.text.trim(),
            password: password.text.trim(),
          );

      AuthenticationRepository.instance.saveLoginStatus(token: '12345678');

      //* remove loader
      CustomFullscreenLoader.stopLoading();

      Get.to(() => const HomeScreen());
    } catch (e) {
      //* remove the loader
      CustomFullscreenLoader.stopLoading();

      //* show some generic error to the user
      CustomLoaders.showSnackBar(
        type: SnackBarType.error,
        title: 'Oh snap!',
        message: e.toString(),
      );
    }
  }
}
