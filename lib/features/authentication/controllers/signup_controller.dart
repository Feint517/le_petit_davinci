import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/network/network_manager.dart';
import 'package:le_petit_davinci/core/styles/loaders.dart';
import 'package:le_petit_davinci/core/widgets/popups/fullscreen_loader.dart';
import 'package:le_petit_davinci/data/repositories/authentication_repository.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class SignupController extends GetxController {
  // Form key
  final signupFormKey = GlobalKey<FormState>();

  // Text controllers
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final authRepo = AuthenticationRepository.instance;

  @override
  void onClose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.onClose();
  }

  // Signup method
  Future<void> signup() async {
    try {
      // Validate form
      if (!signupFormKey.currentState!.validate()) {
        return;
      }

      // Check if passwords match
      if (password.text != confirmPassword.text) {
        CustomLoaders.showSnackBar(
          type: SnackBarType.error,
          title: 'Erreur',
          message: 'Les mots de passe ne correspondent pas',
        );
        return;
      }

      //* Start loading
      CustomFullscreenLoader.openLoadingDialog(
        'Création du compte...',
        LottieAssets.loadingDots,
      );

      //* Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomFullscreenLoader.stopLoading();
        CustomLoaders.showSnackBar(
          type: SnackBarType.error,
          title: 'Pas de connexion',
          message: 'Vérifiez votre connexion internet',
        );
        return;
      }

      //* Call register API
      final response = await authRepo.register(
        email: email.text.trim(),
        password: password.text,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
      );

      //* Remove loader
      CustomFullscreenLoader.stopLoading();

      if (response.success) {
        CustomLoaders.showSnackBar(
          type: SnackBarType.succes,
          title: 'Compte créé!',
          message: 'Vérifiez votre email pour activer votre compte.',
        );

        // Navigate to email verification screen
        Get.toNamed(
          AppRoutes.emailVerification,
          arguments: {
            'email': email.text.trim(),
            'password':
                password
                    .text, // Pass password for auto-login after verification
          },
        );
      } else {
        CustomLoaders.showSnackBar(
          type: SnackBarType.error,
          title: 'Erreur',
          message: response.message,
        );
      }
    } catch (e) {
      //* Remove loader
      CustomFullscreenLoader.stopLoading();

      //* Handle errors
      CustomLoaders.showSnackBar(
        type: SnackBarType.error,
        title: 'Erreur',
        message: e.toString().replaceAll('Exception:', '').trim(),
      );
    }
  }

  // Validate password confirmation
  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Veuillez confirmer votre mot de passe';
    }
    if (value != password.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }
}
