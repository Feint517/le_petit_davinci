import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/features/levels/models/activities/count_by_activity.dart';
import 'package:le_petit_davinci/features/exercises/widgets/numpad.dart';

class CountByView extends StatelessWidget {
  const CountByView({super.key, required this.activity});

  final CountByActivity activity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          activity.instruction,
          style: Theme.of(context).textTheme.headlineSmall,
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
              (number) => _buildNumberDisplay(context, number),
            ),
            // Display the input boxes for the user
            ...List.generate(
              activity.numberOfInputs,
              (index) => _buildInputBox(context, index),
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

  Widget _buildNumberDisplay(BuildContext context, int number) {
    return Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      child: Text(
        number.toString(),
        style: Theme.of(
          context,
        ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInputBox(BuildContext context, int index) {
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
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        );
      }),
    );
  }
}
