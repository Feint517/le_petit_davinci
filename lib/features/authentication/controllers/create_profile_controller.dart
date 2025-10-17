import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/loaders.dart';
import 'package:le_petit_davinci/core/widgets/popups/fullscreen_loader.dart';
import 'package:le_petit_davinci/data/repositories/authentication_repository.dart';
import 'package:le_petit_davinci/features/authentication/views/create_profile.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class CreateProfileController extends GetxController {
  final authRepo = AuthenticationRepository.instance;

  // Form controllers
  final profileName = TextEditingController();
  final pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Selected avatar index
  var selectedAvatarIndex = RxInt(-1); // -1 means nothing selected

  // Available avatars
  final List<AvatarData> avatars = [
    AvatarData(image: SvgAssets.avatar1, backgroundColor: AppColors.primary),
    AvatarData(image: SvgAssets.avatar2, backgroundColor: AppColors.secondary),
    AvatarData(image: SvgAssets.avatar3, backgroundColor: AppColors.accent),
    AvatarData(image: SvgAssets.avatar4, backgroundColor: AppColors.accent3),
  ];

  @override
  void onClose() {
    profileName.dispose();
    pinController.dispose();
    super.onClose();
  }

  void selectAvatar(int index) {
    selectedAvatarIndex.value = index;
  }

  Future<void> createProfile() async {
    try {
      // Validate form
      if (!formKey.currentState!.validate()) {
        return;
      }

      // Validate avatar selection
      if (selectedAvatarIndex.value == -1) {
        CustomLoaders.showSnackBar(
          type: SnackBarType.error,
          title: 'Avatar requis',
          message: 'Veuillez sélectionner un avatar pour votre profil.',
        );
        return;
      }

      // Validate PIN
      if (pinController.text.length != 4) {
        CustomLoaders.showSnackBar(
          type: SnackBarType.error,
          title: 'PIN invalide',
          message: 'Le code PIN doit contenir 4 chiffres.',
        );
        return;
      }

      CustomFullscreenLoader.openLoadingDialog(
        'Création du profil...',
        LottieAssets.loadingDots,
      );

      // Get selected avatar
      final selectedAvatar = avatars[selectedAvatarIndex.value].image;

      // Create profile via API
      await authRepo.createProfile(
        profileName: profileName.text.trim(),
        pin: pinController.text,
        avatar: selectedAvatar,
      );

      CustomFullscreenLoader.stopLoading();

      CustomLoaders.showSnackBar(
        type: SnackBarType.succes,
        title: 'Profil créé!',
        message: 'Votre profil a été créé avec succès!',
      );

      // Navigate to dashboard or home (skip PIN entry since we just created it)
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      CustomFullscreenLoader.stopLoading();
      CustomLoaders.showSnackBar(
        type: SnackBarType.error,
        title: 'Erreur',
        message: e.toString().replaceAll('Exception:', '').trim(),
      );
    }
  }

  String? validateProfileName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le nom du profil est requis';
    }
    if (value.length < 2) {
      return 'Le nom doit contenir au moins 2 caractères';
    }
    return null;
  }

  String? validatePin(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le code PIN est requis';
    }
    if (value.length != 4) {
      return 'Le code PIN doit contenir 4 chiffres';
    }
    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'Le code PIN doit contenir uniquement des chiffres';
    }
    return null;
  }
}
