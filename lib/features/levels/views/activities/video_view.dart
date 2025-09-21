import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';
import 'package:le_petit_davinci/features/levels/models/activities/activities.dart';

class VideoActivityView extends StatelessWidget {
  const VideoActivityView({super.key, required this.activity});

  final VideoActivity activity;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // The view simply switches based on the model's state.
      if (!activity.isIntroCompleted.value) {
        // --- Intro UI ---
        return _buildIntroUI();
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }

  Widget _buildIntroUI() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Obx(
          () => TalkingMascot(
            mascotSize: 220,
            bubbleText: activity.mascotController.currentMessage,
            onTap: activity.mascotController.nextMessage,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: DeviceUtils.getBottomNavigationBarHeight() + 16,
            ),
            child: Obx(() {
              return AnimatedOpacity(
                opacity:
                    activity.mascotController.isCompleted.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child:
                    activity.mascotController.isCompleted.value
                        ? const CircularProgressIndicator()
                        : const SizedBox.shrink(),
              );
            }),
          ),
        ),
      ],
    );
  }
}
