import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:le_petit_davinci/features/levels/controllers/unified_mascot_controller.dart';

/// Simplified animation controller for mascot Rive animations
///
/// This controller provides direct, reliable control over mascot animations
/// without complex input detection or global references.
class MascotAnimationController {
  StateMachineController? _stateMachineController;
  bool _isInitialized = false;
  bool _hasError = false;
  String? _lastError;

  /// Initialize the animation controller with a Rive state machine
  void initialize(StateMachineController stateMachineController) {
    try {
      // StateMachineController is non-nullable, so no need to check for null

      _stateMachineController = stateMachineController;
      _isInitialized = true;
      _hasError = false;
      _lastError = null;

      debugPrint('MascotAnimationController initialized successfully');
    } catch (e) {
      _hasError = true;
      _lastError = e.toString();
      debugPrint('Failed to initialize MascotAnimationController: $e');
    }
  }

  /// Set the animation state based on mascot state
  void setAnimationState(MascotState state) {
    if (!_isInitialized || _stateMachineController == null || _hasError) {
      debugPrint(
        'Animation controller not ready: initialized=$_isInitialized, hasError=$_hasError',
      );
      return;
    }

    try {
      switch (state) {
        case MascotState.idle:
          _setIdleAnimation();
          break;
        case MascotState.introducing:
          _setTalkingAnimation();
          break;
        case MascotState.celebrating:
          _setHappyAnimation();
          break;
        case MascotState.encouraging:
          _setSadAnimation();
          break;
      }
    } catch (e) {
      _hasError = true;
      _lastError = e.toString();
      debugPrint('Animation error: $e');
      // Graceful fallback - just control the state machine directly
      _fallbackAnimationControl(state);
    }
  }

  /// Set idle animation (mascot at rest)
  void _setIdleAnimation() {
    // Try common idle input names
    final idleInputs = ['Idle', 'idle', 'isIdle'];
    if (_trySetInput(idleInputs, true)) return;

    // Fallback: pause the state machine
    _stateMachineController!.isActive = false;
  }

  /// Set talking animation (mascot speaking)
  void _setTalkingAnimation() {
    // Try common talking input names
    final talkingInputs = ['Talking', 'talking', 'isTalking'];
    if (_trySetInput(talkingInputs, true)) return;

    // Fallback: activate state machine
    _stateMachineController!.isActive = true;
  }

  /// Set happy animation (success feedback)
  void _setHappyAnimation() {
    // Try common happy input names
    final happyInputs = ['Happy', 'happy', 'isHappy', 'celebrate'];
    if (_trySetInput(happyInputs, true)) return;

    // Fallback: activate state machine
    _stateMachineController!.isActive = true;
  }

  /// Set sad animation (encouragement feedback)
  void _setSadAnimation() {
    // Try common sad input names
    final sadInputs = ['Sad', 'sad', 'isSad', 'disappointed'];
    if (_trySetInput(sadInputs, true)) return;

    // Fallback: activate state machine
    _stateMachineController!.isActive = true;
  }

  /// Try to set a boolean input with the given names
  /// Returns true if successful, false if no input found
  bool _trySetInput(List<String> inputNames, bool value) {
    for (final inputName in inputNames) {
      try {
        final input = _stateMachineController!.findInput(inputName);
        if (input != null) {
          input.value = value;
          return true;
        }
      } catch (e) {
        // Continue trying other input names
        continue;
      }
    }
    return false;
  }

  /// Fallback animation control when specific inputs are not found
  void _fallbackAnimationControl(MascotState state) {
    if (_stateMachineController == null) {
      debugPrint(
        'Fallback animation control failed: state machine controller is null',
      );
      return;
    }

    try {
      switch (state) {
        case MascotState.idle:
          _stateMachineController!.isActive = false;
          debugPrint('Fallback: Set state machine to inactive (idle)');
          break;
        case MascotState.introducing:
        case MascotState.celebrating:
        case MascotState.encouraging:
          _stateMachineController!.isActive = true;
          debugPrint('Fallback: Set state machine to active (${state.name})');
          break;
      }
    } catch (e) {
      debugPrint('Fallback animation control failed: $e');
      _hasError = true;
      _lastError = e.toString();
    }
  }

  /// Trigger a generic animation (for user interaction)
  void triggerAnimation() {
    if (!_isInitialized || _stateMachineController == null) return;

    try {
      // Try common trigger input names
      final triggerInputs = ['Trigger', 'trigger', 'tap'];
      if (_trySetInput(triggerInputs, true)) {
        // Reset trigger after a short delay
        Future.delayed(const Duration(milliseconds: 100), () {
          _trySetInput(triggerInputs, false);
        });
        return;
      }

      // Fallback: toggle state machine
      _stateMachineController!.isActive = !_stateMachineController!.isActive;
      Future.delayed(const Duration(milliseconds: 200), () {
        _stateMachineController!.isActive = !_stateMachineController!.isActive;
      });
    } catch (e) {
      debugPrint('Trigger animation error: $e');
    }
  }

  /// Check if the animation controller has encountered an error
  bool get hasError => _hasError;

  /// Get the last error message
  String? get lastError => _lastError;

  /// Check if the animation controller is ready for use
  bool get isReady =>
      _isInitialized && !_hasError && _stateMachineController != null;

  /// Reset error state (for recovery)
  void resetErrorState() {
    _hasError = false;
    _lastError = null;
  }

  /// Dispose of the animation controller
  void dispose() {
    try {
      _stateMachineController = null;
      _isInitialized = false;
      _hasError = false;
      _lastError = null;
      debugPrint('MascotAnimationController disposed successfully');
    } catch (e) {
      debugPrint('Error disposing MascotAnimationController: $e');
    }
  }
}
