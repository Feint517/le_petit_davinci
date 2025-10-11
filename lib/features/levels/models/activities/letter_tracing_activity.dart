import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/views/activities/letter_tracing_view.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';

class LetterTracingActivity extends Activity
    with MascotIntroductionMixin
    implements ActivityNavigationInterface {
  LetterTracingActivity({required String letter, this.prompt})
    : letter = letter.toUpperCase().isNotEmpty ? letter.toUpperCase() : 'A' {
    // Mascot initialization is handled in the view's build method
  }

  final String letter; // The letter to trace (A-Z)
  final String? prompt;

  /// The letter tracing canvas will call this when the user completes tracing.
  /// This triggers the main `isCompleted` flag, advancing the lesson.
  void markTracingAsCompleted() {
    markCompleted(); // Use the new unified helper method
  }

  @override
  Widget build(BuildContext context) {
    return LetterTracingView(activity: this);
  }

  // --- ActivityNavigationInterface Implementation ---

  @override
  bool get useCustomNavigation => false; // Use standard navigation

  @override
  Widget? get customNavigationWidget => null; // Use standard navigation

  @override
  ActivityButtonConfig? get buttonConfig =>
      const ActivityButtonConfig(continueButtonText: 'Next Letter');

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

  /// Show success feedback when tracing is completed
  void showCorrectFeedback() {
    showSuccessFeedback();
  }

  /// Show encouragement feedback when tracing needs improvement
  void showIncorrectFeedback() {
    showEncouragementFeedback();
  }
}

// Keep the old DrawingActivity for backward compatibility
class DrawingActivity extends LetterTracingActivity {
  DrawingActivity({
    required String prompt,
    String? templateImagePath,
    List<String>? suggestedColors,
  }) : super(
         letter: 'A', // Default letter for backward compatibility
         prompt: prompt,
       );
}
