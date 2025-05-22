import 'package:get/get.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class UserSelectionController extends GetxController {
  void onParentSelected() {
    Get.toNamed(Routes.PARENT_ONBOARDING);
  }
  
  void onChildSelected() {
    Get.toNamed(Routes.CHILD_SETUP);
  }
}