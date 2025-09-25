import 'package:flutter/material.dart';

/// Interface for activities that need custom navigation behavior
/// Most activities will use the standard navigation, but some (like games)
/// may need custom buttons or special navigation logic.
abstract class ActivityNavigationInterface {
  /// Whether this activity should use custom navigation instead of standard
  bool get useCustomNavigation => false;

  /// Custom navigation widget to display (only used if useCustomNavigation is true)
  Widget? get customNavigationWidget => null;

  /// Custom button configuration for standard navigation
  /// If null, uses default button behavior
  ActivityButtonConfig? get buttonConfig => null;

  /// Called when the activity wants to trigger navigation
  /// This allows activities to control when they're ready to advance
  void onNavigationTriggered();
}

/// Configuration for customizing standard navigation buttons
class ActivityButtonConfig {
  const ActivityButtonConfig({
    this.checkButtonText = 'Check',
    this.continueButtonText = 'Continue',
    this.customButtonText,
    this.showAudioButton = true,
    this.buttonStyle,
  });

  final String checkButtonText;
  final String continueButtonText;
  final String? customButtonText;
  final bool showAudioButton;
  final ButtonStyle? buttonStyle;
}
