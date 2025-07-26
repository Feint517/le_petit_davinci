import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/listen_and_choose_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/reorder_words_exercise_model.dart';

enum ExerciseType { fillTheBlank, listenAndChoose, reorderWords }

class UnifiedExercise {
  final ExerciseType type;
  final FillTheBlankExercise? fillTheBlankExercise;
  final ListenAndChooseExercise? listenAndChooseExercise;
  final ReorderWordsExercise? reorderWordsExercise;

  UnifiedExercise.fillTheBlank(this.fillTheBlankExercise)
    : type = ExerciseType.fillTheBlank,
      listenAndChooseExercise = null,
      reorderWordsExercise = null;

  UnifiedExercise.listenAndChoose(this.listenAndChooseExercise)
    : type = ExerciseType.listenAndChoose,
      fillTheBlankExercise = null,
      reorderWordsExercise = null;

  UnifiedExercise.reorderWords(this.reorderWordsExercise)
    : type = ExerciseType.reorderWords,
      fillTheBlankExercise = null,
      listenAndChooseExercise = null;
}
