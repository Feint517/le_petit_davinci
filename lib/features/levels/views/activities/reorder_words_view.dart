import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/features/levels/models/activities/reorder_words_activity.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';
import 'package:le_petit_davinci/features/levels/widgets/play_audio_button.dart';
import 'package:le_petit_davinci/features/levels/widgets/activity_intro_wrapper.dart';

class ReorderWordsView extends StatelessWidget {
  const ReorderWordsView({super.key, required this.activity});

  final ReorderWordsActivity activity;

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
      children: [
        // Audio button row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PlayAudioButton(
              onPressed:
                  () async => await Get.find<LevelController>().speakSentence(
                    activity.correctOrder
                        .map((i) => activity.words[i])
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
            children: List.generate(activity.selectedOrder.length, (i) {
              final wordIdx = activity.selectedOrder[i];
              return GestureDetector(
                onTap: () => activity.selectedOrder.remove(wordIdx),
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
                    activity.words[wordIdx],
                    style: Get.textTheme.bodyMedium?.copyWith(
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
            children: List.generate(activity.words.length, (index) {
              final isSelected = activity.selectedOrder.contains(index);
              return GestureDetector(
                onTap:
                    isSelected ? null : () => activity.selectedOrder.add(index),
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
                    activity.words[index],
                    style: Get.textTheme.bodyMedium?.copyWith(
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
