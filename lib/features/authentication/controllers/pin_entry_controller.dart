import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/styles/loaders.dart';
import 'package:le_petit_davinci/core/widgets/popups/fullscreen_loader.dart';
import 'package:le_petit_davinci/data/models/auth/profile.dart';
import 'package:le_petit_davinci/data/repositories/authentication_repository.dart';
import 'package:le_petit_davinci/features/home/views/home.dart';

class PinEntryController extends GetxController {
  // Observable list for PIN digits
  final pin = List<String>.filled(4, '').obs;
  final currentIndex = 0.obs;

  // Profiles data
  final profiles = <Profile>[].obs;
  final selectedProfile = Rx<Profile?>(null);
  final autoSelect = false.obs;

  final authRepo = AuthenticationRepository.instance;

  @override
  void onInit() {
    super.onInit();

    // Get profiles from arguments
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      if (args['profiles'] != null) {
        profiles.value = args['profiles'] as List<Profile>;
      }

      autoSelect.value = args['autoSelect'] == true;

      // Auto-select if only one profile
      if (autoSelect.value && profiles.isNotEmpty) {
        selectedProfile.value = profiles.first;
        print(
          '📌 Auto-selected profile: ${selectedProfile.value?.profileName}',
        );
      } else if (profiles.isNotEmpty) {
        // Default to first profile for now
        // You can create a profile selection screen later
        selectedProfile.value = profiles.first;
      }
    }
  }

  void onDigitEntered(String digit) {
    if (currentIndex.value < 4) {
      pin[currentIndex.value] = digit;
      currentIndex.value++;

      // Auto-submit when all 4 digits are entered
      if (currentIndex.value == 4) {
        onPinSubmit();
      }
    }
  }

  void onBackspace() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      pin[currentIndex.value] = '';
    }
  }

  Future<void> onPinSubmit() async {
    final pinCode = pin.join();

    if (pinCode.length != 4) {
      CustomLoaders.showSnackBar(
        type: SnackBarType.error,
        title: 'PIN incomplet',
        message: 'Veuillez entrer les 4 chiffres du PIN',
      );
      return;
    }

    if (selectedProfile.value == null) {
      CustomLoaders.showSnackBar(
        type: SnackBarType.error,
        title: 'Erreur',
        message: 'Aucun profil sélectionné',
      );
      return;
    }

    try {
      //* Start loading
      CustomFullscreenLoader.openLoadingDialog(
        'Validation du PIN...',
        LottieAssets.loadingDots,
      );

      //* Validate PIN with backend
      final response = await authRepo.validateProfilePin(
        profileId: selectedProfile.value!.id,
        pin: pinCode,
      );

      //* Remove loader
      CustomFullscreenLoader.stopLoading();

      if (response.success) {
        CustomLoaders.showSnackBar(
          type: SnackBarType.succes,
          title: 'Bienvenue!',
          message: 'PIN validé avec succès',
        );

        // Navigate to home
        Get.offAll(() => const HomeScreen());
      } else {
        // Clear PIN on failure
        resetPin();

        CustomLoaders.showSnackBar(
          type: SnackBarType.error,
          title: 'PIN incorrect',
          message: response.message,
        );
      }
    } catch (e) {
      //* Remove loader
      CustomFullscreenLoader.stopLoading();

      // Clear PIN on error
      resetPin();

      CustomLoaders.showSnackBar(
        type: SnackBarType.error,
        title: 'Erreur',
        message: e.toString().replaceAll('Exception:', '').trim(),
      );
    }
  }

  void resetPin() {
    pin.value = List<String>.filled(4, '');
    currentIndex.value = 0;
  }

  void onForgotPassword() {
    // Navigate to password recovery or show help
    CustomLoaders.showSnackBar(
      type: SnackBarType.warning,
      title: 'Aide',
      message: 'Contactez un parent pour réinitialiser votre PIN',
      duration: 5,
    );
  }

  // Method to manually select a different profile (for future enhancement)
  void selectProfile(Profile profile) {
    selectedProfile.value = profile;
    resetPin();
  }
}
