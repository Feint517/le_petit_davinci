import 'package:audioplayers/audioplayers.dart';

class AppSfx {
  AppSfx._();

  static final AudioPlayer _player = AudioPlayer();
  static bool _muted = false;

  static void setMuted(bool value) {
    _muted = value;
  }

  static Future<void> playAsset(String assetPath) async {
    if (_muted) return;
    await _player.play(AssetSource(assetPath));
  }

  static Future<void> click() => playAsset('sfx/buttonclick.mp3');
  static Future<void> success() =>
      playAsset('sfx/mixkit-completion-of-a-level-2063.wav');
  static Future<void> win() => playAsset('sfx/winner.mp3');
  static Future<void> reset() => playAsset('sfx/reset.mp3');
}
