import 'dart:async';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';

/// Mixin that provides standardized mascot introduction and feedback functionality
/// for all activities that need a talking mascot.
mixin MascotIntroductionMixin {
  /// The mascot controller for this activity
  TalkingMascotController? _mascotController;

  /// Whether the mascot introduction is completed
  final RxBool isIntroCompleted = false.obs;

  /// Whether the mascot introduction has been initialized
  bool _isInitialized = false;

  /// Timer for auto-hiding feedback messages
  Timer? _feedbackTimer;

  /// Universal success messages
  static const List<String> _successMessages = [
    'Excellent! 🎉',
    'Great job! ⭐',
    'Perfect! 🌟',
    'Well done! 👏',
    'Amazing! 🚀',
    'Fantastic! 🎊',
    'Outstanding! 🏆',
    'Brilliant! ✨',
  ];

  /// Universal encouragement messages
  static const List<String> _encouragementMessages = [
    'Not quite right... 😔',
    'Try again! 💪',
    'Don\'t give up! 🌱',
    'You can do it! 💫',
    'Keep trying! 🔄',
    'Almost there! 🎯',
    'One more time! 🚀',
    'You\'ve got this! 💪',
  ];

  /// Universal thinking messages
  static const List<String> _thinkingMessages = [
    'Let me think... 🤔',
    'Hmm, interesting... 💭',
    'Processing... ⚙️',
    'Analyzing... 🔍',
  ];

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
      _isInitialized && _mascotController != null
          ? _mascotController!.currentMessage
          : '';

  /// Check if mascot is completed
  bool get isMascotCompleted =>
      _isInitialized && _mascotController != null
          ? _mascotController!.isCompleted.value
          : false;

  /// Check if mascot is initialized (for internal use)
  bool get isInitialized => _isInitialized;

  /// Get the mascot controller (for external access)
  TalkingMascotController? get mascotController => _mascotController;

  // --- Feedback Methods ---

  /// Show success feedback with a random success message
  void showSuccessFeedback() {
    if (!_isInitialized || _mascotController == null) return;

    _clearFeedbackTimer();
    final message = _getRandomMessage(_successMessages);

    // Create a new controller with the feedback message
    _mascotController!.dispose();
    _mascotController = TalkingMascotController(
      messages: [message],
      onCompleted: () {
        // Auto-hide after showing the message
        _feedbackTimer = Timer(const Duration(seconds: 2), () {
          if (_mascotController != null) {
            _mascotController!.dispose();
            _mascotController = null;
            _isInitialized = false;
          }
        });
      },
    );
    _mascotController!.nextMessage(); // Start showing the message
  }

  /// Show encouragement feedback with a random encouragement message
  void showEncouragementFeedback() {
    if (!_isInitialized || _mascotController == null) return;

    _clearFeedbackTimer();
    final message = _getRandomMessage(_encouragementMessages);

    // Create a new controller with the feedback message
    _mascotController!.dispose();
    _mascotController = TalkingMascotController(
      messages: [message],
      onCompleted: () {
        // Auto-hide after showing the message
        _feedbackTimer = Timer(const Duration(seconds: 2), () {
          if (_mascotController != null) {
            _mascotController!.dispose();
            _mascotController = null;
            _isInitialized = false;
          }
        });
      },
    );
    _mascotController!.nextMessage(); // Start showing the message
  }

  /// Show thinking state with a random thinking message
  void showThinkingFeedback() {
    if (!_isInitialized || _mascotController == null) return;

    _clearFeedbackTimer();
    final message = _getRandomMessage(_thinkingMessages);

    // Create a new controller with the feedback message
    _mascotController!.dispose();
    _mascotController = TalkingMascotController(
      messages: [message],
      onCompleted: () {
        // Auto-hide after showing the message
        _feedbackTimer = Timer(const Duration(seconds: 1), () {
          if (_mascotController != null) {
            _mascotController!.dispose();
            _mascotController = null;
            _isInitialized = false;
          }
        });
      },
    );
    _mascotController!.nextMessage(); // Start showing the message
  }

  /// Show a custom message
  void showCustomMessage(String message, {Duration? duration}) {
    if (!_isInitialized || _mascotController == null) return;

    _clearFeedbackTimer();

    // Create a new controller with the custom message
    _mascotController!.dispose();
    _mascotController = TalkingMascotController(
      messages: [message],
      onCompleted: () {
        // Auto-hide after showing the message
        final hideDuration = duration ?? const Duration(seconds: 2);
        _feedbackTimer = Timer(hideDuration, () {
          if (_mascotController != null) {
            _mascotController!.dispose();
            _mascotController = null;
            _isInitialized = false;
          }
        });
      },
    );
    _mascotController!.nextMessage(); // Start showing the message
  }

  /// Hide any current feedback message
  void hideFeedback() {
    _clearFeedbackTimer();
    if (_mascotController != null) {
      _mascotController!.dispose();
      _mascotController = null;
      _isInitialized = false;
    }
  }

  // --- Helper Methods ---

  /// Get a random message from the provided list
  String _getRandomMessage(List<String> messages) {
    if (messages.isEmpty) return 'Great job!';
    final random = DateTime.now().millisecond % messages.length;
    return messages[random];
  }

  /// Clear the feedback timer
  void _clearFeedbackTimer() {
    _feedbackTimer?.cancel();
    _feedbackTimer = null;
  }

  /// Enhanced dispose method that also clears feedback timer
  void disposeMascotWithFeedback() {
    _clearFeedbackTimer();
    disposeMascot();
  }
}
