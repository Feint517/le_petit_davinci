// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:le_petit_davinci/features/exercises/models/listen_and_choose_exercise_model.dart';

class ListenAndChooseController extends GetxController {
  ListenAndChooseController(this.exercises);

  final AudioPlayer audioPlayer = AudioPlayer();
  final List<ListenAndChooseExercise> exercises;
  var selectedIndex = RxnInt();
  var currentExerciseIndex = 0.obs;

  ListenAndChooseExercise get currentExercise =>
      exercises[currentExerciseIndex.value];

  Future<void> playCurrentAudio() async {
    print('audio triggered');
    await audioPlayer.stop();
    await audioPlayer.play(
      AssetSource(currentExercise.audioAsset.replaceFirst('assets/', '')),
    );
  }

  void checkAnswer() {
    if (selectedIndex.value == currentExercise.correctIndex) {
      if (currentExerciseIndex.value < exercises.length - 1) {
        currentExerciseIndex.value++;
        selectedIndex.value = null;
      } else {
        // All exercises done
        Get.snackbar('Félicitations!', 'Vous avez terminé tous les exercices.');
      }
    } else {
      Get.snackbar('Incorrect', 'Essayez encore.');
    }
  }
}
