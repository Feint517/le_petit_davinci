import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/listen_and_choose_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/reorder_words_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises2/views/fill_the_blank_view.dart';
import 'package:le_petit_davinci/features/exercises2/views/listen_and_choose_view.dart';
import 'package:le_petit_davinci/features/exercises2/views/reorder_words_view.dart'; // Import other exercise views here...
// import 'package:le_petit_davinci/features/exercises/views/listen_and_choose_view.dart';
// import 'package:le_petit_davinci/features/exercises/views/reorder_words_view.dart';

enum ExerciseType { fillTheBlank, listenAndChoose, reorderWords }

class UnifiedExercise {
  final ExerciseType type;
  final FillTheBlankExercise? fillTheBlankExercise;
  final ListenAndChooseExercise? listenAndChooseExercise;
  final ReorderWordsExercise? reorderWordsExercise;

  const UnifiedExercise._({
    required this.type,
    this.fillTheBlankExercise,
    this.listenAndChooseExercise,
    this.reorderWordsExercise,
  });

  /// Constructor for FillTheBlank exercises.
  factory UnifiedExercise.fillTheBlank(FillTheBlankExercise exercise) {
    return UnifiedExercise._(
      type: ExerciseType.fillTheBlank,
      fillTheBlankExercise: exercise,
    );
  }

  /// Constructor for ListenAndChoose exercises.
  factory UnifiedExercise.listenAndChoose(ListenAndChooseExercise exercise) {
    return UnifiedExercise._(
      type: ExerciseType.listenAndChoose,
      listenAndChooseExercise: exercise,
    );
  }

  /// Constructor for ReorderWords exercises.
  factory UnifiedExercise.reorderWords(ReorderWordsExercise exercise) {
    return UnifiedExercise._(
      type: ExerciseType.reorderWords,
      reorderWordsExercise: exercise,
    );
  }

  // ... existing constructors ...

  /// Builds the appropriate UI widget for the exercise.
  Widget build(BuildContext context) {
    switch (type) {
      case ExerciseType.fillTheBlank:
        return FillTheBlankView(exercise: fillTheBlankExercise!);
      case ExerciseType.listenAndChoose:
        return ListenAndChooseView(exercise: listenAndChooseExercise!);
      case ExerciseType.reorderWords:
        return ReorderWordsView(exercise: reorderWordsExercise!);
    }
  }
}
