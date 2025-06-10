import 'package:get/get.dart';

class UserSelectionController extends GetxController {
  Map<String, dynamic>? args;
  bool showQuestionsIntro = false;
  String? introMessage;

  @override
  void onInit() {
    super.onInit();
    args = Get.arguments as Map<String, dynamic>?;
    showQuestionsIntro = args != null && args!['showQuestionsIntro'] == true;
    introMessage = args != null ? args!['introMessage'] as String? : null;
  }
}
