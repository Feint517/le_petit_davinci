import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:collection/collection.dart';
import 'package:le_petit_davinci/background_music_controller.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/exercises/views/victory.dart';

class ReorderWordOptionModel {
  ReorderWordOptionModel({required this.optionText});

  final String optionText;

  @override
  String toString() => optionText;
}

class ReorderWordsExercise {
  ReorderWordsExercise({required this.words, required this.correctOrder});

  final List<String> words;
  final List<int> correctOrder;
}

class ReorderWordsController extends GetxController {
  ReorderWordsController(this.exercises,{required this.dialect});

  final FlutterTts _tts = FlutterTts();
  final String dialect;
  final List<ReorderWordsExercise> exercises;
  var currentExerciseIndex = 0.obs;
  var selectedOrder = <int>[].obs;

  ReorderWordsExercise get currentExercise =>
      exercises[currentExerciseIndex.value];

  Future<void> speakSentence(String sentence) async {
    await _tts.setLanguage('en-US');
    await _tts.setSpeechRate(0.5);
    await _tts.speak(sentence);
  }

  @override
  void onInit() async {
    super.onInit();
    await BackgroundMusicController.instance.stopMusic();
  }

  void checkAnswer() {
    final isCorrect = ListEquality().equals(
      selectedOrder,
      currentExercise.correctOrder,
    );
    final correctSentence = currentExercise.correctOrder
        .map((i) => currentExercise.words[i])
        .join(' ');

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
            const Gap(AppSizes.spaceBtwSections),
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
                  correctSentence,
                  style: Theme.of(
                    Get.context!,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.accent),
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
                    selectedOrder.clear();
                    Get.back();
                  } else {
                    Get.back();
                    Get.off(() => const VictoryScreen(starsCount: 3));
                  }
                } else {
                  selectedOrder.clear();
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
