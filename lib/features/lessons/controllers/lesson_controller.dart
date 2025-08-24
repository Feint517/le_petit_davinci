import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/lessons/models/activity_model.dart';
import 'package:le_petit_davinci/features/lessons/views/reward.dart';
import 'package:le_petit_davinci/services/progress_service.dart';

class LessonsController extends GetxController {
  // --- Dependencies are now explicit and required ---
  final Lesson lessonData;
  final int levelNumber;
  final String language;

  LessonsController({
    required this.lessonData,
    required this.levelNumber,
    required this.language,
  });

  late final PageController pageController;

  /// The current page index in the PageView.
  /// Page 0 is the intro, pages 1+ are activities.
  final RxInt currentPage = 0.obs;

  /// A subscription to listen to the current activity's completion status.
  StreamSubscription? _completionSubscription;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();

    // This worker will re-run our listener setup every time the page changes.
    ever(currentPage, (_) => _setupCompletionListener());

    // Set up the listener for the initial state (the first activity).
    _setupCompletionListener();
  }

  void _setupCompletionListener() {
    _completionSubscription?.cancel();
    final activityIndex = currentPage.value; // No more -1 offset.

    if (activityIndex < lessonData.activities.length) {
      final activity = lessonData.activities[activityIndex];
      _completionSubscription = activity.isCompleted.listen((isDone) {
        if (isDone) {
          activity.dispose(); // Clean up the completed activity's resources.
          WidgetsBinding.instance.addPostFrameCallback((_) => nextStage());
        }
      });
    }
  }

  /// Moves the lesson to the next page or completes it.
  void nextStage() {
    if (!pageController.hasClients) return;

    // We check against `lessonData.activities.length` because there's one extra page for the intro.
    if (currentPage.value < lessonData.activities.length) {
      currentPage.value++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    } else {
      // Lesson finished!
      _completeLessonAndUnlock();
    }
  }

  @override
  void onClose() {
    _completionSubscription?.cancel();
    pageController.dispose();
    super.onClose();
  }

  /// Persists the lesson completion and unlocks the next level.
  Future<void> _completeLessonAndUnlock() async {
    try {
      if (Get.isRegistered<ProgressService>()) {
        // Mark as completed by awarding 3 stars.
        await ProgressService.instance.setStars(language, levelNumber, 3);
        // Unlock the next level.
        await ProgressService.instance.unlockNextIfNeeded(
          language,
          levelNumber,
        );
      }
    } catch (e) {
      debugPrint('Lesson completion persistence failed: $e');
    }
    // Navigate to the reward screen.
    Get.off(() => const RewardScreen());
  }
}
