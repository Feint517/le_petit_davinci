import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/lessons3/data/lessons_data3.dart';
import 'package:le_petit_davinci/features/lessons3/models/activity_model.dart';
import 'package:le_petit_davinci/features/lessons3/views/reward.dart';

class LessonsController3 extends GetxController {
  late final Lesson lessonData;
  late PageController pageController;

  // The current stage/page index
  var currentPage = 0.obs;
  var isLessonStarted = false.obs;

  // A subscription to listen to the activity's completion status.
  StreamSubscription? _completionSubscription;

  @override
  void onInit() {
    super.onInit();
    startLesson();

    // This worker will re-run our listener setup every time the page changes.
    ever(currentPage, (_) => _setupCompletionListener());
  }

  void startLesson() {
    lessonData = exampleLesson;
    currentPage.value = 0;
    isLessonStarted.value = false;
    pageController = PageController();
    _setupCompletionListener(); // Set up the listener for the first activity.
  }

  // Listens to the current activity's `isCompleted` flag.
  void _setupCompletionListener() {
    // Cancel any previous listener to prevent memory leaks.
    _completionSubscription?.cancel();
    _completionSubscription = lessonData
        .activities[currentPage.value]
        .isCompleted
        .listen((isDone) {
          if (isDone) {
            //? This ensures nextStage() is called only after the UI has finished building.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              nextStage();
            });
          }
        });
  }

  void beginActivities() {
    isLessonStarted.value = true;
  }

  // Called by an activity view when it initializes.
  /// This is the safe place to update state that affects the UI.
  // void onActivityInit(Activity activity) {
  //   if (activity is VideoActivity) {
  //     activity.isCompleted.value = true;
  //   }
  // }

  void nextStage() {
    if (!pageController.hasClients) return;
    if (currentPage.value < lessonData.activities.length - 1) {
      currentPage.value++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Lesson finished!
      Get.off(() => const RewardScreen());
    }
  }

  @override
  void onClose() {
    //? Cancel the subscription to prevent memory leaks when the screen is closed.
    _completionSubscription?.cancel();
    pageController.dispose();
    super.onClose();
  }
}
