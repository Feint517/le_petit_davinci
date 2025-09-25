import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/features/levels/models/activities/count_by_activity.dart';
import 'package:le_petit_davinci/features/levels/widgets/numpad.dart';
import 'package:le_petit_davinci/features/levels/widgets/activity_intro_wrapper.dart';

class CountByView extends StatelessWidget {
  const CountByView({super.key, required this.activity});

  final CountByActivity activity;

  @override
  Widget build(BuildContext context) {
    return ActivityIntroWrapper(
      activity: _buildMainContent(),
      mascotMixin: activity,
      startButtonText: 'Start Exercise',
      onStartPressed: () {
        activity.isIntroCompleted.value = true;
      },
    );
  }

  Widget _buildMainContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          activity.instruction,
          style: Get.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const Gap(AppSizes.spaceBtwSections * 2),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          spacing: AppSizes.sm,
          runSpacing: AppSizes.sm,
          children: [
            // Display the initial numbers of the sequence
            ...activity.initialSequence.map(
              (number) => _buildNumberDisplay(number),
            ),
            // Display the input boxes for the user
            ...List.generate(
              activity.numberOfInputs,
              (index) => _buildInputBox(index),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
          child: Numpad(
            onNumberPressed: activity.appendInput,
            onBackspacePressed: activity.backspace,
          ),
        ),
        const Gap(AppSizes.md),
      ],
    );
  }

  Widget _buildNumberDisplay(int number) {
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      child: Text(
        number.toString(),
        style: Get.textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInputBox(int index) {
    return GestureDetector(
      onTap: () => activity.setActiveIndex(index),
      child: Obx(() {
        final bool isActive = activity.activeInputIndex.value == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.light,
            borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
            border: Border.all(
              color: isActive ? AppColors.primary : AppColors.grey,
              width: isActive ? 2.5 : 2,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            activity.userInputs[index],
            style: Get.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        );
      }),
    );
  }
}
