import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/exercises/controllers/reorder_words_controller.dart';
import 'package:le_petit_davinci/features/exercises/widgets/play_audio_button.dart';
import 'package:le_petit_davinci/features/exercises/widgets/progress_bar.dart';

class ReorderWordsScreen extends GetView<ReorderWordsController> {
  const ReorderWordsScreen({super.key, required this.exercises});

  final List<ReorderWordsExercise> exercises;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReorderWordsController>(
      init: ReorderWordsController(exercises),
      builder: (controller) {
        return Scaffold(
          appBar: ProfileHeader(type: ProfileHeaderType.compact),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
            child: Obx(() {
              final exercise = controller.currentExercise;
              final words = exercise.words;
              final selectedOrder = controller.selectedOrder;
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
                      'Reorder Words',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(color: AppColors.black),
                    ),
                    const Gap(AppSizes.spaceBtwSections),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ResponsiveImageAsset(
                          assetPath: SvgAssets.bearMasscot,
                          width: 200,
                          height: 200,
                        ),
                        const Gap(AppSizes.md),
                        PlayAudioButton(
                          onPressed:
                              () async => await controller.speakSentence(
                                // Optionally, you can reconstruct the correct sentence here
                                exercise.correctOrder
                                    .map((i) => words[i])
                                    .join(' '),
                              ),
                        ),
                      ],
                    ),
                    const Gap(AppSizes.spaceBtwSections * 2),
                    //* answers row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(selectedOrder.length, (i) {
                        final wordIdx = selectedOrder[i];
                        return GestureDetector(
                          onTap: () {
                            // Remove word from selectedOrder when tapped
                            controller.selectedOrder.remove(wordIdx);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.accent.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.accent,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              words[wordIdx],
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),

                    const Gap(AppSizes.spaceBtwSections * 2),
                    //* Options row
                    Wrap(
                      spacing: AppSizes.md,
                      runSpacing: AppSizes.md,
                      alignment: WrapAlignment.center,
                      children: List.generate(words.length, (index) {
                        final isSelected = selectedOrder.contains(index);
                        return GestureDetector(
                          onTap:
                              isSelected
                                  ? null
                                  : () {
                                    controller.selectedOrder.add(index);
                                  },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.sm,
                              vertical: AppSizes.sm,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected ? AppColors.grey : AppColors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.accent,
                                width: 2,
                              ),
                              boxShadow: CustomShadowStyle.customCircleShadows(
                                color: AppColors.white,
                                offsetX: 2,
                                offsetY: 1,
                              ),
                            ),
                            child: Text(
                              words[index],
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const Spacer(),
                    CustomButton(
                      label: 'Check',
                      disabled: selectedOrder.length != words.length,
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
