import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/widgets/drawing_area.dart';
import 'package:le_petit_davinci/features/levels/models/activities/activities.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/features/levels/widgets/activity_intro_wrapper.dart';

class DrawingActivityView extends StatelessWidget {
  const DrawingActivityView({super.key, required this.activity});

  final DrawingActivity activity;

  @override
  Widget build(BuildContext context) {
    Get.put(StudioController(), permanent: true);

    return ActivityIntroWrapper(
      activity: _buildDrawingCanvas(),
      mascotMixin: activity,
      startButtonText: 'Start Drawing',
      onStartPressed: () {
        activity.isIntroCompleted.value = true;
      },
    );
  }

  Widget _buildDrawingCanvas() {
    final lessonDrawingController = Get.put(
      DrawingController(),
      tag: activity.hashCode.toString(),
    );

    lessonDrawingController.setStyle(color: Colors.blue, strokeWidth: 5.0);

    return DrawingArea(
      drawingController: lessonDrawingController,
      templateImagePath: activity.templateImagePath,
    );
  }
}
