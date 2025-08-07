import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/features/exercises/models/reorder_words_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/widgets/play_audio_button.dart';
import 'package:le_petit_davinci/features/exercises/controllers/exercises_controller.dart';

class ReorderWordsView extends GetView<ExercisesController> {
  const ReorderWordsView({super.key, required this.exercise});

  final ReorderWordsExercise exercise;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    exercise.correctOrder
                        .map((i) => exercise.words[i])
                        .join(' '),
                  ),
            ),
          ],
        ),
        const Gap(AppSizes.spaceBtwSections * 2),
        // Selected words row
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(controller.selectedOrder.length, (i) {
              final wordIdx = controller.selectedOrder[i];
              return GestureDetector(
                onTap: () => controller.selectedOrder.remove(wordIdx),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.accent, width: 2),
                  ),
                  child: Text(
                    exercise.words[wordIdx],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const Gap(AppSizes.spaceBtwSections * 2),
        // Word options
        Obx(
          () => Wrap(
            spacing: AppSizes.md,
            runSpacing: AppSizes.md,
            alignment: WrapAlignment.center,
            children: List.generate(exercise.words.length, (index) {
              final isSelected = controller.selectedOrder.contains(index);
              return GestureDetector(
                onTap:
                    isSelected
                        ? null
                        : () => controller.selectedOrder.add(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.sm,
                    vertical: AppSizes.sm,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.grey : AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 2),
                    boxShadow: CustomShadowStyle.customCircleShadows(
                      color: AppColors.grey,
                      offsetY: 1,
                    ),
                  ),
                  child: Text(
                    exercise.words[index],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
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
