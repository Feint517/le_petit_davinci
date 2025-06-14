import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button_main.dart';
import 'package:le_petit_davinci/core/widgets/top_navigation.dart';
import 'package:le_petit_davinci/features/french/view/finish.dart';
import 'package:le_petit_davinci/features/french/model/check_error_model.dart';

class FrenchCherchelerreur extends StatefulWidget {
  const FrenchCherchelerreur({super.key});

  @override
  State<FrenchCherchelerreur> createState() => _FrenchCherchelerreurState();
}

class _FrenchCherchelerreurState extends State<FrenchCherchelerreur> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  String? selectedAnswer;
  bool answerChecked = false;
  bool isCorrect = false;

  final List<CheckError> questions = [
    CheckError(
      sentence: "J'écris sur un rocher",
      options: ['Murs', 'Nuages', 'Livres'],
      correctAnswer: 'Murs',
    ),
    CheckError(
      sentence: "Je dessine sur le tableau",
      options: ['Cahier', 'Tableau', 'Fenêtre'],
      correctAnswer: 'Tableau',
    ),
    CheckError(
      sentence: "Elle peint sur la toile",
      options: ['Papier', 'Toile', 'Porte'],
      correctAnswer: 'Toile',
    ),
    CheckError(
      sentence: "Nous écrivons dans le carnet",
      options: ['Carnet', 'Bureau', 'Chaise'],
      correctAnswer: 'Carnet',
    ),
    CheckError(
      sentence: "Il grave sur le bois",
      options: ['Pierre', 'Métal', 'Bois'],
      correctAnswer: 'Bois',
    ),
  ];

  void checkAnswer() {
    if (selectedAnswer == null) return;

    setState(() {
      answerChecked = true;
      isCorrect =
          selectedAnswer == questions[currentQuestionIndex].correctAnswer;
      if (isCorrect) {
        correctAnswers++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedAnswer = null;
        answerChecked = false;
      } else {
        // Exercise completed
        Get.to(
          () => const FinishChercheLerreur(),
          duration: const Duration(milliseconds: 500),
          transition: Transition.rightToLeft,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            TopNavigation(
              text: 'Français',
              buttonColor: AppColors.bluePrimaryDark,
            ),

            Text(
              "Cherche l'erreur",
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "Travailler la correction grammaticale et l'attention aux détails.",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  SvgPicture.asset(
                    SvgAssets.chasseursDesFautes,
                    fit: BoxFit.cover,
                    width: context.width / 2.5,
                  ),
                ],
              ),
            ),

            Flexible(
              child: Stack(
                children: [
                  SvgPicture.asset(
                    SvgAssets.primaryBlueTopRoundBg,
                    fit: BoxFit.fill,
                    height: context.height,
                    alignment: Alignment.bottomCenter,
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 20,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '$correctAnswers mots réussis sur ${questions.length}',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 10),

                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.bluePrimaryDark,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: Text(
                              currentQuestion.sentence,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Options
                          ...currentQuestion.options.map((option) {
                            Color buttonColor = AppColors.white;
                            Color textColor = AppColors.bluePrimaryDark;
                            Color borderColor = AppColors.bluePrimaryDark;

                            // If answer is checked, show correct/incorrect colors
                            if (answerChecked) {
                              if (option == currentQuestion.correctAnswer) {
                                buttonColor = AppColors.accent;
                                textColor = AppColors.white;
                              } else if (option == selectedAnswer &&
                                  !isCorrect) {
                                buttonColor = AppColors.orange;
                                textColor = AppColors.white;
                              }
                            }
                            // If answer is not checked, highlight selected option
                            else if (option == selectedAnswer) {
                              buttonColor = AppColors.accent2;
                              textColor = AppColors.white;
                            }

                            return GestureDetector(
                              onTap:
                                  answerChecked
                                      ? null
                                      : () {
                                        setState(() {
                                          selectedAnswer = option;
                                        });
                                      },
                              child: Container(
                                width: context.width * 0.8,
                                padding: EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: buttonColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: borderColor,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  option,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),

                          const SizedBox(height: 20),

                          if (!answerChecked)
                            CustomButtonNew(
                              buttonColor: AppColors.secondary,
                              shadowColor: AppColors.orangeAccentDark,
                              label: 'Vérifier ma réponse',
                              labelColor: AppColors.background,
                              onPressed:
                                  selectedAnswer == null ? null : checkAnswer,
                              icon: Icons.arrow_outward_rounded,
                              iconColor: AppColors.backgroundLight,
                              width: context.width / 1.5,
                            )
                          else
                            CustomButtonNew(
                              buttonColor:
                                  isCorrect
                                      ? AppColors.accent
                                      : AppColors.orange,
                              shadowColor:
                                  isCorrect
                                      ? AppColors.accent2
                                      : AppColors.pinkMedium,
                              label: isCorrect ? 'Correct!' : 'Incorrect',
                              labelColor: AppColors.white,
                              onPressed: nextQuestion,
                              icon: Icons.arrow_forward_rounded,
                              iconColor: AppColors.white,
                              width: context.width / 1.5,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
