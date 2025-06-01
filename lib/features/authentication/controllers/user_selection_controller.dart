import 'package:get/get.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class UserSelectionController extends GetxController {
  void onParentSelected() {
    Get.toNamed(Routes.PIN);
  }
  
  void onChildSelected() {
    // Navigate to intro screen to start the child flow
    Get.toNamed(Routes.INTRO);
  }
}