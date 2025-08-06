import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/exercises/widgets/progress_bar.dart';
import 'package:le_petit_davinci/features/exercises/controllers/exercises_controller.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';

class ExerciseScreen extends GetView<ExercisesController> {
  const ExerciseScreen({
    super.key,
    required this.exercises,
    required this.dialect,
  });

  final List<Exercise> exercises;
  final String dialect;

  @override
  Widget build(BuildContext context) {
    Get.put(ExercisesController(
      exercises: exercises,
      dialect: dialect,
    ));
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: ProfileHeader(type: ProfileHeaderType.compact),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: Column(
          children: [
            Obx(
              () => ProgressBar(
                progress:
                    (controller.currentExerciseIndex.value + 1) /
                    controller.exercises.length,
              ),
            ),
            const Gap(AppSizes.spaceBtwSections),
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
