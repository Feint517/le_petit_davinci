import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/lessons/models/activity_model.dart';
import 'package:le_petit_davinci/features/lessons/views/reward.dart';
import 'package:le_petit_davinci/services/progress_service.dart';

class LessonsController extends GetxController {
  LessonsController({required this.lessonData});

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
      // Get.off(() => const RewardScreen());
      _completeLessonAndUnlock();
    }
  }

  @override
  void onClose() {
    //? Cancel the subscription to prevent memory leaks when the screen is closed.
    _completionSubscription?.cancel();
    pageController.dispose();
    super.onClose();
  }

  Future<void> _completeLessonAndUnlock() async {
    try {
      // Read level metadata from navigation arguments
      final args = Get.arguments;
      int? levelNumber;
      String language = 'en';

      if (args is Map) {
        final ln = args['levelNumber'];
        final lang = args['language'];
        if (ln is int) levelNumber = ln;
        if (lang is String && lang.isNotEmpty) language = lang;
      }

      if (levelNumber != null && Get.isRegistered<ProgressService>()) {
        // Mark as completed by awarding stars (adjust if you prefer a different rule)
        await ProgressService.instance.setStars(language, levelNumber, 3);
        // Unlock the next level
        await ProgressService.instance.unlockNextIfNeeded(
          language,
          levelNumber,
        );
      }
    } catch (e) {
      debugPrint('Lesson completion persistence failed: $e');
    }
    Get.off(() => const RewardScreen());
  }
}
