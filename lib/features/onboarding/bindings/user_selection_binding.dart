import 'package:get/get.dart';
import 'package:le_petit_davinci/features/onboarding/controllers/user_selection_controller.dart';

class UserSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserSelectionController>(() => UserSelectionController());
  }
}