import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';
import 'package:le_petit_davinci/features/lessons/models/lesson_template_model.dart';
import 'package:le_petit_davinci/features/lessons3/models/activity_model.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/features/studio/views/drawing_canvas_screen.dart';

class DrawingActivityView extends StatelessWidget {
  const DrawingActivityView({super.key, required this.activity});

  final DrawingActivity activity;

  void _startDrawing(BuildContext context) {
    // 1. Create the template for the drawing canvas using the helper from the old feature.
    final template = LessonTemplateHelper.createColoringTemplate(
      id: activity.hashCode.toString(), // Use a unique ID for the template
      title: 'Lesson Activity',
      templatePath: activity.templateImagePath ?? '',
      instruction: activity.prompt,
      suggestedColors: activity.suggestedColors,
    );

    // 2. Ensure the StudioController is ready.
    Get.put(StudioController());

    // 3. Navigate to the main drawing screen.
    Get.to(
      () => DrawingCanvasScreen(
        template: template,
        isLessonMode: true,
        // 4. Provide the completion callback. This is the key to advancing the lesson.
        onComplete: (artworkId) {
          // When the user finishes drawing, mark this activity as complete.
          activity.isCompleted.value = true;
          // The DrawingCanvasScreen should handle its own Get.back(), so we don't need it here.
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mascotController = Get.put(
      TalkingMascotController(
        messages: [
          'Super! Prêt à dessiner?',
          activity.prompt, // The mascot will now deliver the prompt.
        ],
      ),
      // Use a unique tag to avoid controller conflicts within the same lesson.
      tag: 'drawing_activity_mascot_${activity.hashCode}',
    );
    return Stack(
      alignment: Alignment.center,
      children: [
        Obx(
          () => TalkingMascot(
            mascotSize: 180,
            bubbleText: mascotController.currentMessage,
            onTap: mascotController.nextMessage,
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
                opacity: mascotController.isCompleted.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child:
                    mascotController.isCompleted.value
                        ? CustomButton(
                          label: 'Start Drawing',
                          width: DeviceUtils.getScreenWidth() * 0.6,
                          onPressed: () => _startDrawing(context),
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
