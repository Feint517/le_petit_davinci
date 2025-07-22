import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_option_model.dart';

final fillTheBlankEnglishLevels = {
  2: [
    FillTheBlankExercise(
      questionSuffix: 'goes to the restaurant.',
      options: [
        FillTheBlankOption(optionText: 'He'),
        FillTheBlankOption(optionText: 'I'),
        FillTheBlankOption(optionText: 'We'),
      ],
      correctIndex: 1,
    ),
    FillTheBlankExercise(
      questionSuffix: 'want a pizza.',
      options: [
        FillTheBlankOption(optionText: 'They'),
        FillTheBlankOption(optionText: 'We'),
        FillTheBlankOption(optionText: 'You'),
      ],
      correctIndex: 1,
    ),
    FillTheBlankExercise(
      questionSuffix: 'likes chocolate.',
      options: [
        FillTheBlankOption(optionText: 'She'),
        FillTheBlankOption(optionText: 'He'),
        FillTheBlankOption(optionText: 'We'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'are kind.',
      options: [
        FillTheBlankOption(optionText: 'We'),
        FillTheBlankOption(optionText: 'You'),
        FillTheBlankOption(optionText: 'They'),
      ],
      correctIndex: 1,
    ),
    FillTheBlankExercise(
      questionSuffix: 'is a big animal.',
      options: [
        FillTheBlankOption(optionText: 'Elephant'),
        FillTheBlankOption(optionText: 'Cat'),
        FillTheBlankOption(optionText: 'Dog'),
      ],
      correctIndex: 0,
    ),
  ],
  4: [
    FillTheBlankExercise(
      questionSuffix: 'can fly.',
      options: [
        FillTheBlankOption(optionText: 'Bird'),
        FillTheBlankOption(optionText: 'Fish'),
        FillTheBlankOption(optionText: 'Horse'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'lives in water.',
      options: [
        FillTheBlankOption(optionText: 'Fish'),
        FillTheBlankOption(optionText: 'Dog'),
        FillTheBlankOption(optionText: 'Cat'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'has stripes.',
      options: [
        FillTheBlankOption(optionText: 'Tiger'),
        FillTheBlankOption(optionText: 'Elephant'),
        FillTheBlankOption(optionText: 'Bird'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'is a pet that barks.',
      options: [
        FillTheBlankOption(optionText: 'Dog'),
        FillTheBlankOption(optionText: 'Cat'),
        FillTheBlankOption(optionText: 'Fish'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'is a pet that purrs.',
      options: [
        FillTheBlankOption(optionText: 'Dog'),
        FillTheBlankOption(optionText: 'Cat'),
        FillTheBlankOption(optionText: 'Bird'),
      ],
      correctIndex: 1,
    ),
  ],
  7: [
    FillTheBlankExercise(
      questionSuffix: 'is the king of the jungle.',
      options: [
        FillTheBlankOption(optionText: 'Lion'),
        FillTheBlankOption(optionText: 'Tiger'),
        FillTheBlankOption(optionText: 'Elephant'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'can swim and has fins.',
      options: [
        FillTheBlankOption(optionText: 'Fish'),
        FillTheBlankOption(optionText: 'Bird'),
        FillTheBlankOption(optionText: 'Dog'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'is a farm animal that gives us milk.',
      options: [
        FillTheBlankOption(optionText: 'Cow'),
        FillTheBlankOption(optionText: 'Horse'),
        FillTheBlankOption(optionText: 'Dog'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'is a fast animal with long legs.',
      options: [
        FillTheBlankOption(optionText: 'Horse'),
        FillTheBlankOption(optionText: 'Cat'),
        FillTheBlankOption(optionText: 'Fish'),
      ],
      correctIndex: 0,
    ),
  ],
};

final fillTheBlankFrenchLevels = {
  4: [
    FillTheBlankExercise(
      questionSuffix: 'est le roi de la jungle.',
      options: [
        FillTheBlankOption(optionText: 'Lion'),
        FillTheBlankOption(optionText: 'Tigre'),
        FillTheBlankOption(optionText: 'Éléphant'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'peut voler.',
      options: [
        FillTheBlankOption(optionText: 'Oiseau'),
        FillTheBlankOption(optionText: 'Poisson'),
        FillTheBlankOption(optionText: 'Chien'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'vit dans l’eau.',
      options: [
        FillTheBlankOption(optionText: 'Poisson'),
        FillTheBlankOption(optionText: 'Chat'),
        FillTheBlankOption(optionText: 'Chien'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'a des rayures.',
      options: [
        FillTheBlankOption(optionText: 'Tigre'),
        FillTheBlankOption(optionText: 'Lion'),
        FillTheBlankOption(optionText: 'Ours'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'est un animal qui aime le miel.',
      options: [
        FillTheBlankOption(optionText: 'Ours'),
        FillTheBlankOption(optionText: 'Lion'),
        FillTheBlankOption(optionText: 'Tigre'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'est un animal domestique qui miaule.',
      options: [
        FillTheBlankOption(optionText: 'Chat'),
        FillTheBlankOption(optionText: 'Chien'),
        FillTheBlankOption(optionText: 'Oiseau'),
      ],
      correctIndex: 0,
    ),
  ],
  8: [
    FillTheBlankExercise(
      questionSuffix: 'donne du lait.',
      options: [
        FillTheBlankOption(optionText: 'Vache'),
        FillTheBlankOption(optionText: 'Cheval'),
        FillTheBlankOption(optionText: 'Chien'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'est un animal domestique qui miaule.',
      options: [
        FillTheBlankOption(optionText: 'Chat'),
        FillTheBlankOption(optionText: 'Chien'),
        FillTheBlankOption(optionText: 'Oiseau'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'est un animal domestique qui aboie.',
      options: [
        FillTheBlankOption(optionText: 'Chien'),
        FillTheBlankOption(optionText: 'Chat'),
        FillTheBlankOption(optionText: 'Poisson'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'est un animal qui aime le miel.',
      options: [
        FillTheBlankOption(optionText: 'Ours'),
        FillTheBlankOption(optionText: 'Lion'),
        FillTheBlankOption(optionText: 'Tigre'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'est un animal qui nage dans l’eau.',
      options: [
        FillTheBlankOption(optionText: 'Poisson'),
        FillTheBlankOption(optionText: 'Oiseau'),
        FillTheBlankOption(optionText: 'Chat'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'est un animal qui vit dans la savane.',
      options: [
        FillTheBlankOption(optionText: 'Lion'),
        FillTheBlankOption(optionText: 'Ours'),
        FillTheBlankOption(optionText: 'Tigre'),
      ],
      correctIndex: 0,
    ),
  ],
  10: [
    FillTheBlankExercise(
      questionSuffix: 'est un animal avec une trompe.',
      options: [
        FillTheBlankOption(optionText: 'Éléphant'),
        FillTheBlankOption(optionText: 'Lion'),
        FillTheBlankOption(optionText: 'Tigre'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'est un animal qui court vite.',
      options: [
        FillTheBlankOption(optionText: 'Cheval'),
        FillTheBlankOption(optionText: 'Vache'),
        FillTheBlankOption(optionText: 'Ours'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'est un animal qui nage dans l’eau.',
      options: [
        FillTheBlankOption(optionText: 'Poisson'),
        FillTheBlankOption(optionText: 'Oiseau'),
        FillTheBlankOption(optionText: 'Chat'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'est un animal noir et blanc qui mange du bambou.',
      options: [
        FillTheBlankOption(optionText: 'Panda'),
        FillTheBlankOption(optionText: 'Ours'),
        FillTheBlankOption(optionText: 'Tigre'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'est un animal qui saute et mange des carottes.',
      options: [
        FillTheBlankOption(optionText: 'Lapin'),
        FillTheBlankOption(optionText: 'Ours'),
        FillTheBlankOption(optionText: 'Lion'),
      ],
      correctIndex: 0,
    ),
    FillTheBlankExercise(
      questionSuffix: 'est un animal qui dit "Meuh".',
      options: [
        FillTheBlankOption(optionText: 'Vache'),
        FillTheBlankOption(optionText: 'Cheval'),
        FillTheBlankOption(optionText: 'Ours'),
      ],
      correctIndex: 0,
    ),
  ],
};
