import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';

class VictoryController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void onInit() async {
    super.onInit();
    await _audioPlayer.setAsset(AudioAssets.victorySound);
    await _audioPlayer.setVolume(0.5);
    playVictorySound();
  }

  void playVictorySound() async {
    await _audioPlayer.seek(Duration.zero); //? Ensure playback from start
    await _audioPlayer.play();
  }
}
