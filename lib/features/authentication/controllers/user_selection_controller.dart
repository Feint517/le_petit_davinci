import 'package:get/get.dart';

class UserSelectionController extends GetxController {
  Map<String, dynamic>? args;
  bool showQuestionsIntro = false;
  String? introMessage;

  @override
  void onInit() {
    super.onInit();
    // Safely handle arguments
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      args = Get.arguments as Map<String, dynamic>;
      showQuestionsIntro = args!['showQuestionsIntro'] == true;
      introMessage = args!['introMessage'] as String?;
    } else {
      // Default values when no arguments are passed
      showQuestionsIntro = false;
      introMessage = null;
    }
  }

}