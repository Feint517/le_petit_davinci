import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/exercises/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/listen_and_choose_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/reorder_words_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/views/fill_the_blank_view.dart';
import 'package:le_petit_davinci/features/exercises/views/listen_and_choose_view.dart';
import 'package:le_petit_davinci/features/exercises/views/reorder_words_view.dart';

// enum ExerciseType { fillTheBlank, listenAndChoose, reorderWords }

// class Exercise {
//   final ExerciseType type;
//   final FillTheBlankExercise? fillTheBlankExercise;
//   final ListenAndChooseExercise? listenAndChooseExercise;
//   final ReorderWordsExercise? reorderWordsExercise;

//   const Exercise._({
//     required this.type,
//     this.fillTheBlankExercise,
//     this.listenAndChooseExercise,
//     this.reorderWordsExercise,
//   });

//   /// Constructor for FillTheBlank exercises.
//   factory Exercise.fillTheBlank(FillTheBlankExercise exercise) {
//     return Exercise._(
//       type: ExerciseType.fillTheBlank,
//       fillTheBlankExercise: exercise,
//     );
//   }

//   /// Constructor for ListenAndChoose exercises.
//   factory Exercise.listenAndChoose(ListenAndChooseExercise exercise) {
//     return Exercise._(
//       type: ExerciseType.listenAndChoose,
//       listenAndChooseExercise: exercise,
//     );
//   }

//   /// Constructor for ReorderWords exercises.
//   factory Exercise.reorderWords(ReorderWordsExercise exercise) {
//     return Exercise._(
//       type: ExerciseType.reorderWords,
//       reorderWordsExercise: exercise,
//     );
//   }

//   // ... existing constructors ...

//   /// Builds the appropriate UI widget for the exercise.
//   Widget build(BuildContext context) {
//     switch (type) {
//       case ExerciseType.fillTheBlank:
//         return FillTheBlankView(exercise: fillTheBlankExercise!);
//       case ExerciseType.listenAndChoose:
//         return ListenAndChooseView(exercise: listenAndChooseExercise!);
//       case ExerciseType.reorderWords:
//         return ReorderWordsView(exercise: reorderWordsExercise!);
//     }
//   }
// }

/// An abstract base class for all exercise types.
/// Each specific exercise model will extend this class and provide its own
/// implementation for the `build` method.
abstract class Exercise {
  const Exercise();

  /// Builds the appropriate UI widget for this specific exercise.
  Widget build(BuildContext context);

  /// Checks the user's answer and returns a result.
  /// This must be implemented by all concrete exercise classes.
  // AnswerResult checkAnswer(dynamic userAnswer);
  AnswerResult checkAnswer();

  /// A getter to determine if the user has provided enough input to check the answer.
  /// Must be implemented by subclasses.
  bool get isAnswerReady;

  /// Resets the user's input for the current exercise.
  /// Must be implemented by subclasses.
  void reset();
}
