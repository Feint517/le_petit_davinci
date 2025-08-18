// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';
import 'package:le_petit_davinci/features/lessons/controllers/lessons_controller.dart';
import 'package:le_petit_davinci/features/lessons/models/activity_model.dart';
import 'package:le_petit_davinci/features/lessons/views/video_player2.dart';

class VideoActivityView extends StatefulWidget {
  const VideoActivityView({super.key, required this.activity});

  final VideoActivity activity;

  @override
  State<VideoActivityView> createState() => _VideoActivityViewState();
}

class _VideoActivityViewState extends State<VideoActivityView> {
  final LessonsController lessonsController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // A unique tag prevents controller conflicts if another mascot is used elsewhere.
    final mascotController = Get.put(
      TalkingMascotController(
        messages: ['First of all, let\'s watch a video!'],
      ),
      tag: 'video_activity_mascot_${widget.activity.videoId}',
    );

    return Stack(
      children: [
        // Layer 1: The mascot, always centered.
        Center(
          child: Obx(
            () => TalkingMascot(
              mascotSize: 220,
              bubbleText: mascotController.currentMessage,
              onTap: mascotController.nextMessage,
            ),
          ),
        ),

        // Layer 2: The button, aligned to the bottom.
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: DeviceUtils.getBottomNavigationBarHeight() + AppSizes.lg,
            ),
            child: Obx(() {
              return AnimatedOpacity(
                opacity: mascotController.isCompleted.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child:
                    mascotController.isCompleted.value
                        ? CustomButton(
                          label: 'Start Video',
                          onPressed: () {
                            widget.activity.isCompleted.value = false;
                            Get.to(
                              () => VideoPlayerScreen2(
                                videoId: widget.activity.videoId,
                                onVideoCompleted: () {
                                  widget.activity.isCompleted.value = true;
                                  print(widget.activity.isCompleted.value);
                                },
                              ),
                            );
                          },
                          width: DeviceUtils.getScreenWidth() * 0.6,
                        )
                        : const SizedBox.shrink(),
              );
            }),
          ),
        ),
      ],
    );
  }
}
