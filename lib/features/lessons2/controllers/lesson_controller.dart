import 'package:get/get.dart';
import 'package:le_petit_davinci/features/lessons2/models/lesson_model.dart';
import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';
import 'package:le_petit_davinci/features/video_player/views/video_player.dart';

enum LessonPhase { introduction, video, activities, completion }

enum VideoCompletionStatus { notStarted, inProgress, completed }

class LessonController2 extends GetxController {
  //* Lesson data
  final lesson = Rx<Lesson?>(null);

  TalkingMascotController? mascotController;

  //* control button appearance
  final RxBool shouldShowButton = true.obs;
  void hideButton() => shouldShowButton.value = false;
  void showButton() => shouldShowButton.value = true;

  //* Current state tracking
  final currentPhase = LessonPhase.introduction.obs;
  final currentActivityIndex = 0.obs;
  final isVideoCompleted = false.obs;
  final isActivityCompleted = false.obs;
  final lessonProgress = 0.0.obs;

  //* Video status tracking
  final Rx<VideoCompletionStatus> videoStatus =
      VideoCompletionStatus.notStarted.obs;

  void _startVideoSequence() {
    videoStatus.value = VideoCompletionStatus.notStarted;
    Future.delayed(const Duration(seconds: 2), () {
      videoStatus.value = VideoCompletionStatus.inProgress;

      if (lesson.value?.youtubeVideoId != null &&
          lesson.value!.youtubeVideoId.isNotEmpty) {
        Get.to(
          () => VideoPlayerScreen(videoId: lesson.value!.youtubeVideoId),
          transition: Transition.rightToLeft,
        );
      }
    });
  }

  //* Set the lesson and initialize
  void setLesson(Lesson newLesson) {
    lesson.value = newLesson;
    // resetLesson();
    _initializeMascotController();
  }

  void _initializeMascotController() {
    //? Remove existing controller if any
    if (Get.isRegistered<TalkingMascotController>(tag: 'intro_mascot')) {
      Get.delete<TalkingMascotController>(tag: 'intro_mascot');
    }

    //? Create new controller with current lesson data
    mascotController = Get.put(
      TalkingMascotController(
        messages: [
          "Welcome back Alex!",
          "Ready to learn ${lesson.value?.title ?? 'this lesson'}!",
        ],
        onCompleted: () {
          //? Show the button when all messages are shown
          showButton();
        },
      ),
      tag: 'intro_mascot',
    );

    //? Initially hide the button until dialogue is complete
    hideButton();
  }

  //* Reset all progress
  void resetLesson() {
    currentPhase.value = LessonPhase.introduction;
    currentActivityIndex.value = 0;
    isVideoCompleted.value = false;
    isActivityCompleted.value = false;
    lessonProgress.value = 0.0;
    videoStatus.value = VideoCompletionStatus.notStarted;
    update();
  }

  //* Progress to next phase
  void moveToNextPhase() {
    switch (currentPhase.value) {
      case LessonPhase.introduction:
        currentPhase.value = LessonPhase.video;
        updateProgress(0.25);
        _startVideoSequence();
        break;

      case LessonPhase.video:
        if (isVideoCompleted.value) {
          currentPhase.value = LessonPhase.activities;
          updateProgress(0.50);
        }
        break;

      case LessonPhase.activities:
        if (isActivityCompleted.value) {
          final hasMoreActivities =
              currentActivityIndex.value <
              (lesson.value?.activities.length ?? 1) - 1;

          if (hasMoreActivities) {
            currentActivityIndex.value++;
            isActivityCompleted.value = false;
            updateProgress(
              0.5 +
                  0.5 *
                      (currentActivityIndex.value + 1) /
                      (lesson.value?.activities.length ?? 1),
            );
          } else {
            currentPhase.value = LessonPhase.completion;
            updateProgress(1.0);
          }
        }
        break;

      case LessonPhase.completion:
        // Exit lesson
        Get.back();
        break;
    }
  }

  //* Handle video completion
  void markVideoCompleted() {
    isVideoCompleted.value = true;
    videoStatus.value = VideoCompletionStatus.completed;
    showButton();
    update();
  }

  //* Handle activity completion
  void markActivityCompleted() {
    isActivityCompleted.value = true;
    update();
  }

  //* Get current activity (if in activities phase)
  LessonActivity? get currentActivity {
    if (currentPhase.value != LessonPhase.activities ||
        lesson.value == null ||
        lesson.value!.activities.isEmpty ||
        currentActivityIndex.value >= lesson.value!.activities.length) {
      return null;
    }

    return lesson.value!.activities[currentActivityIndex.value];
  }

  //* Update progress value
  void updateProgress(double value) {
    lessonProgress.value = value;
  }

  //* Check if navigation to next phase is possible
  bool get canProceedToNext {
    switch (currentPhase.value) {
      case LessonPhase.introduction:
        return true;
      case LessonPhase.video:
        return isVideoCompleted.value;
      case LessonPhase.activities:
        return isActivityCompleted.value;
      case LessonPhase.completion:
        return true;
    }
  }
}
