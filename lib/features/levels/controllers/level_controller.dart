// ignore_for_file: avoid_print
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/data/models/subject/level_content.dart';
import 'package:le_petit_davinci/features/levels/controllers/victory_controller.dart';
import 'package:le_petit_davinci/features/levels/views/victory.dart';
import 'package:le_petit_davinci/features/levels/views/reward.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/mixin/audible_mixin.dart';
import 'package:le_petit_davinci/services/progress_service.dart';

class LevelController extends GetxController {
  // --- Core Properties ---
  final LevelContent content;
  final String dialect;
  final int levelNumber;
  final String language;
  final Subjects subject;

  // --- UI & Flow Control ---
  late final PageController pageController;
  final RxInt currentIndex = 0.obs;
  final RxBool isAnswerReady = false.obs; // For validation-required activities
  final RxBool isLoading = false.obs;
  final RxBool hasError = false.obs;
  final RxnString errorMessage = RxnString();
  StreamSubscription? _readinessSubscription;
  StreamSubscription? _completionSubscription;

  // --- Services & Utilities ---
  final FlutterTts _tts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();

  LevelController({
    required this.content,
    required this.dialect,
    required this.levelNumber,
    required this.language,
    required this.subject,
  });

  // --- Content Access ---
  LevelSet get levelSet => content as LevelSet;

  // --- Current Item Access ---
  Activity get currentActivity => levelSet.activities[currentIndex.value];

  bool get currentActivityRequiresValidation =>
      currentActivity.requiresValidation;

  // --- Level Information ---
  String get levelTitle => levelSet.title;
  int get totalItems => levelSet.activities.length;

  @override
  void onInit() async {
    super.onInit();

    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = null;

      // Initialize activities
      for (final activity in levelSet.activities) {
        activity.isCompleted.value = false;
        if (activity.requiresValidation) {
          activity.reset();
        }
      }

      pageController = PageController();
      pageController.addListener(_onPageChanged);
      _setupCurrentActivityListener();

      await _audioPlayer.setAsset(AudioAssets.correctSound);
      await _tts.setLanguage(dialect);

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      hasError.value = true;
      errorMessage.value = e.toString();
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    _audioPlayer.dispose();
    _tts.stop();
    _readinessSubscription?.cancel();
    _completionSubscription?.cancel();
    super.onClose();
  }

  void _onPageChanged() {
    final newIndex = pageController.page?.round() ?? 0;
    if (newIndex != currentIndex.value) {
      currentIndex.value = newIndex;
      _setupCurrentActivityListener();
    }
  }

  void _setupCurrentActivityListener() {
    _readinessSubscription?.cancel();
    _completionSubscription?.cancel();

    final activity = currentActivity;

    // Always listen for completion
    _completionSubscription = activity.isCompleted.listen((isCompleted) {
      if (isCompleted) {
        activity.dispose();
        WidgetsBinding.instance.addPostFrameCallback((_) => _nextActivity());
      }
    });

    // Set up answer readiness for validation-required activities
    if (activity.requiresValidation) {
      isAnswerReady.value = activity.isAnswerReady;
      _readinessSubscription = activity.isAnswerReadyStream.listen((isReady) {
        isAnswerReady.value = isReady;
      });
    } else {
      isAnswerReady.value =
          true; // Activities that don't require validation are always "ready"
    }
  }

  // --- Activity Methods ---
  void checkAnswer() {
    if (!currentActivityRequiresValidation || !isAnswerReady.value) return;

    final activity = currentActivity;
    final result = activity.checkAnswer();

    if (result.isCorrect) {
      _audioPlayer.play();
      _audioPlayer.seek(Duration.zero);
    }

    // Show feedback bottom sheet
    Get.bottomSheet(
      _buildFeedbackSheet(result.isCorrect, result.correctAnswerText),
      isDismissible: false,
      enableDrag: false,
    );
  }

  void _handleNextStep(bool isCorrect) {
    Get.back(); // Close the bottom sheet

    if (isCorrect) {
      _nextActivity();
    } else {
      // Incorrect, reset the current activity for another try
      if (currentActivityRequiresValidation) {
        currentActivity.reset();
      }
    }
  }

  void _nextActivity() {
    if (!pageController.hasClients) return;

    if (currentIndex.value < totalItems - 1) {
      // Move to next activity
      currentIndex.value++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      _setupCurrentActivityListener();
    } else {
      // Last activity completed, finish the level
      _completeLevel();
    }
  }

  // Public method for manual navigation (e.g., from Continue button)
  void nextActivity() {
    final activity = currentActivity;

    // For auto-complete activities, mark as completed
    if (!activity.requiresValidation) {
      activity.markCompleted();
    }
    // For validation-required activities, the completion is handled by checkAnswer()
  }

  Future<void> _completeLevel() async {
    await ProgressService.instance.completeLevel(language, levelNumber);

    // Determine completion screen based on level content
    // Show reward screen if it's lesson-only or mixed, otherwise show victory screen
    bool shouldShowRewardScreen = levelSet.isLessonOnly || levelSet.isMixed;

    if (shouldShowRewardScreen) {
      Get.off(() => const RewardScreen());
    } else {
      Get.off(
        () => const VictoryScreen(starsCount: 3),
        binding: BindingsBuilder(() {
          Get.lazyPut(() => VictoryController(subject: subject));
        }),
      );
    }
  }

  // --- Audio Helpers ---
  Future<void> playCurrentAudio() async {
    if (currentActivity is Audible) {
      await (currentActivity as Audible).playAudio(_tts);
    }
  }

  Future<void> speakSentence(String sentence) async {
    await _tts.speak(sentence);
  }

  // --- Error Handling ---
  void retry() {
    onInit();
  }

  // --- UI Helper ---
  Widget _buildFeedbackSheet(bool isCorrect, String correctAnswer) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isCorrect ? const Color(0xFFd7f9e9) : const Color(0xFFfde2e4),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isCorrect ? 'Correct!' : 'Incorrect',
            style: Get.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isCorrect ? Colors.green.shade800 : Colors.red.shade800,
            ),
          ),
          if (!isCorrect) ...[
            const SizedBox(height: 16),
            Text('The correct answer is:', style: Get.textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text(
              correctAnswer,
              style: Get.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 24),
          CustomButton(
            label: 'Continue',
            onPressed: () => _handleNextStep(isCorrect),
            variant: isCorrect ? ButtonVariant.primary : ButtonVariant.warning,
          ),
        ],
      ),
    );
  }
}
