import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            activity.prompt,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const Gap(20),
          if (activity.templateImagePath != null)
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(activity.templateImagePath!),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          const Gap(20),
          Padding(
            padding: EdgeInsets.only(
              bottom: DeviceUtils.getBottomNavigationBarHeight() + 16,
            ),
            child: CustomButton(
              label: 'Start Drawing',
              onPressed: () => _startDrawing(context),
            ),
          ),
          // Expanded(
          //   child: Container(
          //     margin: const EdgeInsets.all(16),
          //     decoration: BoxDecoration(
          //       border: Border.all(color: Colors.grey.shade300),
          //       borderRadius: BorderRadius.circular(12),
          //     ),
          //     child: const Center(child: Text('Drawing Canvas Here')),
          //   ),
          // ),
          // const Gap(20),
          // ElevatedButton(
          //   onPressed: () {
          //     // When the user is done, they press this button to complete the activity.
          //     activity.isCompleted.value = true;
          //   },
          //   child: const Text('I\'m Done!'),
          // ),
        ],
      ),
    );
  }
}
