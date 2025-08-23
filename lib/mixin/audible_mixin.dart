import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

/// A mixin for exercises that can be spoken aloud.
/// It manages its own play count and hint visibility.
mixin Audible {
  /// The text that should be spoken by the TTS engine.
  /// This must be provided by the class using the mixin.
  String get audioText;

  /// Tracks how many times the audio has been played for this exercise.
  final RxInt playCount = 0.obs;

  /// Determines if a hint should be shown (e.g., after 5 plays).
  bool get shouldShowHint => playCount.value >= 5;

  /// Plays the audio using the provided TTS engine.
  Future<void> playAudio(FlutterTts tts) async {
    playCount.value++;
    await tts.speak(audioText);
  }

  /// Resets the audio-related state.
  void resetAudio() {
    playCount.value = 0;
  }
}