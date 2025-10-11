import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';

class ArrangeNumbersActivity extends Activity
    with MascotIntroductionMixin
    implements ActivityNavigationInterface {
  final List<int> numbers;
  final bool isAscending;
  final String instruction;
  final int? maxNumber;
  final int? minNumber;

  // Override to indicate this activity requires validation
  @override
  bool get requiresValidation => true;

  ArrangeNumbersActivity({
    required this.numbers,
    required this.isAscending,
    required this.instruction,
    this.maxNumber,
    this.minNumber,
  }) {
    // Mascot initialization is handled in the view's build method
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Arrange Numbers Activity: $instruction'));
  }

  // --- ActivityNavigationInterface Implementation ---

  @override
  bool get useCustomNavigation => false; // Use standard navigation

  @override
  Widget? get customNavigationWidget => null; // Use standard navigation

  @override
  ActivityButtonConfig? get buttonConfig => null; // Use default button config

  @override
  void onNavigationTriggered() {
    // Handle custom navigation logic if needed
  }

  @override
  void dispose() {
    disposeMascotWithFeedback(); // Use enhanced dispose method
    super.dispose();
  }

  // --- Mascot Feedback Methods ---

  /// Show success feedback when answer is correct
  void showCorrectFeedback() {
    showSuccessFeedback();
  }

  /// Show encouragement feedback when answer is incorrect
  void showIncorrectFeedback() {
    showEncouragementFeedback();
  }
}
