import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';
import 'package:le_petit_davinci/features/levels/widgets/standard_activity_navigation.dart';
import 'package:le_petit_davinci/features/levels/widgets/persistent_mascot_widget.dart';

class LevelContentView extends GetView<LevelController> {
  const LevelContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.hasError.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error loading level',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                controller.errorMessage.value ?? 'Unknown error',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => controller.retry(),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }

      // Use Stack layout with PageView for activities and floating navigation buttons
      return Stack(
        children: [
          // Activity content (full screen)
          PageView.builder(
            controller: controller.pageController,
            itemCount: controller.totalItems,
            physics:
                const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final activity = controller.levelSet.activities[index];
              return activity.build(context); // Direct activity rendering
            },
          ),

          // Persistent mascot widget
          Positioned(
            left: -15,
            bottom: -10,
            child: const PersistentMascotWidget(),
          ),

          // Floating navigation buttons
          ..._buildFloatingNavigationButtons(),
        ],
      );
    });
  }

  List<Widget> _buildFloatingNavigationButtons() {
    final currentActivity = controller.currentActivity;
    final isAnswerReady = controller.isAnswerReady.value;
    final requiresValidation = currentActivity.requiresValidation;

    // Check if activity has custom navigation
    if (currentActivity is ActivityNavigationInterface) {
      final navInterface = currentActivity as ActivityNavigationInterface;
      if (navInterface.useCustomNavigation) {
        return [
          if (navInterface.customNavigationWidget != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: navInterface.customNavigationWidget!,
            ),
        ];
      }
    }

    // Get button configuration from activity
    final buttonConfig =
        (currentActivity is ActivityNavigationInterface)
            ? (currentActivity as ActivityNavigationInterface).buttonConfig
            : null;

    final navigation = StandardActivityNavigation();
    final audioButton = navigation.buildAudioButton(
      currentActivity: currentActivity,
      buttonConfig: buttonConfig,
    );

    List<Widget> buttons = [];

    // Audio button at bottom left (if applicable)
    if (audioButton != null) {
      buttons.add(Positioned(left: 16, bottom: 16, child: audioButton));
    }

    // Main navigation button at bottom right
    buttons.add(
      Positioned(
        right: 16,
        bottom: 16,
        child: navigation.buildCircularNavigationButton(
          currentActivity: currentActivity,
          isAnswerReady: isAnswerReady,
          requiresValidation: requiresValidation,
          buttonConfig: buttonConfig,
        ),
      ),
    );

    return buttons;
  }
}
