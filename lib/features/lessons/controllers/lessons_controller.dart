import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/lessons/models/activity_model.dart';
import 'package:le_petit_davinci/features/lessons/views/reward.dart';

class LessonsController3 extends GetxController {
  LessonsController3({required this.lessonData});

  final Lesson lessonData;
  late PageController pageController;

  //* The current stage/page index
  var currentPage = 0.obs;
  var isLessonStarted = false.obs;

  //? A subscription to listen to the activity's completion status.
  StreamSubscription? _completionSubscription;

  @override
  void onInit() {
    super.onInit();
    startLesson();

    //? This worker will re-run our listener setup every time the page changes.
    ever(currentPage, (_) => _setupCompletionListener());
  }

  void startLesson() {
    currentPage.value = 0;
    isLessonStarted.value = false;
    pageController = PageController();
    _setupCompletionListener();
  }

  //? Listens to the current activity's `isCompleted` flag.
  void _setupCompletionListener() {
    //? Cancel any previous listener to prevent memory leaks.
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

  void nextStage() {
    if (!pageController.hasClients) return;
    if (currentPage.value < lessonData.activities.length - 1) {
      currentPage.value++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      //? Lesson finished!
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
