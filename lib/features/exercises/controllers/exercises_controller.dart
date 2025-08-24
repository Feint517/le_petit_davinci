// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/features/exercises/views/victory.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
import 'package:le_petit_davinci/mixin/audible_mixin.dart';
import 'package:le_petit_davinci/services/progress_service.dart';

class ExercisesController extends GetxController {
  ExercisesController({
    required this.exercises,
    required this.dialect,
    required this.levelNumber,
    required this.language,
  });

  final List<Exercise> exercises;
  final String dialect;
  final int levelNumber;
  final String language;

  late final PageController pageController;

  final FlutterTts _tts = FlutterTts();
  final AudioPlayer _audioPlayer = AudioPlayer();

  var currentExerciseIndex = 0.obs;

  var selectedFillBlankIndex = RxnInt();
  var selectedListenChooseIndex = RxnInt();
  var selectedOrder = <int>[].obs;
  // var playCount = 0.obs;
  // var showHint = false.obs;

  //? Track mistakes across the whole level to compute stars.
  var wrongAttemptsTotal = 0.obs;

  bool get hasExercises => exercises.isNotEmpty;

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
    // await BackgroundMusicController.instance.stopMusic();
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
      // Compute stars: simple rule -> start at 3, -1 for each mistake threshold.
      // You can refine later with time, hints, etc.
      final mistakes = wrongAttemptsTotal.value;
      int stars = 3;
      if (mistakes >= 1) stars = 2;
      if (mistakes >= 3) stars = 1;
      if (mistakes >= 6) stars = 0;

      // Persist progression
      ProgressService.instance.setStars(language, levelNumber, stars);
      ProgressService.instance.unlockNextIfNeeded(language, levelNumber);

      // Show victory with awarded stars
      Get.off(() => VictoryScreen(starsCount: stars));
    }
  }

  // void checkAnswer() async {
  //   bool isCorrect = false;
  //   String correctAnswer = '';

  //   switch (currentExercise.type) {
  //     case ExerciseType.fillTheBlank:
  //       final exercise = currentExercise.fillTheBlankExercise!;
  //       isCorrect = selectedFillBlankIndex.value == exercise.correctIndex;
  //       correctAnswer = exercise.options[exercise.correctIndex].optionText;
  //       break;

  //     case ExerciseType.listenAndChoose:
  //       final exercise = currentExercise.listenAndChooseExercise!;
  //       isCorrect = selectedListenChooseIndex.value == exercise.correctIndex;
  //       correctAnswer = exercise.label;
  //       break;

  //     case ExerciseType.reorderWords:
  //       final exercise = currentExercise.reorderWordsExercise!;
  //       isCorrect = ListEquality().equals(selectedOrder, exercise.correctOrder);
  //       correctAnswer = exercise.correctOrder
  //           .map((i) => exercise.words[i])
  //           .join(' ');
  //       break;
  //   }

  //   //? Count mistakes globally
  //   if (!isCorrect) {
  //     wrongAttemptsTotal.value++;
  //   }

  //   //* Play sound feedback
  //   if (isCorrect) {
  //     await _audioPlayer.setAsset(AudioAssets.correctSound);
  //     await _audioPlayer.seek(Duration.zero);
  //     await _audioPlayer.play();
  //   } else {
  //     await _audioPlayer.setAsset(AudioAssets.errorSound);
  //     await _audioPlayer.seek(Duration.zero);
  //     await _audioPlayer.play();
  //   }

  //   //* Show feedback bottom sheet
  //   Get.bottomSheet(
  //     Container(
  //       padding: const EdgeInsets.all(AppSizes.md),
  //       height: DeviceUtils.getScreenHeight() * 0.25,
  //       decoration: BoxDecoration(
  //         color: isCorrect ? Colors.greenAccent : Color(0xFFF9E0E0),
  //       ),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Row(
  //             spacing: AppSizes.md,
  //             children: [
  //               Container(
  //                 width: 40,
  //                 height: 40,
  //                 decoration: BoxDecoration(
  //                   color: isCorrect ? Colors.green : Colors.redAccent,
  //                   borderRadius: BorderRadius.circular(40),
  //                 ),
  //                 child: Icon(
  //                   isCorrect ? Icons.check : Icons.close,
  //                   color: AppColors.black,
  //                 ),
  //               ),
  //               Text(
  //                 isCorrect ? 'Correct!' : 'Incorrect',
  //                 style: Theme.of(
  //                   Get.context!,
  //                 ).textTheme.headlineMedium?.copyWith(
  //                   color: isCorrect ? Colors.green : Colors.redAccent,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const Gap(AppSizes.spaceBtwSections),
  //           Row(
  //             spacing: AppSizes.sm,
  //             children: [
  //               Text(
  //                 'Bonne réponse:',
  //                 style: Theme.of(
  //                   Get.context!,
  //                 ).textTheme.bodyLarge?.copyWith(color: AppColors.black),
  //               ),
  //               Expanded(
  //                 child: Text(
  //                   correctAnswer,
  //                   style: Theme.of(
  //                     Get.context!,
  //                   ).textTheme.bodyLarge?.copyWith(color: AppColors.accent),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           const Gap(AppSizes.md),
  //           CustomButton(
  //             variant:
  //                 isCorrect ? ButtonVariant.secondary : ButtonVariant.warning,
  //             label: isCorrect ? 'Suivant' : 'Réessayer',
  //             onPressed: () {
  //               //? First, always close the bottom sheet.
  //               Get.back();
  //               if (isCorrect) {
  //                 nextExercise();
  //               } else {
  //                 _resetExerciseState();
  //               }
  //             },
  //           ),
  //         ],
  //       ),
  //     ),
  //     isDismissible: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
  //     ),
  //   );
  // }

  void checkAnswer() async {
    // The controller no longer needs a switch statement.
    // It just tells the current exercise to check itself.
    final result = currentExercise.checkAnswer();

    //? Count mistakes globally
    if (!result.isCorrect) {
      wrongAttemptsTotal.value++;
    }

    //* Play sound feedback
    if (result.isCorrect) {
      await _audioPlayer.setAsset(AudioAssets.correctSound);
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    } else {
      await _audioPlayer.setAsset(AudioAssets.errorSound);
      await _audioPlayer.seek(Duration.zero);
      await _audioPlayer.play();
    }

    //* Show feedback bottom sheet
    Get.bottomSheet(
      // The bottom sheet UI remains the same, just using the 'result' object
      Container(
        padding: const EdgeInsets.all(AppSizes.md),
        height: DeviceUtils.getScreenHeight() * 0.25,
        decoration: BoxDecoration(
          color: result.isCorrect ? Colors.greenAccent : Color(0xFFF9E0E0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ... (UI code for the bottom sheet)
            // Use result.isCorrect and result.correctAnswerText here
            // ...
            Expanded(
              child: Text(
                result.correctAnswerText, // Use the result here
                style: Theme.of(
                  Get.context!,
                ).textTheme.bodyLarge?.copyWith(color: AppColors.accent),
              ),
            ),
            // ...
          ],
        ),
      ),
      // ...
    );
  }

  // void _resetExerciseState() {
  //   selectedFillBlankIndex.value = null;
  //   selectedListenChooseIndex.value = null;
  //   selectedOrder.clear();
  //   playCount.value = 0;
  //   showHint.value = false;
  // }

  void _resetExerciseState() {
    // Delegate the reset logic to the current exercise
    currentExercise.reset();
    // You might need to trigger a UI update if you're using Obx/GetX widgets
    update();
  }

  // Future<void> playCurrentAudio() async {
  //   if (currentExercise.type == ExerciseType.listenAndChoose) {
  //     playCount.value++;
  //     if (playCount.value >= 5) {
  //       showHint.value = true;
  //     }
  //     await _tts.speak(currentExercise.listenAndChooseExercise!.label);
  //   }
  // }

  /// Plays the audio for the current exercise, if it's an audible type.
  Future<void> playCurrentAudio() async {
    // Check if the current exercise has the `Audible` capability.
    if (currentExercise is Audible) {
      // Cast it to the mixin type and call the method.
      await (currentExercise as Audible).playAudio(_tts);
    }
  }

  Future<void> speakSentence(String sentence) async {
    await _tts.speak(sentence);
  }

  // bool get canCheckAnswer {
  //   switch (currentExercise.type) {
  //     case ExerciseType.fillTheBlank:
  //       return selectedFillBlankIndex.value != null;
  //     case ExerciseType.listenAndChoose:
  //       return selectedListenChooseIndex.value != null;
  //     case ExerciseType.reorderWords:
  //       return selectedOrder.length ==
  //           currentExercise.reorderWordsExercise!.correctOrder.length;
  //   }
  // }

  bool get canCheckAnswer {
    // Delegate the check to the current exercise
    return currentExercise.isAnswerReady;
  }
}
