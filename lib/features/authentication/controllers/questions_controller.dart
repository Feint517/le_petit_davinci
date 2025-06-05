import 'package:get/get.dart';
import 'package:le_petit_davinci/features/authentication/data/models/question_model.dart';
import 'package:le_petit_davinci/features/authentication/views/question_finish_screen.dart';

class QuestionsController extends GetxController {
  final questions =
      <QuestionModel>[
        QuestionModel(
          questionText: "Combien de temps veux-tu apprendre chaque jour ?",
          options: [
            QuestionOption(
              value: '5',
              title: '5 minutes',
              subtitle: "Juste pour m'amuser",
            ),
            QuestionOption(
              value: '10',
              title: '10 minutes',
              subtitle: "Un petit défi",
            ),
            QuestionOption(
              value: '15',
              title: '15 minutes ou +',
              subtitle: "Je veux apprendre beaucoup",
            ),
          ],
        ),
        QuestionModel(
          questionText: "Quel est ton sujet préféré ?",
          options: [
            QuestionOption(
              value: 'math',
              title: 'Mathématiques',
              subtitle: "J'aime les chiffres",
            ),
            QuestionOption(
              value: 'science',
              title: 'Sciences',
              subtitle: "J'aime les expériences",
            ),
            QuestionOption(
              value: 'history',
              title: 'Histoire',
              subtitle: "J'aime les histoires",
            ),
          ],
        ),
        QuestionModel(
          questionText: "Qu'est-ce que tu trouves facile à l'école ?",
          options: [
            QuestionOption(value: 'calculations', title: 'Calculs'),
            QuestionOption(value: 'reading', title: 'Lire une histoire'),
            QuestionOption(value: 'speak english', title: 'Parler anglais'),
            QuestionOption(value: 'learning', title: 'Apprendre en jouant'),
          ],
        ),
        QuestionModel(
          questionText: "Qu'est-ce qui est un peu plus difficile ?",
          options: [
            QuestionOption(value: 'math', title: "Problèmes de maths"),
            QuestionOption(value: 'spelling', title: "Orthographe"),
            QuestionOption(value: 'concentration', title: "Concentration"),
            QuestionOption(
              value: 'understanding',
              title: "Comprendre l'anglais",
            ),
          ],
        ),
        QuestionModel(
          questionText: "Quelle mission t'amuse le plus ?",
          options: [
            QuestionOption(value: 'challenges', title: "Défis rapides"),
            QuestionOption(value: 'build', title: "Construire des choses"),
            QuestionOption(
              value: 'create',
              title: "Créer (dessins, racconter)",
            ),
            QuestionOption(
              value: 'stories',
              title: "Parler ou écouter des histoires",
            ),
          ],
        ),
      ].obs;

  var currentIndex = 0.obs;
  var answers = <int, String>{}.obs;

  void nextQuestion(String answer) {
    answers[currentIndex.value] = answer;
    if (currentIndex.value < questions.length - 1) {
      currentIndex.value++;
    } else {
      // All questions answered, handle completion (e.g., navigate or show summary)
      Get.snackbar(
        "Fini",
        "Merci d'avoir répondu !",
        snackPosition: SnackPosition.BOTTOM,
      );
      // You can navigate or process answers here
      Get.to(() => const WelcomeStatusScreen());
    }
  }

  void checkIfQuestionAnswered() {
    // if (answers.containsKey(currentIndex.value)) {
    //   Get.snackbar(
    //     "Attention",
    //     "Tu as déjà répondu à cette question.",
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // } else {
    //   Get.snackbar(
    //     "Erreur",
    //     "Tu dois répondre à la question avant de continuer.",
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    // }
    final answer = answers[currentIndex.value];
    if (answer != null) {
      nextQuestion(answer);
    } else {
      Get.snackbar(
        "Attention",
        "Veuillez sélectionner une réponse.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
