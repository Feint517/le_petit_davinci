import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';
import 'package:le_petit_davinci/features/levels/views/activities/drawing_view.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';

class DrawingActivity extends Activity {
  DrawingActivity({
    required this.prompt,
    this.templateImagePath,
    this.suggestedColors,
  }) {
    // The model now creates and configures its own mascot controller.
    mascotController = TalkingMascotController(
      messages: ['Super! Prêt à dessiner?', prompt],
    );

    // Listen to the mascot controller to know when the intro is done.
    ever(mascotController.isCompleted, (bool isDone) {
      if (isDone) {
        // Use a small delay to allow the button animation to finish.
        Future.delayed(const Duration(seconds: 1), () {
          isIntroCompleted.value = true;
        });
      }
    });
  }

  final String prompt;
  final String? templateImagePath;
  final List<String>? suggestedColors;

  /// State specific to this activity: is the intro mascot done talking?
  late final TalkingMascotController mascotController;
  final RxBool isIntroCompleted = false.obs;

  /// The drawing canvas will call this when the user is done drawing.
  /// This triggers the main `isCompleted` flag, advancing the lesson.
  void markDrawingAsCompleted() {
    markCompleted(); // Use the new unified helper method
  }

  @override
  Widget build(BuildContext context) {
    return DrawingActivityView(activity: this);
  }

  @override
  void dispose() {
    // Clean up the controller when the activity is disposed.
    mascotController.dispose();
  }
}
