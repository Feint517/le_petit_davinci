import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';
import 'package:le_petit_davinci/features/levels/controllers/victory_controller.dart';
import 'package:le_petit_davinci/features/english/view/english_map.dart';
import 'package:le_petit_davinci/features/french/view/french_map.dart';
import 'package:le_petit_davinci/features/math/views/math_map.dart';

class LevelProgressBar extends StatelessWidget implements PreferredSizeWidget {
  const LevelProgressBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LevelController>();
    return Obx(() {
      final totalSteps = controller.totalItems;
      final currentStep = controller.currentIndex.value + 1;
      //? The progress is the number of completed steps divided by the total.
      final double progress = totalSteps > 0 ? currentStep / totalSteps : 0;

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              // Close/Exit button
              GestureDetector(
                onTap: () => _showExitConfirmation(context, controller),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.close,
                    color: AppColors.darkGrey,
                    size: 20,
                  ),
                ),
              ),
              const Gap(12),
              // Progress bar
              Expanded(
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: progress),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, animatedValue, child) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: animatedValue,
                        minHeight: 10,
                        backgroundColor: AppColors.grey.withValues(alpha: 0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  void _showExitConfirmation(BuildContext context, LevelController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit Level'),
          content: const Text(
            'Are you sure you want to leave this level? Your progress will be saved.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _navigateToMapScreen(controller);
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToMapScreen(LevelController controller) {
    // Determine the appropriate map screen based on the subject
    Widget destination;

    switch (controller.subject) {
      case Subjects.english:
        destination = const EnglishMapScreen();
        break;
      case Subjects.math:
        destination = const MathMapScreen2();
        break;
      case Subjects.french:
        destination = const FrenchMapScreen();
        break;
    }

    // Navigate back to the map screen and clear the level screen from the stack
    Get.offUntil(
      MaterialPageRoute(builder: (_) => destination),
      (route) => route.isFirst,
    );
  }
}
