import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/controllers/unified_mascot_controller.dart';

/// Mixin that provides standardized mascot introduction and feedback functionality
/// for all activities that need a talking mascot.
///
/// This mixin now uses the UnifiedMascotController which eliminates the need
/// to recreate controllers for feedback and maintains consistent state.
mixin MascotIntroductionMixin {
  /// The unified mascot controller for this activity
  UnifiedMascotController? _mascotController;

  /// Whether the mascot introduction has been initialized
  final RxBool _isInitialized = false.obs;

  // --- Public Getters ---

  /// Get the mascot controller (for external access)
  UnifiedMascotController? get mascotController => _mascotController;

  /// Whether the mascot is initialized (reactive)
  RxBool get isInitialized => _isInitialized;

  /// Whether the introduction is completed (reactive)
  RxBool get isIntroCompleted =>
      _mascotController?.isIntroCompleted ?? false.obs;

  // --- Initialization ---

  /// Initialize the mascot with the provided messages
  void initializeMascot(List<String> messages) {
    if (_isInitialized.value) {
      debugPrint('Mascot already initialized, skipping initialization');
      return;
    }

    try {
      // Validate input
      if (messages.isEmpty) {
        debugPrint('Warning: No messages provided for mascot initialization');
        messages = ['Hello! Let\'s get started! 👋'];
      }

      // Create a new unified controller
      _mascotController = UnifiedMascotController();
      final tag = _getControllerTag();

      // Check if controller already exists with this tag
      if (Get.isRegistered<UnifiedMascotController>(tag: tag)) {
        debugPrint(
          'Controller already exists with tag: $tag, removing old one',
        );
        Get.delete<UnifiedMascotController>(tag: tag);
      }

      Get.put(_mascotController!, tag: tag);

      // Initialize with introduction messages
      _mascotController!.initializeIntro(messages);

      _isInitialized.value = true;
      debugPrint(
        'Mascot initialized successfully with ${messages.length} messages',
      );
    } catch (e) {
      debugPrint('Error initializing mascot: $e');
      // Fallback: try to initialize with default message
      try {
        _mascotController = UnifiedMascotController();
        Get.put(_mascotController!, tag: _getControllerTag());
        _mascotController!.initializeIntro(['Hello! Let\'s get started! 👋']);
        _isInitialized.value = true;
      } catch (fallbackError) {
        debugPrint('Fallback initialization also failed: $fallbackError');
        _isInitialized.value = false;
      }
    }
  }

  /// Safe initialization method that can be called from constructors
  /// This method will defer initialization to the next frame to avoid timing issues
  void initializeMascotSafe(List<String> messages) {
    // Use a post-frame callback to ensure proper timing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      try {
        initializeMascot(messages);
      } catch (e) {
        debugPrint('Error in safe mascot initialization: $e');
      }
    });
  }

  /// Get a unique tag for this controller instance
  String _getControllerTag() {
    return '${runtimeType}_$hashCode';
  }

  // --- Feedback Methods ---

  /// Show success feedback with a random success message
  void showSuccessFeedback() {
    if (!_isInitialized.value || _mascotController == null) {
      debugPrint(
        'Cannot show success feedback: mascot not initialized or controller is null',
      );
      return;
    }

    try {
      _mascotController!.showSuccessFeedback();
    } catch (e) {
      debugPrint('Error showing success feedback: $e');
    }
  }

  /// Show encouragement feedback with a random encouragement message
  void showEncouragementFeedback() {
    if (!_isInitialized.value || _mascotController == null) {
      debugPrint(
        'Cannot show encouragement feedback: mascot not initialized or controller is null',
      );
      return;
    }

    try {
      _mascotController!.showEncouragementFeedback();
    } catch (e) {
      debugPrint('Error showing encouragement feedback: $e');
    }
  }

  // --- Navigation Methods ---

  /// Move to the next message (for user interaction)
  void nextMessage() {
    if (!_isInitialized.value || _mascotController == null) return;
    _mascotController!.nextMessage();
  }

  // --- State Management ---

  /// Reset the mascot introduction state
  void resetMascot() {
    if (_mascotController != null) {
      _mascotController!.reset();
    }
    // Reset the initialization flag so mascot can be reinitialized
    _isInitialized.value = false;
    debugPrint('Mascot state reset - ready for reinitialization');
  }

  /// Dispose of the mascot controller
  void disposeMascot() {
    try {
      if (_mascotController != null) {
        final tag = _getControllerTag();
        if (Get.isRegistered<UnifiedMascotController>(tag: tag)) {
          Get.delete<UnifiedMascotController>(tag: tag);
        }
        _mascotController = null;
        _isInitialized.value = false;
        debugPrint('Mascot controller disposed successfully');
      }
    } catch (e) {
      debugPrint('Error disposing mascot controller: $e');
      // Force cleanup even if there's an error
      _mascotController = null;
      _isInitialized.value = false;
    }
  }

  /// Enhanced dispose method that also clears any timers
  void disposeMascotWithFeedback() {
    try {
      disposeMascot();
    } catch (e) {
      debugPrint('Error in disposeMascotWithFeedback: $e');
    }
  }
}
