import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/lessons/models/activity_model.dart';
import 'package:le_petit_davinci/features/lessons/views/reward.dart';

class LessonsController extends GetxController {
  final Lesson lessonData;
  final int levelNumber;
  final String language;

  LessonsController({
    required this.lessonData,
    required this.levelNumber,
    required this.language,
  });

  late final PageController pageController;
  final RxInt currentPage = 0.obs;

  //? A subscription to listen to the current activity's completion status.
  StreamSubscription? _completionSubscription;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    pageController.addListener(_onPageChanged);
    _setupCompletionListener();
  }

  @override
  void onClose() {
    pageController.dispose();
    _completionSubscription?.cancel();
    super.onClose();
  }

  void _onPageChanged() {
    final newPage = pageController.page?.round() ?? 0;
    if (newPage != currentPage.value) {
      currentPage.value = newPage;
      //? When the page changes, set up the listener for the new activity.
      _setupCompletionListener();
    }
  }

  void _setupCompletionListener() {
    _completionSubscription?.cancel();
    final activityIndex = currentPage.value; // No more -1 offset.

    if (activityIndex < lessonData.activities.length) {
      final activity = lessonData.activities[activityIndex];
      _completionSubscription = activity.isCompleted.listen((isDone) {
        if (isDone) {
          activity.dispose(); //? Clean up the completed activity's resources.
          WidgetsBinding.instance.addPostFrameCallback((_) => nextStage());
        }
      });
    }
  }

  /// Moves the lesson to the next page or completes it.
  void nextStage() {
    if (!pageController.hasClients) return;

    if (currentPage.value < lessonData.activities.length - 1) {
      //? We just tell the PageView to move. The listener will handle the state.
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    } else {
      //? If we are on the last page, complete the lesson.
      _completeLessonAndUnlock();
    }
  }

  /// Persists the lesson completion and unlocks the next level.
  Future<void> _completeLessonAndUnlock() async {
    // try {
    //   if (Get.isRegistered<ProgressService>()) {
    //     // Mark as completed by awarding 3 stars.
    //     await ProgressService.instance.setStars(language, levelNumber, 3);
    //     // Unlock the next level.
    //     await ProgressService.instance.unlockNextIfNeeded(
    //       language,
    //       levelNumber,
    //     );
    //   }
    // } catch (e) {
    //   debugPrint('Lesson completion persistence failed: $e');
    // }
    // Navigate to the reward screen.
    Get.off(() => const RewardScreen());
  }
}
