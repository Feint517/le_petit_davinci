import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/home/views/home.dart';

class SignupController extends GetxController {
  // Form key
  final signupFormKey = GlobalKey<FormState>();

  // Text controllers
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  // Loading state
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

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
        Get.snackbar(
          'Erreur',
          'Les mots de passe ne correspondent pas',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      isLoading.value = true;

      // TODO: Implement actual signup logic here
      // This is where you would call your API to create the user account
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Show success message
      Get.snackbar(
        'Succès',
        'Compte créé avec succès!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Navigate to homepage
      Get.offAll(() => const HomeScreen());

    } catch (e) {
      // Handle errors
      Get.snackbar(
        'Erreur',
        'Une erreur s\'est produite lors de la création du compte',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
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
