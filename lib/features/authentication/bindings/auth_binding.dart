import 'package:get/get.dart';
import 'package:le_petit_davinci/features/authentication/controllers/pin_entry_controller.dart';
import 'package:le_petit_davinci/features/authentication/controllers/user_selection_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserSelectionController());
    Get.lazyPut(() => PinEntryController());
  }
}
