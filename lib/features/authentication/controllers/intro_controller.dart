import 'package:get/get.dart';
import 'package:le_petit_davinci/features/authentication/views/question_screen.dart';

class IntroController extends GetxController {
  final speechText =
      "Bonjour ! Moi, c'est DaVinci ! Je suis ton ami pour apprendre et t'amuser tous les jours !"
          .obs;

  final List<String> introMessages = [
    "Avant de commencer ton aventure, j'ai 5 petites questions pour mieux te connaître\nEt pendant que tu réponds, je vais bouger et te faire coucou !",
  ];

  int _currentIndex = 0;
  void nextMessage() {
    if (_currentIndex < introMessages.length - 1) {
      _currentIndex++;
      speechText.value = introMessages[_currentIndex];
    } else {
      //* on last message, navigate to different screen
      Get.off(() => QuestionScreen());
    }
  }

  //*=============
}
