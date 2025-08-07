import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/controllers/exercises_controller.dart';

class FillTheBlankView extends GetView<ExercisesController> {
  const FillTheBlankView({super.key, required this.exercise});

  final FillTheBlankExercise exercise;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The question
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.accent, width: 3),
                ),
              ),
              child: Center(
                child: Obx(() {
                  final selected = controller.selectedFillBlankIndex.value;
                  return Text(
                    selected != null
                        ? exercise.options[selected].optionText
                        : '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
              ),
            ),
            Text(
              ' ${exercise.questionSuffix}',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.black),
            ),
          ],
        ),
        const Gap(140),
        // Choices
        Expanded(
          child: Column(
            children: List.generate(exercise.options.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
                child: Obx(
                  () => GestureDetector(
                    onTap:
                        () => controller.selectedFillBlankIndex.value = index,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: DeviceUtils.getScreenWidth(),
                      height: 45,
                      decoration: BoxDecoration(
                        color:
                            controller.selectedFillBlankIndex.value == index
                                ? AppColors.accent
                                : AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: CustomShadowStyle.customCircleShadows(
                          color:
                              controller.selectedFillBlankIndex.value == index
                                  ? AppColors.accent
                                  : AppColors.white,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          exercise.options[index].optionText,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
