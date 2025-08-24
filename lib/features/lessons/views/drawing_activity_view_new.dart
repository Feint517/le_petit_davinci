import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';
import 'package:le_petit_davinci/features/lessons/models/drawing_activity_model.dart';
import 'package:le_petit_davinci/features/lessons/models/lesson_template_model.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/features/studio/views/drawing_canvas_screen.dart';

class DrawingActivityView extends StatelessWidget {
  const DrawingActivityView({super.key, required this.activity});

  final DrawingActivity activity;

  @override
  Widget build(BuildContext context) {
    // Ensure the StudioController is ready for when the canvas appears.
    Get.put(StudioController(), permanent: true);

    return Obx(() {
      // The view simply switches based on the model's state.
      if (!activity.isIntroCompleted.value) {
        // --- Intro UI ---
        return _buildIntroUI();
      } else {
        // --- Main Activity UI ---
        return _buildDrawingCanvas();
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
                opacity: activity.mascotController.isCompleted.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: activity.mascotController.isCompleted.value
                    ? CustomButton(
                        label: 'Start Drawing',
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

  // Helper widget for the main drawing canvas.
  Widget _buildDrawingCanvas() {
    final template = LessonTemplateHelper.createColoringTemplate(
      id: activity.hashCode.toString(),
      title: 'Lesson Activity',
      templatePath: activity.templateImagePath ?? '',
      instruction: activity.prompt,
      suggestedColors: activity.suggestedColors,
    );

    return DrawingCanvasScreen(
      template: template,
      isLessonMode: true,
      onComplete: (artworkId) {
        activity.markDrawingAsCompleted();
      },
    );
  }
}