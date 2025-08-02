import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/features/lessons2/controllers/lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons2/models/lesson_model.dart';
import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';

class LessonVideoWidget extends GetView<LessonController2> {
  const LessonVideoWidget({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.videoStatus.value) {
        case VideoCompletionStatus.notStarted:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const Gap(AppSizes.lg),
              Text(
                "The video is starting...",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ],
          );

        case VideoCompletionStatus.inProgress:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Video is playing...",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Gap(AppSizes.md),
              const CircularProgressIndicator(),
            ],
          );

        case VideoCompletionStatus.completed:
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Gap(DeviceUtils.getScreenHeight() * 0.3),
              TalkingMascot(
                bubbleText: "Did you enjoy the video?",
                mascotSize: 200,
                onTap: () {
                  controller.markVideoCompleted();
                  controller.moveToNextPhase();
                },
              ),
            ],
          );
      }
    });
  }
}
