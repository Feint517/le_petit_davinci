import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/styles/loaders.dart';
import 'package:le_petit_davinci/core/widgets/popups/fullscreen_loader.dart';
import 'package:le_petit_davinci/data/repositories/authentication_repository.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class EmailVerificationController extends GetxController {
  final authRepo = AuthenticationRepository.instance;

  // Email and password passed from signup
  late String email;
  late String password;

  // Verification code
  final verificationCode = ''.obs;
  final hasError = false.obs;

  // Resend timer
  final canResend = false.obs;
  final resendCountdown = 60.obs;
  Timer? _resendTimer;

  @override
  void onInit() {
    super.onInit();

    // Get email and password from arguments
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      email = args['email'] as String? ?? '';
      password = args['password'] as String? ?? '';
    }

    // Start resend timer
    startResendTimer();
  }

  @override
  void onClose() {
    _resendTimer?.cancel();
    super.onClose();
  }

  /// Start countdown timer for resend
  void startResendTimer() {
    canResend.value = false;
    resendCountdown.value = 60;

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendCountdown.value > 0) {
        resendCountdown.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  /// Handle code change
  void onCodeChanged(String code) {
    verificationCode.value = code;
    hasError.value = false; // Clear error on new input
  }

  /// Verify email with code
  Future<void> verifyEmail(String code) async {
    try {
      CustomFullscreenLoader.openLoadingDialog(
        'Vérification en cours...',
        LottieAssets.loadingDots,
      );

      final response = await authRepo.verifyEmail(
        email: email,
        code: code,
        password: password,
      );

      CustomFullscreenLoader.stopLoading();

      if (response.success) {
        CustomLoaders.showSnackBar(
          type: SnackBarType.succes,
          title: 'Succès!',
          message: 'Votre email a été vérifié avec succès!',
        );

        // Navigate based on profile status
        await Future.delayed(const Duration(milliseconds: 500));

        // Fetch profiles
        try {
          final profiles = await authRepo.getProfiles();

          if (profiles.isEmpty) {
            // No profiles found - navigate to create profile screen
            Get.offAllNamed(AppRoutes.createProfile);
          } else if (profiles.length == 1) {
            // One profile found - navigate to PIN entry with auto-select
            Get.offAllNamed(
              AppRoutes.pin,
              arguments: {'profiles': profiles, 'autoSelect': true},
            );
          } else {
            // Multiple profiles - navigate to PIN entry for selection
            Get.offAllNamed(
              AppRoutes.pin,
              arguments: {'profiles': profiles, 'autoSelect': false},
            );
          }
        } catch (e) {
          // If fetching profiles fails, go to create profile
          Get.offAllNamed(AppRoutes.createProfile);
        }
      } else {
        hasError.value = true;
        CustomLoaders.showSnackBar(
          type: SnackBarType.error,
          title: 'Code incorrect',
          message: response.message,
        );
      }
    } catch (e) {
      CustomFullscreenLoader.stopLoading();
      hasError.value = true;

      CustomLoaders.showSnackBar(
        type: SnackBarType.error,
        title: 'Erreur',
        message: e.toString().replaceAll('Exception:', '').trim(),
      );
    }
  }

  /// Resend verification code
  Future<void> resendCode() async {
    if (!canResend.value) return;

    try {
      CustomFullscreenLoader.openLoadingDialog(
        'Envoi du code...',
        LottieAssets.loadingDots,
      );

      final response = await authRepo.resendVerificationCode(email: email);

      CustomFullscreenLoader.stopLoading();

      if (response.success) {
        CustomLoaders.showSnackBar(
          type: SnackBarType.succes,
          title: 'Code renvoyé!',
          message: 'Un nouveau code a été envoyé à votre email.',
        );

        // Restart timer
        startResendTimer();
      } else {
        CustomLoaders.showSnackBar(
          type: SnackBarType.error,
          title: 'Erreur',
          message: response.message,
        );
      }
    } catch (e) {
      CustomFullscreenLoader.stopLoading();

      CustomLoaders.showSnackBar(
        type: SnackBarType.error,
        title: 'Erreur',
        message: e.toString().replaceAll('Exception:', '').trim(),
      );
    }
  }

  /// Navigate back to signup
  void goBack() {
    Get.back();
  }
}
