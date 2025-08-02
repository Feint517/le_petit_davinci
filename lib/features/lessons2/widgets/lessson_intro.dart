import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/features/lessons2/controllers/lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons2/models/lesson_model.dart';
import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';

class LessonIntroWidget extends GetView<LessonController2> {
  const LessonIntroWidget({
    super.key,
    required this.lesson,
    this.mascotSize = 200,
  });

  final Lesson lesson;
  final double mascotSize;

  @override
  Widget build(BuildContext context) {
    // Get the mascot controller from our lesson controller
    final mascotController = controller.mascotController;

    if (mascotController == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        Gap(DeviceUtils.getScreenHeight() * 0.3),
        Center(
          child: Obx(
            () => TalkingMascot(
              mascotSize: mascotSize,
              bubbleText:
                  mascotController
                      .currentMessage, // Use dynamic message from controller
              onTap:
                  () =>
                      mascotController.nextMessage(), // Connect the tap handler
            ),
          ),
        ),
      ],
    );
  }
}
