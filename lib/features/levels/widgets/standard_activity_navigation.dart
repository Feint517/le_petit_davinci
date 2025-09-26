import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';
import 'package:le_petit_davinci/mixin/audible_mixin.dart';

/// Standardized navigation bar for all activities
/// Handles Check/Continue buttons, audio controls, and custom configurations
class StandardActivityNavigation extends GetView<LevelController> {
  const StandardActivityNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        final currentActivity = controller.currentActivity;
        final isAnswerReady = controller.isAnswerReady.value;
        final requiresValidation = currentActivity.requiresValidation;

        // Check if activity has custom navigation
        if (currentActivity is ActivityNavigationInterface) {
          final navInterface = currentActivity as ActivityNavigationInterface;
          if (navInterface.useCustomNavigation) {
            return navInterface.customNavigationWidget ??
                const SizedBox.shrink();
          }
        }

        // Get button configuration from activity
        final buttonConfig =
            (currentActivity is ActivityNavigationInterface)
                ? (currentActivity as ActivityNavigationInterface).buttonConfig
                : null;

        return _buildStandardNavigation(
          currentActivity: currentActivity,
          isAnswerReady: isAnswerReady,
          requiresValidation: requiresValidation,
          buttonConfig: buttonConfig,
        );
      }),
    );
  }

  Widget _buildStandardNavigation({
    required dynamic currentActivity,
    required bool isAnswerReady,
    required bool requiresValidation,
    ActivityButtonConfig? buttonConfig,
  }) {
    return Row(
      children: [
        // Audio button (if current activity is audible and enabled)
        if (currentActivity is Audible &&
            (buttonConfig?.showAudioButton ?? true)) ...[
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

        // Main action button
        Expanded(
          child: _buildMainButton(
            currentActivity: currentActivity,
            isAnswerReady: isAnswerReady,
            requiresValidation: requiresValidation,
            buttonConfig: buttonConfig,
          ),
        ),
      ],
    );
  }

  Widget _buildMainButton({
    required dynamic currentActivity,
    required bool isAnswerReady,
    required bool requiresValidation,
    ActivityButtonConfig? buttonConfig,
  }) {
    if (requiresValidation) {
      // Check button for validation-required activities
      return CustomButton(
        label: buttonConfig?.checkButtonText ?? 'Check',
        disabled: !isAnswerReady,
        onPressed: isAnswerReady ? controller.checkAnswer : null,
      );
    } else {
      // Continue button for auto-complete activities
      return CustomButton(
        label: buttonConfig?.continueButtonText ?? 'Continue',
        onPressed: () {
          // If activity has custom navigation interface, notify it
          if (currentActivity is ActivityNavigationInterface) {
            currentActivity.onNavigationTriggered();
          }
          controller.nextActivity();
        },
      );
    }
  }
}
