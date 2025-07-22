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
import 'package:le_petit_davinci/features/exercises/widgets/play_audio_button.dart';
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
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder:
                    (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                child: Column(
                  key: ValueKey(controller.currentExerciseIndex.value),
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
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(color: AppColors.black),
                    ),
                    const Gap(AppSizes.spaceBtwSections * 2),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomGridLayout2(
                          itemCount: exercise.imageAssets.length,
                          spacing: AppSizes.gridViewSpacing * 2,
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
                                          ? Color(0xFFe1f4ff)
                                          : AppColors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow:
                                      CustomShadowStyle.customCircleShadows(
                                        color:
                                            controller.selectedIndex.value ==
                                                    index
                                                ? AppColors.primary
                                                : AppColors.grey,
                                      ),
                                  border: Border.all(
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
                        PlayAudioButton(
                          buttonSize: PlayAudioButtonSize.big,
                          onPressed: controller.playCurrentAudio,
                        ),
                      ],
                    ),
                    const Gap(AppSizes.spaceBtwSections),
                    AnimatedOpacity(
                      opacity: controller.showHint.value ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 400),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            exercise.label,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    CustomButton(
                      label: 'Check',
                      disabled: controller.selectedIndex.value == null,
                      onPressed: controller.checkAnswer,
                    ),
                    Gap(DeviceUtils.getBottomNavigationBarHeight()),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
