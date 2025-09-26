import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/misc/animated_mascot.dart';
import 'package:le_petit_davinci/features/levels/models/activities/reorder_words_activity.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';
import 'package:le_petit_davinci/features/levels/widgets/play_audio_button.dart';
import 'package:le_petit_davinci/features/levels/widgets/activity_intro_wrapper.dart';

class ReorderWordsView extends StatefulWidget {
  const ReorderWordsView({super.key, required this.activity});

  final ReorderWordsActivity activity;

  @override
  State<ReorderWordsView> createState() => _ReorderWordsViewState();
}

class _ReorderWordsViewState extends State<ReorderWordsView> {
  late final AnimatedMascotController _mascotController;

  @override
  void initState() {
    super.initState();
    _mascotController = AnimatedMascotController();
  }

  @override
  void dispose() {
    _mascotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ActivityIntroWrapper(
      activity: _buildMainContent(),
      mascotMixin: widget.activity,
      // startButtonText: 'Start Exercise',
      // onStartPressed: () {
      //   widget.activity.isIntroCompleted.value = true;
      // },
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        // Audio button row with mascot
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated mascot with dynamic message
            Obx(() {
              final selectedCount = widget.activity.selectedOrder.length;
              final totalWords = widget.activity.words.length;

              String message;
              MascotAnimationType animationType;

              if (selectedCount == 0) {
                message = 'Listen to the sentence!';
                animationType = MascotAnimationType.talking;
              } else if (selectedCount < totalWords) {
                message =
                    'Keep going! ${totalWords - selectedCount} more words.';
                animationType = MascotAnimationType.talking;
              } else {
                message = 'Great! Now check your answer!';
                animationType = MascotAnimationType.happy;
              }

              return AnimatedMascot(
                mascotSize: 200,
                bubbleText: message,
                bubbleWidth: 150,
                bubbleColor: AppColors.primary,
                animationType: animationType,
                autoPlay:
                    false, // Disable auto-play since we'll trigger manually
                showBubble: false, // Set to false to hide the bubble
                controller: _mascotController,
              );
            }),
            const Gap(AppSizes.md),
            // Audio button
            PlayAudioButton(
              onPressed: () async {
                // Trigger mascot animation when audio button is pressed
                _mascotController.triggerAnimation();
                // Play the audio
                await Get.find<LevelController>().speakSentence(
                  widget.activity.correctOrder
                      .map((i) => widget.activity.words[i])
                      .join(' '),
                );
              },
            ),
          ],
        ),
        const Gap(AppSizes.spaceBtwSections * 2),
        // Selected words row
        Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.activity.selectedOrder.length, (i) {
              final wordIdx = widget.activity.selectedOrder[i];
              return GestureDetector(
                onTap: () => widget.activity.selectedOrder.remove(wordIdx),
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
                    widget.activity.words[wordIdx],
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
            children: List.generate(widget.activity.words.length, (index) {
              final isSelected = widget.activity.selectedOrder.contains(index);
              return GestureDetector(
                onTap:
                    isSelected
                        ? null
                        : () => widget.activity.selectedOrder.add(index),
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
                    widget.activity.words[index],
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
