import 'package:audioplayers/audioplayers.dart';

/// Service for managing sound effects during letter tracing
class TracingSoundService {
  static final AudioPlayer _audioPlayer = AudioPlayer();
  static bool _isEnabled = true;

  /// Enable or disable sound effects
  static void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  /// Check if sound effects are enabled
  static bool get isEnabled => _isEnabled;

  /// Play sound for correct tracing
  static Future<void> playCorrectSound() async {
    if (!_isEnabled) return;
    
    try {
      await _audioPlayer.play(AssetSource('sfx/correct-anwser.mp3'));
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play sound for incorrect tracing
  static Future<void> playIncorrectSound() async {
    if (!_isEnabled) return;
    
    try {
      await _audioPlayer.play(AssetSource('sfx/game-over.mp3'));
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play sound for tracing completion
  static Future<void> playCompletionSound() async {
    if (!_isEnabled) return;
    
    try {
      await _audioPlayer.play(AssetSource('sfx/success-finish-activity.mp3'));
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play sound for button clicks
  static Future<void> playButtonClickSound() async {
    if (!_isEnabled) return;
    
    try {
      await _audioPlayer.play(AssetSource('sfx/buttonclick.mp3'));
    } catch (e) {
      // Handle error silently
    }
  }

  /// Play sound for tracing start
  static Future<void> playTracingStartSound() async {
    if (!_isEnabled) return;
    
    try {
      await _audioPlayer.play(AssetSource('sfx/notification.mp3'));
    } catch (e) {
      // Handle error silently
    }
  }

  /// Dispose the audio player
  static Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
