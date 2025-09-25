import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/views/activities/drawing_view.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';

class DrawingActivity extends Activity
    with MascotIntroductionMixin
    implements ActivityNavigationInterface {
  DrawingActivity({
    required this.prompt,
    this.templateImagePath,
    this.suggestedColors,
  }) {
    // Initialize mascot with standardized approach
    initializeMascot([
      'Super! Prêt à dessiner?',
      prompt,
    ], completionDelay: const Duration(seconds: 1));
  }

  final String prompt;
  final String? templateImagePath;
  final List<String>? suggestedColors;

  /// The drawing canvas will call this when the user is done drawing.
  /// This triggers the main `isCompleted` flag, advancing the lesson.
  void markDrawingAsCompleted() {
    markCompleted(); // Use the new unified helper method
  }

  @override
  Widget build(BuildContext context) {
    return DrawingActivityView(activity: this);
  }

  // --- ActivityNavigationInterface Implementation ---

  @override
  bool get useCustomNavigation => false; // Use standard navigation

  @override
  Widget? get customNavigationWidget => null; // Use standard navigation

  @override
  ActivityButtonConfig? get buttonConfig =>
      ActivityButtonConfig(continueButtonText: 'Finish Drawing');

  @override
  void onNavigationTriggered() {
    // Handle custom navigation logic if needed
  }

  @override
  void dispose() {
    disposeMascot(); // Use mixin method
    super.dispose();
  }
}
