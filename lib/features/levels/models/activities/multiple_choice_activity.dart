import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/models/selectable_option_model.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';

class MultipleChoiceActivity extends Activity
    with MascotIntroductionMixin
    implements ActivityNavigationInterface {
  final String instruction;
  final List<SelectableOption> options;
  final List<int> correctIndices;

  final RxList<int> selectedIndices = <int>[].obs;
  final RxBool isIntroCompleted = false.obs;

  MultipleChoiceActivity({
    required this.instruction,
    required this.options,
    required this.correctIndices,
  }) {
    // Initialize mascot with standardized approach
    initializeMascot([
      'Let\'s answer this question!',
      'Choose all the correct answers.',
    ], completionDelay: const Duration(seconds: 2));
  }

  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
  }

  void markIntroAsCompleted() => isIntroCompleted.value = true;

  void submitAnswer() => markCompleted(); // Use the new unified helper method

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Multiple Choice Activity: $instruction'));
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
