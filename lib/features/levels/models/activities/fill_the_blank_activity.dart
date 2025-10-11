import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/levels/views/activities/fill_the_blank_view.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/models/fill_the_blank_option_model.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';

class FillTheBlankActivity extends Activity
    with MascotIntroductionMixin
    implements ActivityNavigationInterface {
  FillTheBlankActivity({
    required this.questionSuffix,
    required this.options,
    required this.correctAnswer,
  }) {
    // Initialize mascot with standardized approach
    initializeMascot([
      'Let\'s fill in the blank!',
      'Choose the correct answer.',
    ]);
  }

  final String questionSuffix;
  final List<FillTheBlankOption> options;
  final int correctAnswer;

  // Override to indicate this activity requires validation
  @override
  bool get requiresValidation => true;

  // State for this specific exercise is now managed here, not in the controller.
  final Rxn<int> selectedIndex = Rxn<int>();

  @override
  Widget build(BuildContext context) {
    return FillTheBlankView(activity: this);
  }

  @override
  bool get isAnswerReady => selectedIndex.value != null;

  @override
  Stream<bool> get isAnswerReadyStream =>
      selectedIndex.stream.map((index) => index != null);

  /// The view will call this method when the user selects an option.
  void selectOption(int index) {
    selectedIndex.value = index;
  }

  @override
  AnswerResult checkAnswer() {
    final bool isCorrect = selectedIndex.value == correctAnswer;
    final String correctAnswerText = options[correctAnswer].optionText;

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
