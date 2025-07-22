import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';

class BackgroundMusicController extends GetxController {
  static BackgroundMusicController get instance => Get.find();
  final AudioPlayer _player = AudioPlayer();

  @override
  void onInit() async {
    super.onInit();
    await _player.setAsset(AudioAssets.backgroundMusic);
    await _player.setVolume(0.2);
    await playMusic();
  }

  Future<void> playMusic() async {
    await _player.setLoopMode(LoopMode.one);
    await _player.play();
  }

  Future<void> stopMusic() async {
    await _player.stop();
  }
}
