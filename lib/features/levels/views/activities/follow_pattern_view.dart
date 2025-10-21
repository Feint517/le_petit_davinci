import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/layouts/grid_layout.dart';
import 'package:le_petit_davinci/features/levels/models/activities/follow_pattern_activity.dart';
import 'package:le_petit_davinci/features/levels/widgets/choice_button.dart';

class FollowPatternView extends StatelessWidget {
  const FollowPatternView({super.key, required this.activity});

  final FollowPatternActivity activity;

  @override
  Widget build(BuildContext context) {
    // Initialize mascot when the view is built (only if not already initialized)
    if (!activity.isInitialized.value) {
      final messages = [
        'Let\'s follow the pattern!',
        'Find the next number in the sequence.',
      ];

      // Use a post-frame callback to ensure proper timing
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          activity.initializeMascot(messages);
        } catch (e) {
          debugPrint('Error initializing mascot in FollowPatternView: $e');
        }
      });
    }

    return _buildMainContent(context);
  }

  Widget _buildMainContent(BuildContext context) {
    final textTheme = Get.textTheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            activity.instruction,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        const Gap(AppSizes.spaceBtwSections),
        // Display the pattern examples in a table
        CustomGridLayout(
          spacing: 0,
          itemCount: 6,
          childAspectRatio: 3,
          itemBuilder: (context, index) {
            // 1. Combine examples and the question into a single list of lines.
            final allLines = [...activity.examples, activity.question];

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
                      (rowIndex == activity.examples.length || colIndex == 1)
                          ? FontWeight.normal
                          : FontWeight.normal,
                ),
              ),
            );
          },
        ),
        const Gap(AppSizes.spaceBtwSections * 2),
        // Display the choices
        Column(
          children: List.generate(activity.options.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
              child: Obx(
                () => ChoiceButton(
                  text: activity.options[index].toString(),
                  isSelected: activity.selectedIndex.value == index,
                  onTap: () => activity.selectOption(index),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
