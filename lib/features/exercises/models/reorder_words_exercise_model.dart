import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/exercises/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/views/reorder_words_view.dart';

class ReorderWordsExercise extends Exercise {
  ReorderWordsExercise({required this.words, required this.correctOrder});

  final List<String> words;
  final List<int> correctOrder;

  // State for this exercise
  final List<int> currentOrder = [];

  @override
  Widget build(BuildContext context) {
    return ReorderWordsView(exercise: this);
  }

  @override
  AnswerResult checkAnswer() {
    final bool isCorrect = ListEquality().equals(currentOrder, correctOrder);
    return AnswerResult(
      isCorrect: isCorrect,
      correctAnswerText: correctOrder.join(' '),
    );
  }

  @override
  bool get isAnswerReady => currentOrder.length == words.length;

  @override
  void reset() {
    currentOrder.clear();
  }
}
