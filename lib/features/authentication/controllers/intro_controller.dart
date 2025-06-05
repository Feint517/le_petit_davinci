import 'package:get/get.dart';

class IntroController extends GetxController {
  var showQuestionsIntro = false.obs;

  void showQuestions() {
    showQuestionsIntro.value = true;
  }
}