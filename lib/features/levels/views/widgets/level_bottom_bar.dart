import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';
import 'package:le_petit_davinci/mixin/audible_mixin.dart';

class LevelBottomBar extends GetView<LevelController> {
  const LevelBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.lg),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Obx(() {
          final isAnswerReady = controller.isAnswerReady.value;
          final currentActivity = controller.currentActivity;
          final requiresValidation =
              controller.currentActivityRequiresValidation;

          return Row(
            children: [
              // Audio button (if current activity is audible)
              if (currentActivity is Audible) ...[
                IconButton(
                  onPressed: controller.playCurrentAudio,
                  icon: const Icon(
                    Icons.volume_up,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
                const SizedBox(width: AppSizes.sm),
              ],

              // Check button (if activity requires validation)
              if (requiresValidation) ...[
                Expanded(
                  child: CustomButton(
                    label: 'Check',
                    disabled: !isAnswerReady,
                    onPressed: isAnswerReady ? controller.checkAnswer : null,
                  ),
                ),
              ] else ...[
                // Continue button for auto-complete activities
                Expanded(
                  child: CustomButton(
                    label: 'Continue',
                    onPressed: controller.nextActivity,
                  ),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }
}
