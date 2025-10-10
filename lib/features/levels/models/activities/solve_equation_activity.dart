import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/levels/views/activities/solve_equation_view.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';

class SolveEquationActivity extends Activity
    with MascotIntroductionMixin
    implements ActivityNavigationInterface {
  final String equation;
  final List<int> options;
  final int correctAnswer;

  // Override to indicate this activity requires validation
  @override
  bool get requiresValidation => true;

  // State for this exercise is managed here.
  final Rxn<int> selectedIndex = Rxn<int>();

  SolveEquationActivity({
    required this.equation,
    required this.options,
    required this.correctAnswer,
  }) {
    // Initialize mascot with standardized approach
    initializeMascot([
      'Let\'s solve this equation!',
      'Choose the correct answer.',
    ]);
  }

  /// The view will call this to update the state.
  void selectOption(int index) {
    selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return SolveEquationView(activity: this);
  }

  @override
  bool get isAnswerReady => selectedIndex.value != null;

  @override
  Stream<bool> get isAnswerReadyStream =>
      selectedIndex.stream.map((index) => index != null);

  @override
  void reset() {
    selectedIndex.value = null;
    resetMascotIntroduction(); // Reset mascot state
  }

  @override
  AnswerResult checkAnswer() {
    final bool isCorrect =
        (selectedIndex.value != null) &&
        (options[selectedIndex.value!] == correctAnswer);
    return AnswerResult(
      isCorrect: isCorrect,
      correctAnswerText: '$equation ${correctAnswer.toString()}',
    );
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
