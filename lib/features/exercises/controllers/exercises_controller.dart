// ignore_for_file: avoid_print
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/exercises/controllers/victory_controller.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/views/victory.dart';
import 'package:le_petit_davinci/mixin/audible_mixin.dart';
import 'package:le_petit_davinci/services/progress_service.dart';

class ExercisesController extends GetxController {
  // --- Core Properties ---
  final List<Exercise> exercises;
  final String dialect;
  final int levelNumber;
  final String language;
  final Subjects subject;

  // --- UI & Flow Control ---
  late final PageController pageController;
  final RxInt currentExerciseIndex = 0.obs;
  final RxBool isAnswerReady = false.obs; // Drives the 'Check' button
  StreamSubscription? _readinessSubscription;

  // --- Services & Utilities ---
  final FlutterTts _tts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();

  ExercisesController({
    required this.exercises,
    required this.dialect,
    required this.levelNumber,
    required this.language,
    required this.subject,
  });

  Exercise get currentExercise => exercises[currentExerciseIndex.value];

  @override
  void onInit() async {
    super.onInit();
    for (final exercise in exercises) {
      exercise.reset();
    }
    pageController = PageController();
    _setupExerciseListener();
    await _audioPlayer.setAsset(AudioAssets.correctSound);
    await _tts.setLanguage(dialect);
  }

  @override
  void onClose() {
    pageController.dispose();
    _audioPlayer.dispose();
    _tts.stop();
    _readinessSubscription?.cancel();
    super.onClose();
  }

  void _setupExerciseListener() {
    _readinessSubscription?.cancel();
    isAnswerReady.value = currentExercise.isAnswerReady;
    _readinessSubscription = currentExercise.isAnswerReadyStream.listen((
      isReady,
    ) {
      isAnswerReady.value = isReady;
    });
  }

  void checkAnswer() {
    if (!isAnswerReady.value) return;

    final result = currentExercise.checkAnswer();

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
      if (currentExerciseIndex.value < exercises.length - 1) {
        // Move to next exercise
        currentExerciseIndex.value++;
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        _setupExerciseListener();
      } else {
        // Last exercise was correct, complete the level
        _completeLevel();
      }
    } else {
      // Incorrect, reset the current exercise for another try
      currentExercise.reset();
    }
  }

  Future<void> _completeLevel() async {
    await ProgressService.instance.completeLevel(language, levelNumber);
    Get.off(
      () => const VictoryScreen(starsCount: 3),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => VictoryController(subject: subject));
      }),
    );
  }

  // --- Audio Helpers ---
  Future<void> playCurrentAudio() async {
    if (currentExercise is Audible) {
      await (currentExercise as Audible).playAudio(_tts);
    }
  }

  Future<void> speakSentence(String sentence) async {
    await _tts.speak(sentence);
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
