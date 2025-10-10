import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/models/number_matching_models.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';

class NumberMatchingActivity extends Activity
    with MascotIntroductionMixin
    implements ActivityNavigationInterface {
  final List<NumberMatchingItem> items;
  final String instruction;

  // Override to indicate this activity requires validation
  @override
  bool get requiresValidation => true;

  NumberMatchingActivity({required this.items, required this.instruction}) {
    // Initialize mascot with standardized approach
    initializeMascot([
      'Let\'s match numbers!',
      'Find the matching pairs.',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Number Matching Activity: $instruction'));
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
