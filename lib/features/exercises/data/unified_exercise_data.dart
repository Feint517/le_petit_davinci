import 'package:le_petit_davinci/features/english/level_content.dart';
import 'package:le_petit_davinci/features/exercises/models/unified_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_option_model.dart';
import 'package:le_petit_davinci/features/exercises/models/listen_and_choose_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/reorder_words_exercise_model.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/features/lessons3/data/lessons_data3.dart';

final Map<int, LevelContent> unifiedEnglishLevels = {
  1: LessonSet(exampleLesson),
  2: ExerciseSet([
    UnifiedExercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: 'is a pet that purrs.',
        options: [
          FillTheBlankOption(optionText: 'Dog'),
          FillTheBlankOption(optionText: 'Cat'),
          FillTheBlankOption(optionText: 'Bird'),
        ],
        correctIndex: 1,
      ),
    ),
    UnifiedExercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.cat,
          ImageAssets.dog,
          ImageAssets.bird,
          ImageAssets.fish,
        ],
        correctIndex: 0,
        label: 'Cat',
      ),
    ),
    UnifiedExercise.reorderWords(
      ReorderWordsExercise(
        words: ['cat', 'a', 'is', 'banana', 'blue'],
        correctOrder: [2, 1, 0],
      ),
    ),
  ]),
  3: ExerciseSet([
    UnifiedExercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: 'can fly.',
        options: [
          FillTheBlankOption(optionText: 'Bird'),
          FillTheBlankOption(optionText: 'Fish'),
          FillTheBlankOption(optionText: 'Horse'),
        ],
        correctIndex: 0,
      ),
    ),
    UnifiedExercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.bird,
          ImageAssets.cat,
          ImageAssets.dog,
          ImageAssets.fish,
        ],
        correctIndex: 0,
        label: 'Bird',
      ),
    ),
    UnifiedExercise.reorderWords(
      ReorderWordsExercise(
        words: ['dog', 'the', 'barks', 'quickly', 'table'],
        correctOrder: [1, 0, 2],
      ),
    ),
  ]),
  4: ExerciseSet([
    UnifiedExercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: 'is the king of the jungle.',
        options: [
          FillTheBlankOption(optionText: 'Lion'),
          FillTheBlankOption(optionText: 'Tiger'),
          FillTheBlankOption(optionText: 'Elephant'),
        ],
        correctIndex: 0,
      ),
    ),
    UnifiedExercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.lion,
          ImageAssets.tiger,
          ImageAssets.elephant,
          ImageAssets.bear,
        ],
        correctIndex: 0,
        label: 'Lion',
      ),
    ),
    UnifiedExercise.reorderWords(
      ReorderWordsExercise(
        words: ['milk', 'likes', 'cat', 'the', 'banana', 'blue'],
        correctOrder: [3, 2, 1, 0],
      ),
    ),
  ]),
  5: ExerciseSet([
    UnifiedExercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: 'lives in water.',
        options: [
          FillTheBlankOption(optionText: 'Fish'),
          FillTheBlankOption(optionText: 'Dog'),
          FillTheBlankOption(optionText: 'Cat'),
        ],
        correctIndex: 0,
      ),
    ),
    UnifiedExercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.fish,
          ImageAssets.bird,
          ImageAssets.cat,
          ImageAssets.dog,
        ],
        correctIndex: 0,
        label: 'Fish',
      ),
    ),
    UnifiedExercise.reorderWords(
      ReorderWordsExercise(
        words: ['swims', 'the', 'in', 'water', 'fish', 'quickly', 'table'],
        correctOrder: [1, 4, 0, 2, 3],
      ),
    ),
  ]),
  6: ExerciseSet([
    UnifiedExercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: 'has stripes.',
        options: [
          FillTheBlankOption(optionText: 'Tiger'),
          FillTheBlankOption(optionText: 'Elephant'),
          FillTheBlankOption(optionText: 'Bird'),
        ],
        correctIndex: 0,
      ),
    ),
    UnifiedExercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.tiger,
          ImageAssets.lion,
          ImageAssets.elephant,
          ImageAssets.bear,
        ],
        correctIndex: 0,
        label: 'Tiger',
      ),
    ),
    UnifiedExercise.reorderWords(
      ReorderWordsExercise(
        words: ['the', 'tiger', 'has', 'stripes', 'banana', 'blue'],
        correctOrder: [0, 1, 2, 3],
      ),
    ),
  ]),
};

final Map<int, List<UnifiedExercise>> unifiedFrenchLevels = {
  1: [
    // Fill the blank exercise
    UnifiedExercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: 'est le roi de la jungle.',
        options: [
          FillTheBlankOption(optionText: 'Lion'),
          FillTheBlankOption(optionText: 'Tigre'),
          FillTheBlankOption(optionText: 'Éléphant'),
        ],
        correctIndex: 0,
      ),
    ),
    // Listen and choose exercise
    UnifiedExercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.dog,
          ImageAssets.cat,
          ImageAssets.bird,
          ImageAssets.fish,
        ],
        correctIndex: 0,
        label: 'Chien',
      ),
    ),
    // Reorder words exercise
    UnifiedExercise.reorderWords(
      ReorderWordsExercise(
        words: ['chat', 'le', 'est', 'banane', 'bleu'],
        correctOrder: [1, 0, 2],
      ),
    ),
  ],
  2: [
    // Fill the blank exercise
    UnifiedExercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: 'peut voler.',
        options: [
          FillTheBlankOption(optionText: 'Oiseau'),
          FillTheBlankOption(optionText: 'Poisson'),
          FillTheBlankOption(optionText: 'Chien'),
        ],
        correctIndex: 0,
      ),
    ),
    // Listen and choose exercise
    UnifiedExercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.cat,
          ImageAssets.dog,
          ImageAssets.bird,
          ImageAssets.fish,
        ],
        correctIndex: 0,
        label: 'Chat',
      ),
    ),
    // Reorder words exercise
    UnifiedExercise.reorderWords(
      ReorderWordsExercise(
        words: ['chien', 'le', 'aboie', 'vite', 'table'],
        correctOrder: [1, 0, 2],
      ),
    ),
  ],
  3: [
    // Fill the blank exercise
    UnifiedExercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: 'vit dans l\'eau.',
        options: [
          FillTheBlankOption(optionText: 'Poisson'),
          FillTheBlankOption(optionText: 'Chat'),
          FillTheBlankOption(optionText: 'Oiseau'),
        ],
        correctIndex: 0,
      ),
    ),
    // Listen and choose exercise
    UnifiedExercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.fish,
          ImageAssets.bird,
          ImageAssets.cat,
          ImageAssets.dog,
        ],
        correctIndex: 0,
        label: 'Poisson',
      ),
    ),
    // Reorder words exercise
    UnifiedExercise.reorderWords(
      ReorderWordsExercise(
        words: ['nage', 'le', 'dans', 'l\'eau', 'poisson', 'vite', 'table'],
        correctOrder: [1, 4, 0, 2, 3],
      ),
    ),
  ],
  4: [
    // Fill the blank exercise
    UnifiedExercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: 'a des rayures.',
        options: [
          FillTheBlankOption(optionText: 'Tigre'),
          FillTheBlankOption(optionText: 'Éléphant'),
          FillTheBlankOption(optionText: 'Oiseau'),
        ],
        correctIndex: 0,
      ),
    ),
    // Listen and choose exercise
    UnifiedExercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.tiger,
          ImageAssets.lion,
          ImageAssets.elephant,
          ImageAssets.bear,
        ],
        correctIndex: 0,
        label: 'Tigre',
      ),
    ),
    // Reorder words exercise
    UnifiedExercise.reorderWords(
      ReorderWordsExercise(
        words: ['le', 'tigre', 'a', 'des', 'rayures', 'banane'],
        correctOrder: [0, 1, 2, 3, 4],
      ),
    ),
  ],
  5: [
    // Fill the blank exercise
    UnifiedExercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: 'est très grand.',
        options: [
          FillTheBlankOption(optionText: 'Éléphant'),
          FillTheBlankOption(optionText: 'Chat'),
          FillTheBlankOption(optionText: 'Oiseau'),
        ],
        correctIndex: 0,
      ),
    ),
    // Listen and choose exercise
    UnifiedExercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.elephant,
          ImageAssets.tiger,
          ImageAssets.lion,
          ImageAssets.bear,
        ],
        correctIndex: 0,
        label: 'Éléphant',
      ),
    ),
    // Reorder words exercise
    UnifiedExercise.reorderWords(
      ReorderWordsExercise(
        words: ['l\'éléphant', 'est', 'très', 'grand', 'et', 'gris'],
        correctOrder: [0, 1, 2, 3],
      ),
    ),
  ],
  6: [
    // Fill the blank exercise
    UnifiedExercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: 'dort en hiver.',
        options: [
          FillTheBlankOption(optionText: 'Ours'),
          FillTheBlankOption(optionText: 'Poisson'),
          FillTheBlankOption(optionText: 'Oiseau'),
        ],
        correctIndex: 0,
      ),
    ),
    // Listen and choose exercise
    UnifiedExercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.bear,
          ImageAssets.tiger,
          ImageAssets.lion,
          ImageAssets.elephant,
        ],
        correctIndex: 0,
        label: 'Ours',
      ),
    ),
    // Reorder words exercise
    UnifiedExercise.reorderWords(
      ReorderWordsExercise(
        words: ['l\'ours', 'dort', 'en', 'hiver', 'profondément'],
        correctOrder: [0, 1, 2, 3],
      ),
    ),
  ],
  7: [
    // Fill the blank exercise
    UnifiedExercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: 'mange des bananes.',
        options: [
          FillTheBlankOption(optionText: 'Singe'),
          FillTheBlankOption(optionText: 'Lion'),
          FillTheBlankOption(optionText: 'Poisson'),
        ],
        correctIndex: 0,
      ),
    ),
    // Listen and choose exercise
    UnifiedExercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.rabbit,
          ImageAssets.cat,
          ImageAssets.dog,
          ImageAssets.bird,
        ],
        correctIndex: 0,
        label: 'Lapin',
      ),
    ),
    // Reorder words exercise
    UnifiedExercise.reorderWords(
      ReorderWordsExercise(
        words: ['le', 'singe', 'mange', 'des', 'bananes', 'jaunes'],
        correctOrder: [0, 1, 2, 3, 4],
      ),
    ),
  ],
  8: [
    // Fill the blank exercise
    UnifiedExercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: 'saute très haut.',
        options: [
          FillTheBlankOption(optionText: 'Lapin'),
          FillTheBlankOption(optionText: 'Éléphant'),
          FillTheBlankOption(optionText: 'Poisson'),
        ],
        correctIndex: 0,
      ),
    ),
    // Listen and choose exercise
    UnifiedExercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.horse,
          ImageAssets.cow,
          ImageAssets.duck,
          ImageAssets.panda,
        ],
        correctIndex: 0,
        label: 'Cheval',
      ),
    ),
    // Reorder words exercise
    UnifiedExercise.reorderWords(
      ReorderWordsExercise(
        words: ['le', 'lapin', 'saute', 'très', 'haut', 'rapidement'],
        correctOrder: [0, 1, 2, 3, 4],
      ),
    ),
  ],
  9: [
    // Fill the blank exercise
    UnifiedExercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: 'court très vite.',
        options: [
          FillTheBlankOption(optionText: 'Cheval'),
          FillTheBlankOption(optionText: 'Tortue'),
          FillTheBlankOption(optionText: 'Poisson'),
        ],
        correctIndex: 0,
      ),
    ),
    // Listen and choose exercise
    UnifiedExercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.cow,
          ImageAssets.horse,
          ImageAssets.duck,
          ImageAssets.panda,
        ],
        correctIndex: 0,
        label: 'Vache',
      ),
    ),
    // Reorder words exercise
    UnifiedExercise.reorderWords(
      ReorderWordsExercise(
        words: ['le', 'cheval', 'court', 'très', 'vite', 'toujours'],
        correctOrder: [0, 1, 2, 3, 4],
      ),
    ),
  ],
  10: [
    // Fill the blank exercise
    UnifiedExercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: 'donne du lait.',
        options: [
          FillTheBlankOption(optionText: 'Vache'),
          FillTheBlankOption(optionText: 'Lion'),
          FillTheBlankOption(optionText: 'Oiseau'),
        ],
        correctIndex: 0,
      ),
    ),
    // Listen and choose exercise
    UnifiedExercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.duck,
          ImageAssets.cow,
          ImageAssets.horse,
          ImageAssets.panda,
        ],
        correctIndex: 0,
        label: 'Mouton',
      ),
    ),
    // Reorder words exercise
    UnifiedExercise.reorderWords(
      ReorderWordsExercise(
        words: ['la', 'vache', 'donne', 'du', 'lait', 'blanc'],
        correctOrder: [0, 1, 2, 3, 4],
      ),
    ),
  ],
};
