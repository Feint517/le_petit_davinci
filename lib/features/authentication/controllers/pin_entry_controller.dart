import 'package:get/get.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class PinEntryController extends GetxController {
  // Observable list for PIN digits
  final pin = List<String>.filled(4, '').obs;
  final currentIndex = 0.obs;

  void onDigitEntered(String digit) {
    if (currentIndex.value < 4) {
      pin[currentIndex.value] = digit;
      currentIndex.value++;
    }
  }

  void onBackspace() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
      pin[currentIndex.value] = '';
    }
  }

  void onPinSubmit() {
    final pinCode = pin.join();
    if (pinCode.length == 4) {
      // Validate PIN and navigate
      Get.toNamed(AppRoutes.login);
    }
  }

  void onForgotPassword() {
    // Navigate to password recovery
    Get.toNamed(AppRoutes.forgotPassword);
  }
}
