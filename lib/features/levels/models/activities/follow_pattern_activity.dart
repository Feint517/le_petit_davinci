import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/levels/views/activities/follow_pattern_view.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';

class FollowPatternActivity extends Activity
    with MascotIntroductionMixin
    implements ActivityNavigationInterface {
  final String instruction;
  final List<String> examples;
  final String question;
  final List<int> options;
  final int correctAnswerIndex;

  // Override to indicate this activity requires validation
  @override
  bool get requiresValidation => true;

  // State for this exercise: the index of the user's selected choice.
  final Rxn<int> selectedIndex = Rxn<int>();

  FollowPatternActivity({
    required this.instruction,
    required this.examples,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  }) {
    // Mascot initialization is handled in the view's build method
  }

  /// The view will call this to update the state when a choice is selected.
  void selectOption(int index) {
    selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return FollowPatternView(activity: this);
  }

  @override
  bool get isAnswerReady => selectedIndex.value != null;

  @override
  Stream<bool> get isAnswerReadyStream =>
      selectedIndex.stream.map((index) => index != null);

  @override
  AnswerResult checkAnswer() {
    final bool isCorrect = selectedIndex.value == correctAnswerIndex;
    // Construct the full correct answer string, e.g., "5 + 1 = 6"
    final String correctAnswerText = question.replaceFirst(
      '?',
      options[correctAnswerIndex].toString(),
    );

    return AnswerResult(
      isCorrect: isCorrect,
      correctAnswerText: correctAnswerText,
    );
  }

  @override
  void reset() {
    selectedIndex.value = null;
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
