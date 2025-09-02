import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/features/exercises/models/follow_pattern_exercise_model.dart';

class FollowPatternView extends StatelessWidget {
  const FollowPatternView({super.key, required this.exercise});

  final FollowPatternExercise exercise;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          exercise.instruction,
          style: textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const Gap(AppSizes.spaceBtwSections),
        // Display the pattern examples in a styled box
        Container(
          padding: const EdgeInsets.all(AppSizes.lg),
          decoration: BoxDecoration(
            color: AppColors.lightGrey.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
            border: Border.all(color: AppColors.grey),
          ),
          child: Column(
            children:
                exercise.examples
                    .map(
                      (example) =>
                          Text(example, style: textTheme.headlineMedium),
                    )
                    .toList(),
          ),
        ),
        const Gap(AppSizes.md),
        // Display the question
        Text(
          exercise.question,
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(AppSizes.spaceBtwSections * 2),
        // Display the choices
        Wrap(
          spacing: AppSizes.md,
          runSpacing: AppSizes.md,
          alignment: WrapAlignment.center,
          children: List.generate(exercise.options.length, (index) {
            return Obx(
              () => ChoiceChip(
                label: Text(
                  exercise.options[index].toString(),
                  style: textTheme.headlineSmall,
                ),
                selected: exercise.selectedIndex.value == index,
                onSelected: (isSelected) {
                  if (isSelected) {
                    exercise.selectOption(index);
                  }
                },
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.lg,
                  vertical: AppSizes.md,
                ),
                selectedColor: AppColors.primary,
                labelStyle: TextStyle(
                  color:
                      exercise.selectedIndex.value == index
                          ? AppColors.white
                          : AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
