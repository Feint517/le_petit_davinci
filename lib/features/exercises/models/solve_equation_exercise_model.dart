import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/exercises/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/views/solve_equation_view.dart'; // We will create this view next

class SolveEquationExercise extends Exercise {
  final String equation;
  final List<int> options;
  final int correctAnswer;

  // State for this exercise is managed here.
  final Rxn<int> selectedIndex = Rxn<int>();

  SolveEquationExercise({
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
    return SolveEquationView(exercise: this);
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
      // correctAnswerText: '$equation ${correctAnswer.toString()}',
      correctAnswerText: '$equation ${correctAnswer.toString()}',
    );
  }
}
