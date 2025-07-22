import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_option_model.dart';

final fillTheBlankEnglishLevels = {
  2: [
    //? Level 2
    FillTheBlankExercise(
      questionSuffix: 'vais au restaurant.',
      options: [
        FillTheBlankOption(optionText: 'Il'),
        FillTheBlankOption(optionText: 'Je'),
        FillTheBlankOption(optionText: 'On'),
      ],
      correctIndex: 1,
    ),
    FillTheBlankExercise(
      questionSuffix: 'voulons une pizza.',
      options: [
        FillTheBlankOption(optionText: 'Ils'),
        FillTheBlankOption(optionText: 'Nous'),
        FillTheBlankOption(optionText: 'Vous'),
      ],
      correctIndex: 1,
    ),
  ],
};
