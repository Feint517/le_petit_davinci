import 'package:get/get.dart';
import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';

/// Mixin that provides standardized mascot introduction functionality
/// for all activities that need a talking mascot intro.
mixin MascotIntroductionMixin {
  /// The mascot controller for this activity
  TalkingMascotController? _mascotController;

  /// Whether the mascot introduction is completed
  final RxBool isIntroCompleted = false.obs;

  /// Whether the mascot introduction has been initialized
  bool _isInitialized = false;

  /// Initialize the mascot with the provided messages
  void initializeMascot(List<String> messages) {
    if (_isInitialized) return;

    _mascotController = TalkingMascotController(messages: messages);

    // Listen to mascot completion
    ever(_mascotController!.isCompleted, (bool isDone) {
      if (isDone) {
        isIntroCompleted.value = true;
      }
    });

    _isInitialized = true;
  }

  /// Reset the mascot introduction state
  void resetMascotIntroduction() {
    isIntroCompleted.value = false;
    if (_isInitialized && _mascotController != null) {
      _mascotController!.reset();
    }
  }

  /// Dispose of mascot resources
  void disposeMascot() {
    if (_isInitialized && _mascotController != null) {
      _mascotController!.dispose();
      _mascotController = null;
      _isInitialized = false;
    }
  }

  /// Get the current mascot message
  String get currentMascotMessage =>
      _isInitialized && _mascotController != null ? _mascotController!.currentMessage : '';

  /// Check if mascot is completed
  bool get isMascotCompleted =>
      _isInitialized && _mascotController != null ? _mascotController!.isCompleted.value : false;

  /// Check if mascot is initialized (for internal use)
  bool get isInitialized => _isInitialized;

  /// Get the mascot controller (for external access)
  TalkingMascotController? get mascotController => _mascotController;
}
