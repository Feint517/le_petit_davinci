import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/exercises/models/listen_and_choose_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/views/victory_screen.dart';

class ListenAndChooseController extends GetxController {
  ListenAndChooseController(this.exercises);

  final AudioPlayer audioPlayer = AudioPlayer();
  final List<ListenAndChooseExercise> exercises;
  var selectedIndex = RxnInt();
  var currentExerciseIndex = 0.obs;

  var playCount = 0.obs;
  var showHint = false.obs;

  ListenAndChooseExercise get currentExercise =>
      exercises[currentExerciseIndex.value];

  Future<void> playCurrentAudio() async {
    playCount.value++;
    if (playCount.value >= 5) {
      showHint.value = true;
    }
    await audioPlayer.stop();
    await audioPlayer.play(
      AssetSource(currentExercise.audioAsset.replaceFirst('assets/', '')),
    );
  }

  void checkAnswer() {
    final isCorrect = selectedIndex.value == currentExercise.correctIndex;
    final correctLabel = currentExercise.label;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        height: 180,
        decoration: BoxDecoration(
          color: isCorrect ? Colors.greenAccent : Color(0xFFF9E0E0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                const SizedBox(width: 16),
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
            const Gap(16),
            Row(
              children: [
                Text(
                  'Bonne réponse:',
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.black),
                ),
                const SizedBox(width: 8),
                Text(
                  correctLabel,
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.accent),
                ),
              ],
            ),
            const Gap(16),
            CustomButton(
              variant:
                  isCorrect ? ButtonVariant.secondary : ButtonVariant.warning,
              label: isCorrect ? 'Suivant' : 'Réessayer',
              // onPressed: () {
              //   if (isCorrect) {
              //     if (currentExerciseIndex.value < exercises.length - 1) {
              //       showHint.value = false;
              //       playCount.value = 0;
              //       selectedIndex.value = null;
              //       currentExerciseIndex.value++;
              //       Get.back();
              //     } else {
              //       Get.back();
              //       Get.snackbar(
              //         'Félicitations!',
              //         'Vous avez terminé tous les exercices.',
              //       );
              //     }
              //   } else {
              //     selectedIndex.value = null;
              //     Get.back();
              //   }
              // },
              onPressed: () {
                if (isCorrect) {
                  if (currentExerciseIndex.value < exercises.length - 1) {
                    currentExerciseIndex.value++;
                    selectedIndex.value = null;
                    Get.back();
                  } else {
                    Get.back();
                    Get.off(() => const VictoryScreen(starsCount: 3));
                  }
                } else {
                  selectedIndex.value = null;
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
}
