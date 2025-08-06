import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:le_petit_davinci/background_music_controller.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/exercises/views/victory.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';

class ExercisesController extends GetxController {
  ExercisesController({required this.exercises, required this.dialect});

  final List<Exercise> exercises;
  final String dialect;
  late final PageController pageController;

  final FlutterTts _tts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();

  var currentExerciseIndex = 0.obs;

  var selectedFillBlankIndex = RxnInt();
  var selectedListenChooseIndex = RxnInt();
  var selectedOrder = <int>[].obs;
  var playCount = 0.obs;
  var showHint = false.obs;

    bool get hasExercises => exercises.isNotEmpty;


  // UnifiedExercise get currentExercise => exercises[currentExerciseIndex.value];
  Exercise get currentExercise {
    if (!hasExercises) {
      throw Exception('Attempted to access an exercise from an empty list.');
    }
    return exercises[currentExerciseIndex.value];
  }

  @override
  void onInit() async {
    super.onInit();
    pageController = PageController();
    await BackgroundMusicController.instance.stopMusic();
    await _audioPlayer.setAsset(AudioAssets.correctSound);
    await _audioPlayer.setAsset(AudioAssets.errorSound);
    await _tts.setLanguage(dialect);
  }

  @override
  void onClose() {
    pageController.dispose();
    _audioPlayer.dispose();
    _tts.stop();
    super.onClose();
  }

  void nextExercise() {
    if (currentExerciseIndex.value < exercises.length - 1) {
      currentExerciseIndex.value++;
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      _resetExerciseState();
    } else {
      // All exercises are completed
      Get.off(() => const VictoryScreen(starsCount: 3));
    }
  }

  void checkAnswer() async {
    bool isCorrect = false;
    String correctAnswer = '';

    switch (currentExercise.type) {
      case ExerciseType.fillTheBlank:
        final exercise = currentExercise.fillTheBlankExercise!;
        isCorrect = selectedFillBlankIndex.value == exercise.correctIndex;
        correctAnswer = exercise.options[exercise.correctIndex].optionText;
        break;

      case ExerciseType.listenAndChoose:
        final exercise = currentExercise.listenAndChooseExercise!;
        isCorrect = selectedListenChooseIndex.value == exercise.correctIndex;
        correctAnswer = exercise.label;
        break;

      case ExerciseType.reorderWords:
        final exercise = currentExercise.reorderWordsExercise!;
        isCorrect = ListEquality().equals(selectedOrder, exercise.correctOrder);
        correctAnswer = exercise.correctOrder
            .map((i) => exercise.words[i])
            .join(' ');
        break;
    }

    // Play sound feedback
    if (isCorrect) {
      await _audioPlayer.setAsset(AudioAssets.correctSound);
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    } else {
      await _audioPlayer.setAsset(AudioAssets.errorSound);
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    }

    // Show feedback bottom sheet
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(AppSizes.md),
        height: DeviceUtils.getScreenHeight() * 0.25,
        decoration: BoxDecoration(
          color: isCorrect ? Colors.greenAccent : Color(0xFFF9E0E0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: AppSizes.md,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isCorrect ? Colors.green : Colors.redAccent,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Icon(
                    isCorrect ? Icons.check : Icons.close,
                    color: AppColors.black,
                  ),
                ),
                Text(
                  isCorrect ? 'Correct!' : 'Incorrect',
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.headlineMedium?.copyWith(
                    color: isCorrect ? Colors.green : Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Gap(AppSizes.spaceBtwSections),
            Row(
              spacing: AppSizes.sm,
              children: [
                Text(
                  'Bonne réponse:',
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.black),
                ),
                Expanded(
                  child: Text(
                    correctAnswer,
                    style: Theme.of(
                      Get.context!,
                    ).textTheme.bodyLarge?.copyWith(color: AppColors.accent),
                  ),
                ),
              ],
            ),
            const Gap(AppSizes.md),
            CustomButton(
              variant:
                  isCorrect ? ButtonVariant.secondary : ButtonVariant.warning,
              label: isCorrect ? 'Suivant' : 'Réessayer',
              onPressed: () {
                if (isCorrect) {
                  if (currentExerciseIndex.value < exercises.length - 1) {
                    currentExerciseIndex.value++;
                    _resetExerciseState();
                    Get.back();
                  } else {
                    Get.back();
                    Get.off(() => const VictoryScreen(starsCount: 3));
                  }
                } else {
                  _resetExerciseState();
                  Get.back();
                }
              },
            ),
          ],
        ),
      ),
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    );
  }

  void _resetExerciseState() {
    selectedFillBlankIndex.value = null;
    selectedListenChooseIndex.value = null;
    selectedOrder.clear();
    playCount.value = 0;
    showHint.value = false;
  }

  Future<void> playCurrentAudio() async {
    if (currentExercise.type == ExerciseType.listenAndChoose) {
      playCount.value++;
      if (playCount.value >= 5) {
        showHint.value = true;
      }
      await _tts.speak(currentExercise.listenAndChooseExercise!.label);
    }
  }

  Future<void> speakSentence(String sentence) async {
    await _tts.speak(sentence);
  }

  bool get canCheckAnswer {
    switch (currentExercise.type) {
      case ExerciseType.fillTheBlank:
        return selectedFillBlankIndex.value != null;
      case ExerciseType.listenAndChoose:
        return selectedListenChooseIndex.value != null;
      case ExerciseType.reorderWords:
        return selectedOrder.length ==
            currentExercise.reorderWordsExercise!.correctOrder.length;
    }
  }
}
