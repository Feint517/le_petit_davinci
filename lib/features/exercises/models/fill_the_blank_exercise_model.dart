import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/exercises/controllers/exercises_controller.dart';
import 'package:le_petit_davinci/features/exercises/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_option_model.dart';
import 'package:le_petit_davinci/features/exercises/views/fill_the_blank_view.dart';

class FillTheBlankExercise extends Exercise {
  FillTheBlankExercise({
    required this.questionSuffix,
    required this.options,
    required this.correctAnswer,
  });

  final String questionSuffix;
  final List<FillTheBlankOption> options;
  final int correctAnswer;

  // State for this specific exercise is now managed here, not in the controller.
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return FillTheBlankView(exercise: this);
  }

   @override
  bool get isAnswerReady => selectedIndex != null;

    /// The view will call this method when the user selects an option.
  void selectOption(int index) {
    selectedIndex = index;
  }

  // @override
  // CheckResult checkAnswer() {
  //   final isCorrect = _controller.selectedFillBlankIndex.value == correctIndex;
  //   return CheckResult(
  //     isCorrect: isCorrect,
  //     correctAnswerText: options[correctIndex].optionText,
  //   );
  // }

  @override
  AnswerResult checkAnswer() {
    final bool isCorrect = selectedIndex == correctAnswer;
    
    // Ensure correctAnswer is a valid index before accessing options
    final String correctAnswerText = (correctAnswer >= 0 && correctAnswer < options.length)
        ? options[correctAnswer].optionText
        : 'Error: Invalid correct answer index.';

    return AnswerResult(
      isCorrect: isCorrect,
      correctAnswerText: correctAnswerText,
    );
  }

  @override
  void reset() {
    selectedIndex = null;
  }
}
