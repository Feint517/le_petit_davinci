// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/lessons/models/lesson_model.dart';
import 'package:le_petit_davinci/features/lessons/models/lesson_activity_model.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/features/studio/models/artwork_model.dart';
import 'package:le_petit_davinci/features/studio/views/drawing_canvas_screen.dart';
import 'package:le_petit_davinci/services/storage_service.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/services/youtube_service.dart';

enum LessonPhase { introduction, video, activities, completion }

class Template {
  Template({required this.templateImagePath, required this.templateName});

  final String templateImagePath;
  final String templateName;
}

class LessonController extends GetxController {
  LessonController({required this.lesson});

  final LessonModel lesson;
  final videoTitle = ''.obs;

  void fetchVideoDetails({required String videoId}) async {
    isLoading.value = true;
    try {
      final video = await YouTubeApiService.fetchVideoDetails(videoId);
      if (video != null) {
        videoTitle.value = video.title;
        print(videoTitle.value);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  final DrawingController drawingController = DrawingController();

  void _initializeDrawingController() {
    drawingController.setPaintContent(SimpleLine());
    drawingController.setStyle(color: AppColors.accent);
  }

  final StorageService _storageService = Get.find<StorageService>();
  final FlutterTts _tts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();

  //* Current lesson and phase
  final Rx<LessonModel?> currentLesson = Rx<LessonModel?>(null);
  final Rx<LessonPhase> currentPhase = LessonPhase.introduction.obs;
  final RxInt currentActivityIndex = 0.obs;
  final RxBool isVideoCompleted = false.obs;
  final RxBool isLessonCompleted = false.obs;

  //* Activity progress tracking
  final RxList<ActivityProgress> activityProgressList =
      <ActivityProgress>[].obs;
  final RxDouble lessonProgress = 0.0.obs;
  final Rx<DateTime?> lessonStartTime = Rx<DateTime?>(null);
  final RxBool isLoading = false.obs;

  //* Activity state management
  final RxBool isActivityCompleted = false.obs;
  final RxDouble currentActivityScore = 0.0.obs;
  final RxInt activityAttempts = 0.obs;
  final Rx<DateTime?> activityStartTime = Rx<DateTime?>(null);

  //* Selection activity state
  final RxList<int> selectedItemIndices = <int>[].obs;

  //* Drawing activity integration
  StudioController? _drawingController;

  //* Audio feedback
  final RxBool isTTSEnabled = true.obs;
  final RxString currentLanguageCode = 'en-US'.obs;

  @override
  void onInit() {
    super.onInit();
    currentLesson.value = lesson;
    _initializeTTS();
    _initializeAudio();
    fetchVideoDetails(videoId: lesson.videoId);
    _initializeDrawingController();
  }

  @override
  void onClose() {
    _tts.stop();
    _audioPlayer.dispose();
    _drawingController?.dispose();
    super.onClose();
  }

  void _initializeTTS() async {
    await _tts.setLanguage(currentLanguageCode.value);
    await _tts.setSpeechRate(0.5);
    await _tts.setVolume(0.8);
    await _tts.setPitch(1.2);
  }

  void _initializeAudio() {
    // Initialize audio player for sound effects
  }

  //* Start a lesson
  Future<void> startLesson(LessonModel? passedLesson) async {
    try {
      isLoading.value = true;

      // Use the passed lesson if provided, otherwise use the controller's lesson
      final lessonToUse = passedLesson ?? lesson;
      currentLesson.value = lessonToUse;

      currentPhase.value = LessonPhase.introduction;
      currentActivityIndex.value = 0;
      isVideoCompleted.value = false;
      isLessonCompleted.value = false;
      lessonStartTime.value = DateTime.now();

      // Set language based on lesson
      currentLanguageCode.value =
          lesson.language == LessonLanguage.french ? 'fr-FR' : 'en-US';
      _initializeTTS();

      // Load existing progress if any
      await _loadLessonProgress(lessonToUse.id);

      // Calculate initial progress
      _updateLessonProgress();

      // Play welcome sound
      await _playSound(AudioAssets.correctSound);

      // Welcome TTS
      if (isTTSEnabled.value) {
        await _speakText(
          lesson.language == LessonLanguage.french
              ? "Bienvenue dans cette leçon sur ${lesson.title}!"
              : "Welcome to this lesson about ${lesson.title}!",
        );
      }
    } catch (e) {
      debugPrint('Error starting lesson: $e');
      Get.snackbar('Error', 'Failed to start lesson');
    } finally {
      isLoading.value = false;
    }
  }

  //* Load lesson progress from storage
  Future<void> _loadLessonProgress(String lessonId) async {
    try {
      final progressData =
          _storageService.getList('lesson_progress_$lessonId') ?? [];
      activityProgressList.value =
          progressData
              .map(
                (json) =>
                    ActivityProgress.fromJson(Map<String, dynamic>.from(json)),
              )
              .toList();

      // Check if video was completed
      final videoProgress =
          _storageService.read<bool>('video_completed_$lessonId') ?? false;
      isVideoCompleted.value = videoProgress;

      // Update current activity index based on progress
      final completedActivities =
          activityProgressList.where((p) => p.isCompleted).length;
      currentActivityIndex.value = completedActivities;
    } catch (e) {
      debugPrint('Error loading lesson progress: $e');
    }
  }

  //* Navigate through lesson phases
  void moveToNextPhase() {
    print('Moving to next phase from: ${currentPhase.value}');

    switch (currentPhase.value) {
      case LessonPhase.introduction:
        currentPhase.value = LessonPhase.video;
        print('Moved to video phase');
        break;

      case LessonPhase.video:
        if (!isVideoCompleted.value) {
          print('Video not completed yet');
          return;
        }

        final lesson = currentLesson.value;
        print('Video phase complete. Lesson: ${lesson?.id}');
        print('Has activities: ${lesson?.hasActivities}');
        print('Activities count: ${lesson?.activities.length}');

        if (lesson?.activities.isNotEmpty == true) {
          currentPhase.value = LessonPhase.activities;
          print('Moving to activities phase');
          _startFirstActivity();
        } else {
          print('No activities found, completing lesson');
          _completeLesson();
        }
        break;

      case LessonPhase.activities:
        if (!isActivityCompleted.value) {
          print('Current activity not completed yet');
          return;
        }

        if (_allActivitiesCompleted()) {
          _completeLesson();
        } else {
          _moveToNextActivity();
        }
        break;

      case LessonPhase.completion:
        Get.back();
        break;
    }
  }

  void goToPrevious() {
    switch (currentPhase.value) {
      case LessonPhase.video:
        currentPhase.value = LessonPhase.introduction;
        break;
      case LessonPhase.activities:
        if (currentActivityIndex.value > 0) {
          currentActivityIndex.value--;
          isActivityCompleted.value = false;
        } else {
          currentPhase.value = LessonPhase.video;
        }
        break;
      case LessonPhase.completion:
        currentPhase.value = LessonPhase.activities;
        break;
      default:
        break;
    }
  }

  void handleBackButton() {
    if (currentPhase.value == LessonPhase.completion ||
        currentPhase.value == LessonPhase.introduction) {
      Get.back();
    } else {
      showExitDialog();
    }
  }

  void showExitDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.orange, size: 20.sp),
            Gap(8.w),
            Text(
              lesson.language == LessonLanguage.french
                  ? 'Quitter la leçon?'
                  : 'Exit Lesson?',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
          ],
        ),
        content: Text(
          lesson.language == LessonLanguage.french
              ? 'Votre progression sera sauvegardée. Voulez-vous vraiment quitter?'
              : 'Your progress will be saved. Do you really want to exit?',
          style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              lesson.language == LessonLanguage.french
                  ? 'Continuer'
                  : 'Continue',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              lesson.language == LessonLanguage.french ? 'Quitter' : 'Exit',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showRestartDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(Icons.restart_alt, color: AppColors.primary, size: 20.sp),
            Gap(8.w),
            Text(
              lesson.language == LessonLanguage.french
                  ? 'Recommencer?'
                  : 'Restart Lesson?',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
          ],
        ),
        content: Text(
          lesson.language == LessonLanguage.french
              ? 'Cela effacera votre progression actuelle.'
              : 'This will clear your current progress.',
          style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              lesson.language == LessonLanguage.french ? 'Annuler' : 'Cancel',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              resetLesson();
              startLesson(lesson);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              lesson.language == LessonLanguage.french
                  ? 'Recommencer'
                  : 'Restart',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //* Video completion handler
  Future<void> markVideoAsCompleted() async {
    isVideoCompleted.value = true;
    await _storageService.write(
      'video_completed_${currentLesson.value?.id}',
      true,
    );

    await _playSound(AudioAssets.correctSound);

    if (isTTSEnabled.value) {
      await _speakText(
        currentLesson.value?.language == LessonLanguage.french
            ? "Excellente vidéo! Maintenant, passons aux activités!"
            : "Great video! Now let's move on to the activities!",
      );
    }
    _updateLessonProgress();
  }

  //* Activity management
  void _startFirstActivity() {
    final lesson = currentLesson.value;
    print('Starting first activity...');
    print('Lesson activities: ${lesson?.activities.length}');

    if (lesson?.activities.isNotEmpty == true) {
      currentActivityIndex.value = 0;
      print('Starting activity at index: ${currentActivityIndex.value}');
      print('Activity: ${lesson!.activities[0]}');
      _startCurrentActivity();
    } else {
      print('ERROR: No activities to start!');
      _completeLesson();
    }
  }

  void _startCurrentActivity() {
    isActivityCompleted.value = false;
    currentActivityScore.value = 0.0;
    activityAttempts.value = 0;
    activityStartTime.value = DateTime.now();

    final activity = getCurrentActivity();
    if (activity != null) {
      // Initialize activity based on type
      switch (activity.type) {
        case ActivityType.drawLetters:
        case ActivityType.coloringTemplate:
          _initializeDrawingActivity(activity);
          break;
        default:
          break;
      }

      // Speak activity instruction
      if (isTTSEnabled.value) {
        _speakText(activity.instruction);
      }
    }
  }

  void _moveToNextActivity() {
    if (currentActivityIndex.value <
        (currentLesson.value?.activities.length ?? 0) - 1) {
      currentActivityIndex.value++;
      _startCurrentActivity();
    } else {
      _completeLesson();
    }
  }

  void _initializeDrawingActivity(LessonActivity activity) {
    // For drawing activities, we'll navigate to the Studio with parameters
    // instead of trying to embed it directly

    if (activity is DrawLettersActivity) {
      // For letter drawing, create template from the first letter
      if (activity.letters.isNotEmpty) {
        final firstLetter = activity.letters.first;
        final template = TemplateModel(
          id: 'lesson_letter_${firstLetter.letter}',
          name: 'Lettre ${firstLetter.letter}',
          templateImagePath:
              'assets/images/templates/alphabets/printable_${firstLetter.letter.toUpperCase()}.png',
          category: TemplateCategory.educational,
          difficulty: 1,
          colors: [
            '#FF0000', // Red
            '#00FF00', // Green
            '#0000FF', // Blue
            '#FFFF00', // Yellow
            '#FFA500', // Orange
            '#800080', // Purple
            '#000000', // Black
            '#FFFFFF', // White
          ],
          educationalPrompt: activity.instruction,
          previewImagePath: "", // Optional: add preview if available
        );
        Get.put(StudioController());

        // Navigate to drawing screen with template
        // Get.to(
        //   () => DrawingCanvasScreen(
        //     template: template,
        //     isLessonMode: true,
        //     onComplete: (artworkId) {
        //       _handleDrawingCompletion(artworkId);
        //     },
        //   ),
        // );
      }
    } else if (activity is ColoringTemplateActivity) {
      // For coloring activities
      final template = TemplateModel(
        id: 'lesson_coloring_${activity.id}',
        name: activity.title,
        templateImagePath: activity.templateImagePath,
        category: TemplateCategory.educational,
        difficulty: 1,
        colors: activity.suggestedColors,
        educationalPrompt: activity.coloringPrompt,
        previewImagePath: "",
      );
      Get.put(StudioController());

      // Navigate to drawing screen with template
      Get.to(
        () => DrawingCanvasScreen(
          template: template,
          isLessonMode: true,
          onComplete: (artworkId) {
            _handleDrawingCompletion(artworkId);
          },
        ),
      );
    }
  }

  void _handleDrawingCompletion(String artworkId) {
    // Mark the drawing activity as completed
    completeCurrentActivity(
      score: 0.9, // Good score for completing drawing
      metadata: {
        'artworkId': artworkId,
        'completedAt': DateTime.now().toIso8601String(),
      },
    );
  }

  Future<void> submitDrawingActivity() async {
    // This method is now simplified since the actual drawing
    // happens in the Studio screen
    final activity = getCurrentActivity();
    if (activity?.type != ActivityType.drawLetters &&
        activity?.type != ActivityType.coloringTemplate) {
      return;
    }

    // The drawing completion is handled by the callback
    // from DrawingCanvasScreen, so this method might not be needed
  }

  LessonActivity? getCurrentActivity() {
    final lesson = currentLesson.value;
    if (lesson == null ||
        currentActivityIndex.value >= lesson.activities.length) {
      return null;
    }
    return lesson.activities[currentActivityIndex.value];
  }

  //* Activity completion
  Future<void> completeCurrentActivity({
    required double score,
    Map<String, dynamic>? metadata,
  }) async {
    final activity = getCurrentActivity();
    if (activity == null) return;

    final timeSpent =
        activityStartTime.value != null
            ? DateTime.now().difference(activityStartTime.value!)
            : Duration.zero;

    final progress = ActivityProgress(
      activityId: activity.id,
      lessonId: currentLesson.value!.id,
      isCompleted: true,
      completedAt: DateTime.now(),
      score: score,
      attempts: activityAttempts.value + 1,
      timeSpent: timeSpent,
      metadata: metadata,
    );

    // Update progress list
    final existingIndex = activityProgressList.indexWhere(
      (p) => p.activityId == activity.id,
    );

    if (existingIndex != -1) {
      activityProgressList[existingIndex] = progress;
    } else {
      activityProgressList.add(progress);
    }

    // Save progress
    await _saveLessonProgress();

    isActivityCompleted.value = true;
    currentActivityScore.value = score;

    // Play completion sound
    await _playSound(
      score >= 0.8 ? AudioAssets.victorySound : AudioAssets.correctSound,
    );

    // Provide feedback
    if (isTTSEnabled.value) {
      final isGoodScore = score >= 0.8;
      final feedback =
          currentLesson.value?.language == LessonLanguage.french
              ? (isGoodScore
                  ? "Excellent travail!"
                  : "Bien joué! Tu peux faire encore mieux!")
              : (isGoodScore
                  ? "Excellent work!"
                  : "Good job! You can do even better!");
      await _speakText(feedback);
    }

    _updateLessonProgress();
  }

  bool _allActivitiesCompleted() {
    final lesson = currentLesson.value;
    if (lesson == null) return false;

    return activityProgressList.where((p) => p.isCompleted).length >=
        lesson.activities.length;
  }

  //* Lesson completion
  Future<void> _completeLesson() async {
    currentPhase.value = LessonPhase.completion;
    isLessonCompleted.value = true;

    // Calculate final lesson progress
    final finalProgress = _calculateFinalProgress();
    lessonProgress.value = finalProgress;

    // Update lesson status in storage
    await _markLessonAsCompleted();

    // Play completion celebration
    await _playSound(AudioAssets.victorySound);

    if (isTTSEnabled.value) {
      await _speakText(
        currentLesson.value?.language == LessonLanguage.french
            ? "Félicitations! Tu as terminé cette leçon!"
            : "Congratulations! You've completed this lesson!",
      );
    }
  }

  double _calculateFinalProgress() {
    final lesson = currentLesson.value;
    if (lesson == null) return 0.0;

    double totalWeight = 1.0; // Video weight
    double completedWeight = isVideoCompleted.value ? 1.0 : 0.0;

    // Add activity weights
    for (final activity in lesson.activities) {
      totalWeight += 1.0;
      final progress = activityProgressList.firstWhereOrNull(
        (p) => p.activityId == activity.id && p.isCompleted,
      );
      if (progress != null) {
        completedWeight += progress.score;
      }
    }

    return totalWeight > 0 ? completedWeight / totalWeight : 0.0;
  }

  Future<void> _markLessonAsCompleted() async {
    final lesson = currentLesson.value;
    if (lesson == null) return;

    final completionData = {
      'lessonId': lesson.id,
      'completedAt': DateTime.now().toIso8601String(),
      'finalScore': lessonProgress.value,
      'totalTimeSpent':
          lessonStartTime.value != null
              ? DateTime.now().difference(lessonStartTime.value!).inMinutes
              : 0,
    };

    await _storageService.write(
      'lesson_completion_${lesson.id}',
      completionData,
    );
  }

  //* Progress management
  void _updateLessonProgress() {
    final lesson = currentLesson.value;
    if (lesson == null) return;

    double videoProgress = isVideoCompleted.value ? 0.4 : 0.0; // 40% for video
    double activitiesProgress = 0.0;

    if (lesson.activities.isNotEmpty) {
      final completedActivities =
          activityProgressList.where((p) => p.isCompleted).length;
      activitiesProgress =
          (completedActivities / lesson.activities.length) *
          0.6; // 60% for activities
    }

    lessonProgress.value = videoProgress + activitiesProgress;
  }

  Future<void> _saveLessonProgress() async {
    final lesson = currentLesson.value;
    if (lesson == null) return;

    final progressData = activityProgressList.map((p) => p.toJson()).toList();
    await _storageService.setList('lesson_progress_${lesson.id}', progressData);
  }

  //* Audio and TTS methods
  Future<void> _speakText(String text) async {
    try {
      await _tts.speak(text);
    } catch (e) {
      debugPrint('TTS Error: $e');
    }
  }

  Future<void> _playSound(String soundPath) async {
    try {
      await _audioPlayer.setAsset(soundPath);
      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Audio Error: $e');
    }
  }

  void toggleTTS() {
    isTTSEnabled.value = !isTTSEnabled.value;
  }

  //* Activity-specific methods
  void toggleItemSelection(int index) {
    if (selectedItemIndices.contains(index)) {
      selectedItemIndices.remove(index);
    } else {
      selectedItemIndices.add(index);
    }
  }

  Future<void> submitCurrentSelections() async {
    await submitSelectItemsAnswer(selectedItemIndices.toList());
    selectedItemIndices.clear();
  }

  Future<void> submitSelectItemsAnswer(List<int> selectedIndices) async {
    final activity = getCurrentActivity();
    if (activity is! SelectItemsActivity) return;

    activityAttempts.value++;

    // Calculate score based on correct selections
    final correctSelections = activity.correctIndices.toSet();
    final userSelections = selectedIndices.toSet();

    final correctCount = correctSelections.intersection(userSelections).length;
    final incorrectCount = userSelections.difference(correctSelections).length;
    final missedCount = correctSelections.difference(userSelections).length;

    double score = 0.0;
    if (correctSelections.isNotEmpty) {
      score =
          (correctCount - incorrectCount - missedCount) /
          correctSelections.length;
      score = score.clamp(0.0, 1.0);
    }

    await completeCurrentActivity(
      score: score,
      metadata: {
        'selectedIndices': selectedIndices,
        'correctIndices': activity.correctIndices,
        'attempts': activityAttempts.value,
      },
    );
  }

  // Future<void> submitDrawingActivity() async {
  //   final activity = getCurrentActivity();
  //   if (activity?.type != ActivityType.drawLetters &&
  //       activity?.type != ActivityType.coloringTemplate) {
  //     return;
  //   }

  //   // Save the drawing
  //   if (_drawingController != null) {
  //     await _drawingController!.saveArtwork(
  //       customTitle: '${activity!.title} - ${DateTime.now().toLocal()}',
  //     );
  //   }

  //   // For now, give a good score if they drew something
  //   final hasDrawing =
  //       _drawingController?.drawingController.getHistory.isNotEmpty ?? false;
  //   final score = hasDrawing ? 0.9 : 0.3;

  //   await completeCurrentActivity(
  //     score: score,
  //     metadata: {
  //       'drawingCompleted': hasDrawing,
  //       'artworkId': _drawingController?.currentArtworkId.value,
  //     },
  //   );
  // }

  //* Navigation helpers and utility methods
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

  String get currentPhaseTitle {
    final isFrench = currentLesson.value?.language == LessonLanguage.french;
    switch (currentPhase.value) {
      case LessonPhase.introduction:
        return 'Introduction';
      case LessonPhase.video:
        return isFrench ? 'Vidéo' : 'Video';
      case LessonPhase.activities:
        return isFrench ? 'Activités' : 'Activities';
      case LessonPhase.completion:
        return isFrench ? 'Terminé!' : 'Complete!';
    }
  }

  void resetLesson() {
    currentPhase.value = LessonPhase.introduction;
    currentActivityIndex.value = 0;
    isVideoCompleted.value = false;
    isLessonCompleted.value = false;
    activityProgressList.clear();
    lessonProgress.value = 0.0;
    lessonStartTime.value = null;
    activityStartTime.value = null;
    selectedItemIndices.clear();
  }

  void skipToActivities() {
    if (!isVideoCompleted.value) {
      markVideoAsCompleted();
    }
    currentPhase.value = LessonPhase.activities;
    _startFirstActivity();
  }
}
