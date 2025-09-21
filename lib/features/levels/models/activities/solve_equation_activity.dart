import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/levels/views/activities/solve_equation_view.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';

class SolveEquationActivity extends Activity {
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
  });

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
}
