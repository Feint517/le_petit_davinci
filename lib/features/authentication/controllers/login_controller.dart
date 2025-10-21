import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/network/network_manager.dart';
import 'package:le_petit_davinci/core/styles/loaders.dart';
import 'package:le_petit_davinci/core/widgets/popups/fullscreen_loader.dart';
import 'package:le_petit_davinci/data/repositories/authentication_repository.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class LoginController extends GetxController {
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  
  final RxBool isGoogleLoading = false.obs;

  final authRepo = AuthenticationRepository.instance;

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }

  Future<void> login() async {
    try {
      //* Start loading
      CustomFullscreenLoader.openLoadingDialog(
        'Connexion en cours...',
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

      //* Form validation
      if (!loginFormKey.currentState!.validate()) {
        CustomFullscreenLoader.stopLoading();
        return;
      }

      //* Call login API
      print('🔐 [LoginController] Calling login API');
      final response = await authRepo.loginWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      //* Remove loader
      CustomFullscreenLoader.stopLoading();

      if (response.success) {
        print('🔐 [LoginController] Login successful');
        CustomLoaders.showSnackBar(
          type: SnackBarType.succes,
          title: 'Succès',
          message: 'Connexion réussie!',
        );

        // Check if user has profiles
        final profiles = response.data.profiles;
        print('🔐 [LoginController] Found ${profiles?.length ?? 0} profiles');

        if (profiles == null || profiles.isEmpty) {
          // No profiles found - navigate to create profile screen
          print('🔐 [LoginController] Navigating to create profile');
          Get.offAllNamed(AppRoutes.createProfile);
        } else if (profiles.length == 1) {
          // One profile - navigate to PIN entry with auto-select
          print('🔐 [LoginController] Navigating to PIN (auto-select)');
          Get.offAllNamed(
            AppRoutes.pin,
            arguments: {'profiles': profiles, 'autoSelect': true},
          );
        } else {
          // Multiple profiles - navigate to PIN entry for selection
          print('🔐 [LoginController] Navigating to PIN (multiple profiles)');
          Get.offAllNamed(
            AppRoutes.pin,
            arguments: {'profiles': profiles, 'autoSelect': false},
          );
        }
      } else {
        CustomLoaders.showSnackBar(
          type: SnackBarType.error,
          title: 'Erreur',
          message: response.message,
        );
      }
    } catch (e) {
      //* Remove the loader
      CustomFullscreenLoader.stopLoading();

      //* Show error to user
      CustomLoaders.showSnackBar(
        type: SnackBarType.error,
        title: 'Erreur de connexion',
        message: e.toString().replaceAll('Exception:', '').trim(),
      );
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      isGoogleLoading.value = true;
      
      print('🔐 [LoginController] Starting Google OAuth');
      
      //* Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        CustomLoaders.showSnackBar(
          type: SnackBarType.error,
          title: 'Pas de connexion',
          message: 'Vérifiez votre connexion internet',
        );
        return;
      }
      
      final response = await authRepo.loginWithGoogle();
      
      if (response.success) {
        print('🔐 [LoginController] Google OAuth successful');
        
        CustomLoaders.showSnackBar(
          type: SnackBarType.succes,
          title: 'Succès',
          message: 'Connexion avec Google réussie!',
        );
        
        // Same navigation logic as email/password login
        final profiles = response.data.profiles;
        
        if (profiles == null || profiles.isEmpty) {
          Get.offAllNamed(AppRoutes.createProfile);
        } else if (profiles.length == 1) {
          Get.offAllNamed(
            AppRoutes.pin,
            arguments: {'profiles': profiles, 'autoSelect': true},
          );
        } else {
          Get.offAllNamed(
            AppRoutes.pin,
            arguments: {'profiles': profiles, 'autoSelect': false},
          );
        }
      }
    } catch (e) {
      print('🔐 [LoginController] Google OAuth error: $e');
      CustomLoaders.showSnackBar(
        type: SnackBarType.error,
        title: 'Erreur',
        message: 'Échec de la connexion Google: ${e.toString().replaceAll('Exception:', '').trim()}',
      );
    } finally {
      isGoogleLoading.value = false;
    }
  }
}
