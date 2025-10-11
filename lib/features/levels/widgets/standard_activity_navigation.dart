import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
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
    return buildCircularNavigationButton(
      currentActivity: currentActivity,
      isAnswerReady: isAnswerReady,
      requiresValidation: requiresValidation,
      buttonConfig: buttonConfig,
    );
  }

  /// Builds the audio button widget (if applicable)
  Widget? buildAudioButton({
    required dynamic currentActivity,
    ActivityButtonConfig? buttonConfig,
  }) {
    if (currentActivity is Audible && (buttonConfig?.showAudioButton ?? true)) {
      return IconButton(
        onPressed: controller.playCurrentAudio,
        icon: const Icon(Icons.volume_up, color: AppColors.primary, size: 28),
      );
    }
    return null;
  }

  Widget buildCircularNavigationButton({
    required dynamic currentActivity,
    required bool isAnswerReady,
    required bool requiresValidation,
    ActivityButtonConfig? buttonConfig,
  }) {
    if (requiresValidation) {
      // Check button for validation-required activities
      return _buildCircularButton(
        icon: Icons.check,
        onPressed: isAnswerReady ? controller.checkAnswer : null,
        enabled: isAnswerReady,
        tooltip: buttonConfig?.checkButtonText ?? 'Check',
      );
    } else {
      // Continue button for auto-complete activities
      return _buildCircularButton(
        icon: Icons.arrow_forward,
        onPressed: () {
          // If activity has custom navigation interface, notify it
          if (currentActivity is ActivityNavigationInterface) {
            currentActivity.onNavigationTriggered();
          }
          controller.nextActivity();
        },
        enabled: true,
        tooltip: buttonConfig?.continueButtonText ?? 'Continue',
      );
    }
  }

  Widget _buildCircularButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required bool enabled,
    required String tooltip,
  }) {
    return Tooltip(
      message: tooltip,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              enabled
                  ? AppColors.primary
                  : AppColors.primary.withValues(alpha: 0.3),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(28),
            onTap: enabled ? onPressed : null,
            child: Center(
              child: Icon(
                icon,
                color:
                    enabled
                        ? Colors.white
                        : Colors.white.withValues(alpha: 0.6),
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
