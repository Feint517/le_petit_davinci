// import 'package:collection/collection.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/features/exercises/models/answer_result_model.dart';
// import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
// import 'package:le_petit_davinci/features/exercises/views/reorder_words_view.dart';

// class ReorderWordsExercise extends Exercise {
//   ReorderWordsExercise({required this.words, required this.correctOrder});

//   final List<String> words;
//   final List<int> correctOrder;

//   // State for this exercise
//   final RxList<int> selectedOrder = <int>[].obs;

//   @override
//   Widget build(BuildContext context) {
//     return ReorderWordsView(exercise: this);
//   }

//   @override
//   AnswerResult checkAnswer() {
//     final bool isCorrect = ListEquality().equals(
//       selectedOrder.toList(),
//       correctOrder,
//     );
//     return AnswerResult(
//       isCorrect: isCorrect,
//       // correctAnswerText: correctOrder.join(' '),
//       correctAnswerText: correctOrder.map((i) => words[i]).join(' '),
//     );
//   }

//   @override
//   bool get isAnswerReady => selectedOrder.length == words.length;

//   @override
//   Stream<bool> get isAnswerReadyStream =>
//       selectedOrder.stream.map((list) => list.length == words.length);

//   @override
//   void reset() {
//     selectedOrder.clear();
//   }
// }
