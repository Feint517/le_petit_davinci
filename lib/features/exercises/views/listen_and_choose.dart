import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/core/widgets/layouts/grid_layout.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/exercises/controllers/listen_and_choose_controller.dart';
import 'package:le_petit_davinci/features/exercises/models/listen_and_choose_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/widgets/progress_bar.dart';

class ListenAndChooseScreen extends StatelessWidget {
  const ListenAndChooseScreen({super.key, required this.exercises});

  final List<ListenAndChooseExercise> exercises;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListenAndChooseController>(
      init: ListenAndChooseController(exercises),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.backgroundLight,
          appBar: ProfileHeader(type: ProfileHeaderType.compact),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
            child: Obx(() {
              final exercise = controller.currentExercise;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProgressBar(
                    progress:
                        (controller.currentExerciseIndex.value + 1) /
                        controller.exercises.length,
                    backgroundColor: AppColors.grey,
                    progressColor: AppColors.accent,
                  ),
                  const Gap(AppSizes.spaceBtwSections),
                  Text(
                    'Listen and Choose',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  const Gap(AppSizes.spaceBtwSections),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PlayAudioButton(onPressed: controller.playCurrentAudio),
                      const Gap(AppSizes.md),
                      Text(
                        exercise.label,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  const Gap(AppSizes.spaceBtwSections),
                  CustomGridLayout2(
                    itemCount: exercise.imageAssets.length,
                    spacing: AppSizes.gridViewSpacing,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.selectedIndex.value = index;
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.all(AppSizes.sm),
                          decoration: BoxDecoration(
                            color:
                                controller.selectedIndex.value == index
                                    ? AppColors.primary
                                    : AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: CustomShadowStyle.customCircleShadows(
                              color:
                                  controller.selectedIndex.value == index
                                      ? AppColors.primary
                                      : AppColors.grey,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: ResponsiveImageAsset(
                              assetPath: exercise.imageAssets[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  CustomButton(
                    label: 'Check',
                    disabled: controller.selectedIndex.value == null,
                    onPressed: controller.checkAnswer,
                  ),
                  Gap(DeviceUtils.getBottomNavigationBarHeight()),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}

class PlayAudioButton extends StatelessWidget {
  const PlayAudioButton({
    super.key,
    this.backgroundColor = AppColors.primary,
    this.size,
    this.onPressed,
  });

  final Color backgroundColor;
  final double? size;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size ?? 50,
        height: size ?? 50,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: CustomShadowStyle.customCircleShadows(
            color: backgroundColor,
          ),
        ),
        child: Icon(Icons.volume_up, color: AppColors.white, size: 30),
      ),
    );
  }
}
