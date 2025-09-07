import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/features/exercises/models/math_crossword_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/widgets/numpad.dart';

class MathCrosswordView extends StatelessWidget {
  const MathCrosswordView({super.key, required this.exercise});

  final MathCrosswordExercise exercise;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          exercise.instruction,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        // The Crossword Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: exercise.gridWidth * exercise.gridHeight,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: exercise.gridWidth,
          ),
          itemBuilder: (context, index) {
            return Obx(() {
              final char = exercise.userAnswers[index];
              final isInputCell = exercise.puzzleLayout.join('')[index] == '_';
              final isActive = exercise.activeCellIndex.value == index;

              if (char == ' ') {
                // Blank cell, not part of any equation
                return Container(color: AppColors.backgroundLight);
              }

              return GestureDetector(
                onTap: () => exercise.setActiveCell(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isInputCell ? AppColors.light : Colors.transparent,
                    border: Border.all(
                      color:
                          isActive
                              ? AppColors.primary
                              : isInputCell
                              ? AppColors.grey
                              : Colors.transparent,
                      width: isActive ? 2.5 : 1.5,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    char,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isInputCell ? AppColors.primary : AppColors.black,
                    ),
                  ),
                ),
              );
            });
          },
        ),
        const Spacer(),
        // The Numpad for input
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Numpad(
            onNumberPressed: exercise.enterDigit,
            onBackspacePressed: exercise.backspace,
          ),
        ),
        const Gap(AppSizes.md),
      ],
    );
  }
}
