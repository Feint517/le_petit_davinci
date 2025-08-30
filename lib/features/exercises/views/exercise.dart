import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/exercises/controllers/exercises_controller.dart';

class ExerciseScreen extends GetView<ExercisesController> {
  const ExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: ProfileHeader(type: ProfileHeaderType.activity),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.exercises.length,
                itemBuilder: (context, index) {
                  final exercise = controller.exercises[index];
                  // The model itself builds the correct view
                  return exercise.build(context);
                },
              ),
            ),
            Obx(
              () => CustomButton(
                label: 'Check',
                disabled: !controller.canCheckAnswer,
                onPressed: controller.checkAnswer,
              ),
            ),
            Gap(DeviceUtils.getBottomNavigationBarHeight()),
          ],
        ),
      ),
    );
  }
}
