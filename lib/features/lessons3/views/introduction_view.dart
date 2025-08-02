import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';
import 'package:le_petit_davinci/features/lessons3/models/activity_model.dart';

class IntroductionView extends StatelessWidget {
  const IntroductionView({
    super.key,
    required this.lesson,
    required this.onStart,
  });

  final Lesson lesson;
  final VoidCallback onStart;

  @override
  Widget build(BuildContext context) {
    final mascotController = Get.put(
      TalkingMascotController(
        messages: [
          'Bonjour! Prêt pour une nouvelle leçon?',
          'Aujourd\'hui, nous allons apprendre: "${lesson.title}"',
          'Cette leçon comporte ${lesson.activities.length} activités.',
          'Es-tu prêt à commencer?',
        ],
      ),
    );
    return Stack(
      children: [
        Center(
          child: Obx(
            () => TalkingMascot(
              mascotSize: 220,
              bubbleText: mascotController.currentMessage,
              onTap: mascotController.nextMessage,
            ),
          ),
        ),
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
                          label: 'Start Lesson',
                          onPressed: onStart,
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
