// class SolveEquationExercise {
//   final String equation;
//   final int missingNumber;
//   final List<int> options;
//   final EquationType type;
//   final String? hint;

//   const SolveEquationExercise({
//     required this.equation,
//     required this.missingNumber,
//     required this.options,
//     required this.type,
//     this.hint,
//   });
// }

// enum EquationType { addition, subtraction, mixed }


import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/exercises/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/views/solve_equation_view.dart'; // We will create this view next

class SolveEquationExercise extends Exercise {
  final String equation;
  final List<int> options;
  final int correctAnswer;

  // State for this exercise is managed here.
  int? selectedIndex;

  SolveEquationExercise({
    required this.equation,
    required this.options,
    required this.correctAnswer,
  });

  /// The view will call this to update the state.
  void selectOption(int index) {
    selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    // Each exercise knows how to build its own UI.
    return SolveEquationView(exercise: this);
  }

  @override
  bool get isAnswerReady => selectedIndex != null;

  @override
  void reset() {
    selectedIndex = null;
  }

  @override
  AnswerResult checkAnswer() {
    final bool isCorrect = (selectedIndex != null) && (options[selectedIndex!] == correctAnswer);
    return AnswerResult(
      isCorrect: isCorrect,
      correctAnswerText: '$equation ${correctAnswer.toString()}',
    );
  }
}