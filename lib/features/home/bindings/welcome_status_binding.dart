import 'package:get/get.dart';
import '../controllers/welcome_status_controller.dart';

class WelcomeStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeStatusController>(
      () => WelcomeStatusController(),
    );
  }
}