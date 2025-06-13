import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/math_problem_widget.dart';

class MathSubtractionScreen extends StatelessWidget {
  const MathSubtractionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              SvgAssets.mathbg,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholderBuilder:
                  (context) => Container(
                    color: AppColors.secondary,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Top navigation bar with back button and Mathématiques text
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      // Back button
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.chevron_left,
                                color: AppColors.darkGrey,
                                size: 16,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                'Back',
                                style: TextStyle(
                                  color: AppColors.darkGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Mathématiques text with math theme background
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary, // Math orange background
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.orangeAccentDark.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Text(
                          'Mathématiques',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Title and subtitle section
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    children: [
                      // Main title
                      Text(
                        'Les soustractions en mission',
                        style: TextStyle(
                          color: AppColors.darkGrey,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      // Subtitle
                      Text(
                        'Résous des soustractions simples pour accomplir ta mission.',
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 100),
                // Math problem widget with subtraction problems
                Expanded(
                  child: MathProblemWidget(problems: _getSubtractionProblems()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Define subtraction problems
  List<MathProblem> _getSubtractionProblems() {
    return [
      MathProblem(
        firstNumber: 8,
        secondNumber: 3,
        answerChoices: [5, 6, 4],
        operator: '-',
      ),
      MathProblem(
        firstNumber: 9,
        secondNumber: 2,
        answerChoices: [7, 8, 6],
        operator: '-',
      ),
      MathProblem(
        firstNumber: 7,
        secondNumber: 4,
        answerChoices: [3, 2, 4],
        operator: '-',
      ),
      MathProblem(
        firstNumber: 10,
        secondNumber: 5,
        answerChoices: [5, 6, 4],
        operator: '-',
      ),
      MathProblem(
        firstNumber: 6,
        secondNumber: 2,
        answerChoices: [4, 3, 5],
        operator: '-',
      ),
      MathProblem(
        firstNumber: 9,
        secondNumber: 6,
        answerChoices: [3, 4, 2],
        operator: '-',
      ),
      MathProblem(
        firstNumber: 8,
        secondNumber: 5,
        answerChoices: [3, 2, 4],
        operator: '-',
      ),
    ];
  }
}
