import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final Rxn<int> selectedIndex = Rxn<int>();

  @override
  Widget build(BuildContext context) {
    return FillTheBlankView(exercise: this);
  }

  @override
  bool get isAnswerReady => selectedIndex.value != null;

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
}
