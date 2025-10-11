import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';

/// A persistent mascot widget that shows at the bottom left of the screen
/// and displays mascot messages from activities that use MascotIntroductionMixin
class PersistentMascotWidget extends StatelessWidget {
  const PersistentMascotWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Find the current activity and check if it has a mascot
      final levelController = Get.find<LevelController>();
      final currentActivity = levelController.currentActivity;
    
      if (currentActivity is MascotIntroductionMixin) {
        final mascotMixin = currentActivity as MascotIntroductionMixin;
    
        if (mascotMixin.isInitialized &&
            mascotMixin.mascotController != null) {
          return TalkingMascot(
            mascotSize: 180,
            bubbleText: mascotMixin.mascotController!.currentMessage,
            onTap: () {
              mascotMixin.mascotController!.nextMessage();
            },
          );
        }
      }
    
      // No mascot to show
      return const SizedBox.shrink();
    });
  }
}
