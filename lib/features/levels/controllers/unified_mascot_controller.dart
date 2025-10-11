import 'dart:async';
import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/controllers/mascot_animation_controller.dart';

/// Unified mascot controller that handles both introduction and feedback
/// without recreating the controller instance.
class UnifiedMascotController extends GetxController {
  // --- Core State ---

  /// Whether the mascot controller is initialized
  final RxBool isInitialized = false.obs;

  /// Whether the introduction phase is completed
  final RxBool isIntroCompleted = false.obs;

  /// Current message being displayed
  final RxString currentMessage = ''.obs;

  /// Current mascot state (idle, introducing, celebrating, encouraging)
  final Rx<MascotState> currentState = MascotState.idle.obs;

  /// Whether the mascot is currently showing a message
  final RxBool isShowingMessage = false.obs;

  // --- Message Management ---

  /// Queue of messages to be displayed
  final Queue<String> _messageQueue = Queue<String>();

  /// Timer for auto-hiding messages
  Timer? _autoHideTimer;

  /// Current message index for introduction messages
  int _currentMessageIndex = 0;

  /// Introduction messages
  List<String> _introMessages = [];

  // --- Animation Control ---

  /// Animation controller for Rive animations
  final MascotAnimationController _animationController =
      MascotAnimationController();

  // --- Universal Messages ---

  /// Success messages for correct answers
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

  /// Encouragement messages for incorrect answers
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

  // --- Initialization ---

  /// Initialize the mascot with introduction messages
  void initializeIntro(List<String> messages) {
    if (isInitialized.value) return;

    try {
      // Validate input
      if (messages.isEmpty) {
        debugPrint('Warning: No introduction messages provided, using default');
        _introMessages = ['Hello! Let\'s get started! 👋'];
      } else {
        _introMessages = List.from(messages);
      }

      _currentMessageIndex = 0;
      isInitialized.value = true;
      isIntroCompleted.value = false;
      currentState.value = MascotState.introducing;

      debugPrint(
        'UnifiedMascotController: Starting intro with ${_introMessages.length} messages',
      );

      // Start with the first message
      if (_introMessages.isNotEmpty) {
        _showNextIntroMessage();
      }

      debugPrint(
        'UnifiedMascotController initialized with ${_introMessages.length} messages',
      );
    } catch (e) {
      debugPrint('Error initializing mascot intro: $e');
      // Fallback: initialize with default message
      _introMessages = ['Hello! Let\'s get started! 👋'];
      _currentMessageIndex = 0;
      isInitialized.value = true;
      isIntroCompleted.value = false;
      currentState.value = MascotState.introducing;
    }
  }

  /// Initialize the animation controller with Rive state machine
  void initializeAnimation(dynamic stateMachineController) {
    try {
      if (stateMachineController == null) {
        debugPrint(
          'Warning: StateMachineController is null, animation will be disabled',
        );
        return;
      }

      _animationController.initialize(stateMachineController);

      if (_animationController.hasError) {
        debugPrint(
          'Animation controller initialization failed: ${_animationController.lastError}',
        );
      }
    } catch (e) {
      debugPrint('Error initializing animation controller: $e');
    }
  }

  // --- Introduction Management ---

  /// Show the next introduction message
  void nextMessage() {
    debugPrint(
      'nextMessage called: isInitialized=${isInitialized.value}, isIntroCompleted=${isIntroCompleted.value}',
    );

    if (!isInitialized.value) return;

    if (!isIntroCompleted.value) {
      _showNextIntroMessage();
    } else {
      _showNextQueuedMessage();
    }
  }

  /// Show the next introduction message
  void _showNextIntroMessage() {
    debugPrint(
      '_showNextIntroMessage: currentIndex=$_currentMessageIndex, totalMessages=${_introMessages.length}',
    );

    if (_currentMessageIndex >= _introMessages.length) {
      // All intro messages completed
      debugPrint(
        'All intro messages completed, setting isIntroCompleted to true',
      );
      isIntroCompleted.value = true;
      currentState.value = MascotState.idle;
      currentMessage.value = '';
      isShowingMessage.value = false;
      return;
    }

    final message = _introMessages[_currentMessageIndex];
    _currentMessageIndex++;

    _displayMessage(message, MascotState.introducing);
  }

  /// Show the next queued message (for feedback)
  void _showNextQueuedMessage() {
    if (_messageQueue.isEmpty) {
      currentState.value = MascotState.idle;
      currentMessage.value = '';
      isShowingMessage.value = false;
      return;
    }

    final message = _messageQueue.removeFirst();
    _displayMessage(message, currentState.value);
  }

  /// Display a message with the specified state
  void _displayMessage(String message, MascotState state) {
    debugPrint('_displayMessage: "$message" with state: $state');
    currentMessage.value = message;
    currentState.value = state;
    isShowingMessage.value = true;

    // Clear any existing timer
    _clearAutoHideTimer();

    // Set up auto-hide timer for feedback messages
    if (state == MascotState.celebrating || state == MascotState.encouraging) {
      _autoHideTimer = Timer(const Duration(seconds: 2), () {
        _hideMessage();
      });
    }
  }

  /// Hide the current message
  void _hideMessage() {
    _clearAutoHideTimer();
    currentMessage.value = '';
    isShowingMessage.value = false;

    // Return to idle state after feedback
    if (currentState.value == MascotState.celebrating ||
        currentState.value == MascotState.encouraging) {
      currentState.value = MascotState.idle;
      _animationController.setAnimationState(MascotState.idle);
    }
  }

  // --- Feedback Methods ---

  /// Show success feedback
  void showSuccessFeedback() {
    if (!isInitialized.value) {
      debugPrint('Cannot show success feedback: mascot not initialized');
      return;
    }

    try {
      final message = _getRandomMessage(_successMessages);
      currentState.value = MascotState.celebrating;

      // Try to set animation, but don't fail if animation controller has errors
      if (_animationController.isReady) {
        _animationController.setAnimationState(MascotState.celebrating);
      } else {
        debugPrint('Animation controller not ready, skipping animation');
      }

      _displayMessage(message, MascotState.celebrating);
    } catch (e) {
      debugPrint('Error showing success feedback: $e');
      // Fallback: show a simple success message without animation
      _displayMessage('Great job! 🎉', MascotState.celebrating);
    }
  }

  /// Show encouragement feedback
  void showEncouragementFeedback() {
    if (!isInitialized.value) {
      debugPrint('Cannot show encouragement feedback: mascot not initialized');
      return;
    }

    try {
      final message = _getRandomMessage(_encouragementMessages);
      currentState.value = MascotState.encouraging;

      // Try to set animation, but don't fail if animation controller has errors
      if (_animationController.isReady) {
        _animationController.setAnimationState(MascotState.encouraging);
      } else {
        debugPrint('Animation controller not ready, skipping animation');
      }

      _displayMessage(message, MascotState.encouraging);
    } catch (e) {
      debugPrint('Error showing encouragement feedback: $e');
      // Fallback: show a simple encouragement message without animation
      _displayMessage('Try again! 💪', MascotState.encouraging);
    }
  }

  // --- Helper Methods ---

  /// Get a random message from the provided list
  String _getRandomMessage(List<String> messages) {
    if (messages.isEmpty) return 'Great job!';
    final random = DateTime.now().millisecond % messages.length;
    return messages[random];
  }

  /// Clear the auto-hide timer
  void _clearAutoHideTimer() {
    _autoHideTimer?.cancel();
    _autoHideTimer = null;
  }

  /// Trigger animation (for user interaction)
  void triggerAnimation() {
    _animationController.triggerAnimation();
  }

  /// Reset the controller state
  void reset() {
    _clearAutoHideTimer();
    _messageQueue.clear();
    _currentMessageIndex = 0;
    _introMessages.clear();
    isInitialized.value = false;
    isIntroCompleted.value = false;
    currentMessage.value = '';
    currentState.value = MascotState.idle;
    isShowingMessage.value = false;
    _animationController.setAnimationState(MascotState.idle);
  }

  // --- Lifecycle ---

  @override
  void onClose() {
    _clearAutoHideTimer();
    _animationController.dispose();
    super.onClose();
  }
}

/// Mascot states for the unified controller
enum MascotState { idle, introducing, celebrating, encouraging }
