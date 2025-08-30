// ignore_for_file: avoid_print
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/views/victory.dart';
import 'package:le_petit_davinci/mixin/audible_mixin.dart';
import 'package:le_petit_davinci/services/progress_service.dart';

// class ExercisesController extends GetxController {
//   ExercisesController({
//     required this.exercises,
//     required this.dialect,
//     required this.levelNumber,
//     required this.language,
//   });

//   final List<Exercise> exercises;
//   final String dialect;
//   final int levelNumber;
//   final String language;

//   late final PageController pageController;
//   final RxInt currentExerciseIndex = 0.obs;
//   final RxInt wrongAttemptsTotal = 0.obs;

//   // --- NEW: State for the UI, mirroring the "lessons" pattern ---
//   final RxBool isAnswerReady = false.obs;
//   StreamSubscription? _readinessSubscription;

//   final FlutterTts _tts = FlutterTts();
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   var selectedFillBlankIndex = RxnInt();
//   var selectedListenChooseIndex = RxnInt();
//   var selectedOrder = <int>[].obs;

//   bool get hasExercises => exercises.isNotEmpty;

//   Exercise get currentExercise {
//     if (!hasExercises) {
//       throw Exception('Attempted to access an exercise from an empty list.');
//     }
//     return exercises[currentExerciseIndex.value];
//   }

//   @override
//   void onInit() async {
//     super.onInit();
//     pageController = PageController();
//     // Set up the listener for the first exercise.
//     _setupExerciseListener();
//     await _audioPlayer.setAsset(AudioAssets.correctSound);
//     await _audioPlayer.setAsset(AudioAssets.errorSound);
//     await _tts.setLanguage(dialect);
//   }

//   @override
//   void onClose() {
//     pageController.dispose();
//     _audioPlayer.dispose();
//     _tts.stop();
//     _readinessSubscription?.cancel();
//     super.onClose();
//   }

//   void _setupExerciseListener() {
//     _readinessSubscription?.cancel(); // Cancel any old listener.
//     final exercise = exercises[currentExerciseIndex.value];

//     // The controller's state is now driven by the model's state.
//     isAnswerReady.value = exercise.isAnswerReady;

//     // Listen for future changes in the model's state.
//     _readinessSubscription = exercise.isAnswerReadyStream.listen((isReady) {
//       isAnswerReady.value = isReady;
//     });
//   }

//   Future<void> _completeExercises() async {
//     // Call the single, clean method in the ProgressService.
//     await ProgressService.instance.completeLevel(language, levelNumber);

//     // Navigate to the reward screen.
//     Get.off(() => const RewardScreen());
//   }

//   void nextExercise() {
//     if (currentExerciseIndex.value < exercises.length - 1) {
//       currentExerciseIndex.value++;
//       pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeIn,
//       );
//       // Set up the listener for the new exercise.
//       _setupExerciseListener();
//     }
//   }
//   //   //* Show feedback bottom sheet
//   //   Get.bottomSheet(
//   //     Container(
//   //       padding: const EdgeInsets.all(AppSizes.md),
//   //       height: DeviceUtils.getScreenHeight() * 0.25,
//   //       decoration: BoxDecoration(
//   //         color: isCorrect ? Colors.greenAccent : Color(0xFFF9E0E0),
//   //       ),
//   //       child: Column(
//   //         crossAxisAlignment: CrossAxisAlignment.start,
//   //         children: [
//   //           Row(
//   //             spacing: AppSizes.md,
//   //             children: [
//   //               Container(
//   //                 width: 40,
//   //                 height: 40,
//   //                 decoration: BoxDecoration(
//   //                   color: isCorrect ? Colors.green : Colors.redAccent,
//   //                   borderRadius: BorderRadius.circular(40),
//   //                 ),
//   //                 child: Icon(
//   //                   isCorrect ? Icons.check : Icons.close,
//   //                   color: AppColors.black,
//   //                 ),
//   //               ),
//   //               Text(
//   //                 isCorrect ? 'Correct!' : 'Incorrect',
//   //                 style: Theme.of(
//   //                   Get.context!,
//   //                 ).textTheme.headlineMedium?.copyWith(
//   //                   color: isCorrect ? Colors.green : Colors.redAccent,
//   //                   fontWeight: FontWeight.bold,
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //           const Gap(AppSizes.spaceBtwSections),
//   //           Row(
//   //             spacing: AppSizes.sm,
//   //             children: [
//   //               Text(
//   //                 'Bonne réponse:',
//   //                 style: Theme.of(
//   //                   Get.context!,
//   //                 ).textTheme.bodyLarge?.copyWith(color: AppColors.black),
//   //               ),
//   //               Expanded(
//   //                 child: Text(
//   //                   correctAnswer,
//   //                   style: Theme.of(
//   //                     Get.context!,
//   //                   ).textTheme.bodyLarge?.copyWith(color: AppColors.accent),
//   //                 ),
//   //               ),
//   //             ],
//   //           ),
//   //           const Gap(AppSizes.md),
//   //           CustomButton(
//   //             variant:
//   //                 isCorrect ? ButtonVariant.secondary : ButtonVariant.warning,
//   //             label: isCorrect ? 'Suivant' : 'Réessayer',
//   //             onPressed: () {
//   //               //? First, always close the bottom sheet.
//   //               Get.back();
//   //               if (isCorrect) {
//   //                 nextExercise();
//   //               } else {
//   //                 _resetExerciseState();
//   //               }
//   //             },
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //     isDismissible: true,
//   //     shape: const RoundedRectangleBorder(
//   //       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//   //     ),
//   //   );
//   // }

//   void checkAnswer() async {
//     if (!isAnswerReady.value) return;

//     final exercise = exercises[currentExerciseIndex.value];
//     final result = exercise.checkAnswer();

//     if (result.isCorrect) {
//       _audioPlayer.play(); // Play correct sound
//       if (currentExerciseIndex.value == exercises.length - 1) {
//         _completeExercises();
//       } else {
//         Future.delayed(const Duration(milliseconds: 500), nextExercise);
//       }
//     } else {
//       wrongAttemptsTotal.value++;
//       // Handle incorrect answer feedback (e.g., play error sound)
//     }

//     //* Show feedback bottom sheet
//     Get.bottomSheet(
//       Container(
//         padding: const EdgeInsets.all(AppSizes.md),
//         height: DeviceUtils.getScreenHeight() * 0.25,
//         decoration: BoxDecoration(
//           color: result.isCorrect ? Colors.greenAccent : Color(0xFFF9E0E0),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // ... (UI code for the bottom sheet)
//             // Use result.isCorrect and result.correctAnswerText here
//             // ...
//             Expanded(
//               child: Text(
//                 result.correctAnswerText, // Use the result here
//                 style: Theme.of(
//                   Get.context!,
//                 ).textTheme.bodyLarge?.copyWith(color: AppColors.accent),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _resetExerciseState() {
//     currentExercise.reset();
//     update();
//   }

//   //? Plays the audio for the current exercise, if it's an audible type.
//   Future<void> playCurrentAudio() async {
//     // Check if the current exercise has the `Audible` capability.
//     if (currentExercise is Audible) {
//       // Cast it to the mixin type and call the method.
//       await (currentExercise as Audible).playAudio(_tts);
//     }
//   }

//   Future<void> speakSentence(String sentence) async {
//     await _tts.speak(sentence);
//   }


//   bool get canCheckAnswer {
//     // Delegate the check to the current exercise
//     return currentExercise.isAnswerReady;
//   }
// }


class ExercisesController extends GetxController {
  // --- Core Properties ---
  final List<Exercise> exercises;
  final String dialect;
  final int levelNumber;
  final String language;

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
  });

  Exercise get currentExercise => exercises[currentExerciseIndex.value];

  @override
  void onInit() async {
    super.onInit();
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
    _readinessSubscription = currentExercise.isAnswerReadyStream.listen((isReady) {
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
    Get.off(() => const VictoryScreen(starsCount: 3));
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
              style: Get.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
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
