import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/lessons3/data/lessons_data3.dart';
import 'package:le_petit_davinci/features/lessons3/models/activity_model.dart';

class LessonsController3 extends GetxController {
  late final Lesson lessonData;
  late PageController pageController;

  // The current stage/page index
  var currentPage = 0.obs;
  var isLessonStarted = false.obs;

  @override
  void onInit() {
    super.onInit();
    startLesson();
  }

  void startLesson() {
    lessonData = exampleLesson; // Make sure exampleLesson is imported/accessible
    currentPage.value = 0;
    isLessonStarted.value = false;
    pageController = PageController();
  }

  void beginActivities() {
    isLessonStarted.value = true;
  }

  // Called by an activity view when it initializes.
  /// This is the safe place to update state that affects the UI.
  void onActivityInit(Activity activity) {
    // For non-interactive activities like a video intro, we can
    // mark them as "completed" as soon as they are displayed.
    if (activity is VideoActivity) {
      activity.isCompleted.value = true;
    }
    // For other activities like DrawingActivity, completion is handled
    // by user interaction (e.g., a "Done" button), so we do nothing here.
  }

  void nextStage() {
    if (currentPage.value < lessonData.activities.length - 1) {
      currentPage.value++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Lesson finished!
      Get.back(); // Or navigate to a completion screen
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
