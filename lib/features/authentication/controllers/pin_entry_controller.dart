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
    print('🔐 [PIN] Controller onInit called');

    // Get profiles from arguments
    final args = Get.arguments as Map<String, dynamic>?;
    print('🔐 [PIN] Arguments: $args');
    
    if (args != null) {
      if (args['profiles'] != null) {
        profiles.value = args['profiles'] as List<Profile>;
        print('🔐 [PIN] Loaded ${profiles.length} profiles');
      }

      autoSelect.value = args['autoSelect'] == true;
      print('🔐 [PIN] Auto-select: ${autoSelect.value}');

      // Auto-select if only one profile
      if (autoSelect.value && profiles.isNotEmpty) {
        selectedProfile.value = profiles.first;
        print('🔐 [PIN] Auto-selected profile: ${selectedProfile.value?.profileName}');
      } else if (profiles.isNotEmpty) {
        // Default to first profile for now
        // You can create a profile selection screen later
        selectedProfile.value = profiles.first;
        print('🔐 [PIN] Default selected profile: ${selectedProfile.value?.profileName}');
      }
    } else {
      print('🔐 [PIN] ERROR: No arguments passed!');
    }
  }

  void onDigitEntered(String digit) {
    print('🔐 [PIN] Digit pressed: $digit, current index: ${currentIndex.value}');
    if (currentIndex.value < 4) {
      pin[currentIndex.value] = digit;
      currentIndex.value++;
      print('🔐 [PIN] New index: ${currentIndex.value}');

      // Auto-submit when all 4 digits are entered
      if (currentIndex.value == 4) {
        print('🔐 [PIN] All 4 digits entered, calling onPinSubmit()');
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
    print('🔐 [PIN] ===== onPinSubmit() called =====');
    final pinCode = pin.join();
    print('🔐 [PIN] PIN code: $pinCode (length: ${pinCode.length})');

    if (pinCode.length != 4) {
      CustomLoaders.showSnackBar(
        type: SnackBarType.error,
        title: 'PIN incomplet',
        message: 'Veuillez entrer les 4 chiffres du PIN',
      );
      return;
    }

    print('🔐 [PIN] Selected profile: ${selectedProfile.value?.profileName ?? "NULL"}');
    
    if (selectedProfile.value == null) {
      print('🔐 [PIN] ERROR: No profile selected!');
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

      print('🔐 [PIN] Validating PIN for profile: ${selectedProfile.value!.id}');

      //* Validate PIN with backend
      final response = await authRepo.validateProfilePin(
        profileId: selectedProfile.value!.id,
        pin: pinCode,
      );

      print('🔐 [PIN] Response success: ${response.success}');
      print('🔐 [PIN] Profile token saved: ${response.data?.profileToken != null}');

      //* Remove loader
      CustomFullscreenLoader.stopLoading();

      if (response.success) {
        print('🔐 [PIN] Navigating to HomeScreen');
        
        CustomLoaders.showSnackBar(
          type: SnackBarType.succes,
          title: 'Bienvenue!',
          message: 'PIN validé avec succès',
        );

        // Small delay to show success message
        await Future.delayed(const Duration(milliseconds: 300));

        // Navigate to home
        Get.offAll(() => const HomeScreen());
        
        print('🔐 [PIN] Navigation complete');
      } else {
        print('🔐 [PIN] Validation failed: ${response.message}');
        // Clear PIN on failure
        resetPin();

        CustomLoaders.showSnackBar(
          type: SnackBarType.error,
          title: 'PIN incorrect',
          message: response.message,
        );
      }
    } catch (e, stackTrace) {
      print('🔐 [PIN] ===== ERROR during validation =====');
      print('🔐 [PIN] Error: $e');
      print('🔐 [PIN] Stack trace: $stackTrace');
      
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
