import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/models/pattern_models.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';

class ShapePatternActivity extends Activity
    with MascotIntroductionMixin
    implements ActivityNavigationInterface {
  final List<String> patternImages;
  final List<String> optionImages;
  final int correctIndex;
  final String instruction;
  final PatternType patternType;

  // Override to indicate this activity requires validation
  @override
  bool get requiresValidation => true;

  ShapePatternActivity({
    required this.patternImages,
    required this.optionImages,
    required this.correctIndex,
    required this.instruction,
    required this.patternType,
  }) {
    // Initialize mascot with standardized approach
    initializeMascot([
      'Let\'s find the pattern!',
      'Look at the shapes and find what comes next.',
    ], completionDelay: const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Shape Pattern Activity: $instruction'));
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
    disposeMascot(); // Use mixin method
    super.dispose();
  }
}
