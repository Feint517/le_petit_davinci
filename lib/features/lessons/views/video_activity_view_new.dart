import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';
import 'package:le_petit_davinci/features/lessons/models/video_activity_model.dart';
import 'package:le_petit_davinci/features/lessons/widgets/embedded_video_player.dart';

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
        // --- Main Activity UI ---
        return _buildVideoPlayer();
      }
    });
  }

  // Helper widget for the introduction UI.
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
        // The button's visibility is also driven by the model's controller.
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
                        ? CustomButton(
                          label: 'Start Video',
                          width: DeviceUtils.getScreenWidth() * 0.6,
                          // The button does nothing; the model handles the transition automatically.
                          onPressed: () {},
                        )
                        : const SizedBox.shrink(),
              );
            }),
          ),
        ),
      ],
    );
  }

  // Helper widget for the main video player.
  Widget _buildVideoPlayer() {
    return EmbeddedVideoPlayer(
      videoId: activity.videoId,
      onVideoCompleted: activity.markVideoAsCompleted,
    );
  }
}
