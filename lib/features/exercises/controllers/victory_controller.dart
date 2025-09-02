import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/features/Mathematic/view/math_map.dart';
import 'package:le_petit_davinci/features/english/view/english_map.dart';
import 'package:le_petit_davinci/features/french/view/french_map.dart';

enum Subjects { english, math, french }

class VictoryController extends GetxController {
  final Subjects subject;
  final AudioPlayer _audioPlayer = AudioPlayer();

  VictoryController({required this.subject});

  @override
  void onInit() async {
    super.onInit();
    await _audioPlayer.setAsset(AudioAssets.victorySound);
    await _audioPlayer.setVolume(0.5);
    playVictorySound();
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }

  void playVictorySound() async {
    await _audioPlayer.seek(Duration.zero); //? Ensure playback from start
    await _audioPlayer.play();
  }

  void navigateToMapScreen() {
    Widget destination;

    switch (subject) {
      case Subjects.english:
        destination = EnglishMapScreen(); // Replace with actual screen
        break;
      case Subjects.math:
        destination = MathMapScreen(); // Replace with actual screen
        break;
      case Subjects.french:
        destination = FrenchMapScreen(); // Replace with actual screen
        break;
    }

    // Navigate and remove all previous screens until the first one.
    Get.offUntil(
      MaterialPageRoute(builder: (_) => destination),
      (route) => route.isFirst,
    );
  }
}
