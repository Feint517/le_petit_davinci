// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/features/lessons/listen&match/models/listen_and_match_item.dart';
import 'package:just_audio/just_audio.dart';

class ListenAndMatchController extends GetxController {
  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }

  final player = AudioPlayer();
  final items =
      [
        ListenAndMatchItem(
          audioAsset: AudioAssets.apple,
          options: [SvgAssets.apple, SvgAssets.igloo, SvgAssets.octopus],
          correctIndex: 0,
        ),
        ListenAndMatchItem(
          audioAsset: AudioAssets.igloo,
          options: [SvgAssets.apple, SvgAssets.igloo, SvgAssets.octopus],
          correctIndex: 1,
        ),
      ].obs;

  var currentIndex = 0.obs;
  var selectedOption = RxnInt();
  var isCorrect = RxnBool();

  void playAudio() async {
    try {
      await player.setAsset(items[currentIndex.value].audioAsset);
      await player.play();
    } catch (e) {
      print('Audio playback error: $e');
    }
  }

  void selectOption(int index) {
    selectedOption.value = index;
    isCorrect.value = index == items[currentIndex.value].correctIndex;
  }

  void nextQuestion() {
    if (currentIndex.value < items.length - 1) {
      currentIndex.value++;
      selectedOption.value = null;
      isCorrect.value = null;
    }
  }
}
