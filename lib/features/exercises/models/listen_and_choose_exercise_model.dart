import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/exercises/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/views/listen_and_choose_view.dart';
import 'package:le_petit_davinci/mixin/audible_mixin.dart';

class ListenAndChooseExercise extends Exercise with Audible{
  final List<String> imageAssets;
  final int correctAnswer;
  final String label;

  ListenAndChooseExercise({
    required this.imageAssets,
    required this.correctAnswer,
    required this.label,
  });

  // State for this specific exercise is managed here.
  int? selectedIndex;

  /// The view will call this method when the user selects an image.
  void selectOption(int index) {
    selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return ListenAndChooseView(exercise: this);
  }

  @override
  AnswerResult checkAnswer() {
    final bool isCorrect = selectedIndex == correctAnswer;

    // The correct answer text is the label that was spoken.
    return AnswerResult(
      isCorrect: isCorrect,
      correctAnswerText: label,
    );
  }

  @override
  bool get isAnswerReady => selectedIndex != null;

  @override
  void reset() {
    selectedIndex = null;
    resetAudio();
  }
  
  // This is required by the Audible mixin.
  @override
  String get audioText => label;
}
