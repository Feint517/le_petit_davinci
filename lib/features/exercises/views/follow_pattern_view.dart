import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/layouts/grid_layout.dart';
import 'package:le_petit_davinci/features/exercises/models/follow_pattern_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/widgets/choice_button.dart';

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
        // Display the pattern examples in a table
        CustomGridLayout(
          spacing: 0,
          itemCount: 6,
          childAspectRatio: 3,
          itemBuilder: (context, index) {
            // 1. Combine examples and the question into a single list of lines.
            final allLines = [...exercise.examples, exercise.question];

            // 2. Calculate the row and column for the current cell index.
            final rowIndex =
                index ~/ 2; // Integer division gives the row (0, 1, 2)
            final colIndex = index % 2; // Modulo gives the column (0 or 1)

            // 3. Get the full string for the current row (e.g., "3 + 1 = 4").
            final line = allLines[rowIndex];
            final parts = line.split('=');
            final leftPart = parts[0].trim();
            final rightPart = parts.length > 1 ? parts[1].trim() : '';

            // 4. Determine the text for this specific cell.
            final cellText = (colIndex == 0) ? leftPart : rightPart;
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.lightGrey.withValues(alpha: 0.4),
                border: Border.all(color: AppColors.primary),
              ),
              child: Text(
                cellText,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight:
                      (rowIndex == exercise.examples.length || colIndex == 1)
                          ? FontWeight.bold
                          : FontWeight.normal,
                ),
              ),
            );
          },
        ),
        const Gap(AppSizes.spaceBtwSections * 2),
        // Display the choices
        Column(
          children: List.generate(exercise.options.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
              child: Obx(
                () => ChoiceButton(
                  text: exercise.options[index].toString(),
                  isSelected: exercise.selectedIndex.value == index,
                  onTap: () => exercise.selectOption(index),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
