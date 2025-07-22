import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_option_model.dart';

class FillTheBlankExercise {
  final String questionSuffix;
  final List<FillTheBlankOption> options;
  final int correctIndex;

  FillTheBlankExercise({
    required this.questionSuffix,
    required this.options,
    required this.correctIndex,
  });
}
