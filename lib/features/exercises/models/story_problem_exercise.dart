// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/features/exercises/models/answer_result_model.dart';
// import 'package:le_petit_davinci/features/exercises/models/draggable_item_model.dart';
// import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
// import 'package:le_petit_davinci/features/exercises/views/story_problem_view.dart';

// class StoryProblemExercise extends Exercise {
//   final String instruction;
//   final List<DraggableItem> draggableOptions;
//   final int correctTotalValue;

//   final String unitName; // e.g., "dollars", "apples", "friends"

//   // --- State Management for this Exercise ---
//   // A list to hold the items the user has dropped into the answer area.
//   final RxList<DraggableItem> droppedItems = <DraggableItem>[].obs;

//   StoryProblemExercise({
//     required this.instruction,
//     required this.draggableOptions,
//     required this.correctTotalValue,
//     this.unitName = '', // Default to empty string
//   });

//   /// Adds an item to the drop zone. Called by the view's DragTarget.
//   void addItem(DraggableItem item) {
//     droppedItems.add(item);
//   }

//   /// Removes an item from the drop zone. Called when a dropped item is tapped.
//   void removeItem(DraggableItem item) {
//     droppedItems.remove(item);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StoryProblemView(exercise: this);
//   }

//   @override
//   bool get isAnswerReady => droppedItems.isNotEmpty;

//   @override
//   Stream<bool> get isAnswerReadyStream =>
//       droppedItems.stream.map((list) => list.isNotEmpty);

//   @override
//   AnswerResult checkAnswer() {
//     // Calculate the sum of values of all dropped items.
//     final int userAnswer = droppedItems.fold(
//       0,
//       (sum, item) => sum + item.value,
//     );

//     final bool isCorrect = userAnswer == correctTotalValue;

//     final String answerText =
//         'The correct answer is $correctTotalValue ${unitName.trim()}';

//     return AnswerResult(
//       isCorrect: isCorrect,
//       correctAnswerText: answerText.trim(),
//     );
//   }

//   @override
//   void reset() {
//     droppedItems.clear();
//   }
// }
