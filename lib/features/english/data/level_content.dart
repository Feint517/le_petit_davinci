import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_option_model.dart';
import 'package:le_petit_davinci/features/exercises/models/listen_and_choose_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/reorder_words_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
import 'package:le_petit_davinci/features/lessons/models/activity_model.dart';

/// A base class to represent the content of any given level.
abstract class LevelContent {}

/// A wrapper for levels that are structured as a full lesson.
class LessonSet extends LevelContent {
  LessonSet(this.lesson);

  final Lesson lesson;
}

/// A wrapper for levels that consist of a list of exercises.
class ExerciseSet extends LevelContent {
  ExerciseSet(this.exercises);

  final List<Exercise> exercises;
}

final Map<int, LevelContent> unifiedEnglishLevels = {
  // ========== Group 1: A, B, C, D ==========
  1: LessonSet(
    Lesson(
      lessonId: 'alphabet_abcd',
      title: 'Alphabet - A, B, C, D',
      introduction: 'Let\'s learn the letters A, B, C, and D!',
      activities: [
        DrawingActivity(
          prompt: 'Let\'s learn to write the letter "A"!',
          templateImagePath: ImageAssets.drawableA,
        ),
        DrawingActivity(
          prompt: 'Great! Now let\'s write the letter "B"!',
          templateImagePath: ImageAssets.drawableB,
        ),
        DrawingActivity(
          prompt: 'Awesome! Here comes "C"!',
          templateImagePath: ImageAssets.drawableC,
        ),
        DrawingActivity(
          prompt: 'You\'re doing great! Let\'s write "D"!',
          templateImagePath: ImageAssets.drawableD,
        ),
        AudioMatchingActivity(
          prompt: 'Match the sound to the letter!',
          pairs: [
            AudioWordPair(audioAssetPath: AudioAssets.a_en, word: 'A'),
            AudioWordPair(audioAssetPath: AudioAssets.b_en, word: 'B'),
            AudioWordPair(audioAssetPath: AudioAssets.c_en, word: 'C'),
            AudioWordPair(audioAssetPath: AudioAssets.d_en, word: 'D'),
          ],
        ),
      ],
    ),
  ),
  2: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is for Apple.',
        options: [
          FillTheBlankOption(optionText: 'A'),
          FillTheBlankOption(optionText: 'B'),
          FillTheBlankOption(optionText: 'C'),
        ],
        correctIndex: 0,
      ),
    ),
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.apple,
          ImageAssets.cat,
          ImageAssets.dog,
          ImageAssets.bird,
        ],
        correctIndex: 0,
        label: 'Apple',
      ),
    ),
  ]),
  3: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['is', 'a', 'This', 'cat'],
        correctOrder: [2, 0, 1, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is for Dog.',
        options: [
          FillTheBlankOption(optionText: 'B'),
          FillTheBlankOption(optionText: 'C'),
          FillTheBlankOption(optionText: 'D'),
        ],
        correctIndex: 2,
      ),
    ),
  ]),

  // ========== Group 2: E, F, G, H ==========
  4: LessonSet(
    Lesson(
      lessonId: 'alphabet_efgh',
      title: 'Alphabet - E, F, G, H',
      introduction: 'Time to learn E, F, G, and H!',
      activities: [
        DrawingActivity(
          prompt: 'Let\'s start with "E"!',
          templateImagePath: ImageAssets.drawableE,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Next up is "F"!',
          templateImagePath: ImageAssets.drawableF,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Now for "G"!',
          templateImagePath: ImageAssets.drawableG,
        ), // Placeholder
        DrawingActivity(
          prompt: 'And finally, "H"!',
          templateImagePath: ImageAssets.drawableH,
        ), // Placeholder
        AudioMatchingActivity(
          prompt: 'Match the sound to the letter!',
          pairs: [
            AudioWordPair(
              audioAssetPath: AudioAssets.e_en,
              word: 'E',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.f_en,
              word: 'F',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.g_en,
              word: 'G',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.h_en,
              word: 'H',
            ), // Placeholder audio
          ],
        ),
      ],
    ),
  ),
  5: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is for Elephant.',
        options: [
          FillTheBlankOption(optionText: 'E'),
          FillTheBlankOption(optionText: 'F'),
          FillTheBlankOption(optionText: 'G'),
        ],
        correctIndex: 0,
      ),
    ),
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.elephant,
          ImageAssets.fish,
          ImageAssets.lion,
          ImageAssets.bear,
        ],
        correctIndex: 0,
        label: 'Elephant',
      ),
    ),
  ]),
  6: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['is', 'a', 'This', 'fish'],
        correctOrder: [2, 0, 1, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is for Hat.',
        options: [
          FillTheBlankOption(optionText: 'F'),
          FillTheBlankOption(optionText: 'G'),
          FillTheBlankOption(optionText: 'H'),
        ],
        correctIndex: 2,
      ),
    ),
  ]),

  // ========== Group 3: I, J, K, L ==========
  7: LessonSet(
    Lesson(
      lessonId: 'alphabet_ijkl',
      title: 'Alphabet - I, J, K, L',
      introduction: 'Let\'s learn I, J, K, and L!',
      activities: [
        DrawingActivity(
          prompt: 'Let\'s write "I"!',
          templateImagePath: ImageAssets.drawableI,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Next is "J"!',
          templateImagePath: ImageAssets.drawableJ,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Here comes "K"!',
          templateImagePath: ImageAssets.drawableK,
        ), // Placeholder
        DrawingActivity(
          prompt: 'And now "L"!',
          templateImagePath: ImageAssets.drawableL,
        ), // Placeholder
        AudioMatchingActivity(
          prompt: 'Match the sound to the letter!',
          pairs: [
            AudioWordPair(
              audioAssetPath: AudioAssets.i_en,
              word: 'I',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.j_en,
              word: 'J',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.k_en,
              word: 'K',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.l_en,
              word: 'L',
            ), // Placeholder audio
          ],
        ),
      ],
    ),
  ),
  8: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is for Igloo.',
        options: [
          FillTheBlankOption(optionText: 'I'),
          FillTheBlankOption(optionText: 'J'),
          FillTheBlankOption(optionText: 'K'),
        ],
        correctIndex: 0,
      ),
    ),
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.lion,
          ImageAssets.tiger,
          ImageAssets.bear,
          ImageAssets.cat,
        ],
        correctIndex: 0,
        label: 'Lion',
      ),
    ),
  ]),
  9: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['a', 'is', 'This', 'kite'], // Placeholder word
        correctOrder: [2, 1, 0, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is for Jam.', // Placeholder
        options: [
          FillTheBlankOption(optionText: 'J'),
          FillTheBlankOption(optionText: 'K'),
          FillTheBlankOption(optionText: 'L'),
        ],
        correctIndex: 0,
      ),
    ),
  ]),

  // ========== Group 4: M, N, O, P ==========
  10: LessonSet(
    Lesson(
      lessonId: 'alphabet_mnop',
      title: 'Alphabet - M, N, O, P',
      introduction: 'Let\'s learn M, N, O, and P!',
      activities: [
        DrawingActivity(
          prompt: 'Let\'s write "M"!',
          templateImagePath: ImageAssets.drawableM,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Next is "N"!',
          templateImagePath: ImageAssets.drawableN,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Here comes "O"!',
          templateImagePath: ImageAssets.drawableO,
        ), // Placeholder
        DrawingActivity(
          prompt: 'And now "P"!',
          templateImagePath: ImageAssets.drawableP,
        ), // Placeholder
        AudioMatchingActivity(
          prompt: 'Match the sound to the letter!',
          pairs: [
            AudioWordPair(
              audioAssetPath: AudioAssets.m_en,
              word: 'M',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.n_en,
              word: 'N',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.o_en,
              word: 'O',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.p_en,
              word: 'P',
            ), // Placeholder audio
          ],
        ),
      ],
    ),
  ),
  11: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is for Moon.',
        options: [
          FillTheBlankOption(optionText: 'M'),
          FillTheBlankOption(optionText: 'N'),
          FillTheBlankOption(optionText: 'O'),
        ],
        correctIndex: 0,
      ),
    ),
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.cat,
          ImageAssets.dog,
          ImageAssets.bird,
          ImageAssets.fish,
        ],
        correctIndex: 0,
        label: 'Nest', // Placeholder
      ),
    ),
  ]),
  12: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['is', 'an', 'This', 'octopus'], // Placeholder
        correctOrder: [2, 0, 1, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is for Pen.',
        options: [
          FillTheBlankOption(optionText: 'N'),
          FillTheBlankOption(optionText: 'O'),
          FillTheBlankOption(optionText: 'P'),
        ],
        correctIndex: 2,
      ),
    ),
  ]),

  // ========== Group 5: Q, R, S, T ==========
  13: LessonSet(
    Lesson(
      lessonId: 'alphabet_qrst',
      title: 'Alphabet - Q, R, S, T',
      introduction: 'Let\'s learn Q, R, S, and T!',
      activities: [
        DrawingActivity(
          prompt: 'Let\'s write "Q"!',
          templateImagePath: ImageAssets.drawableQ,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Next is "R"!',
          templateImagePath: ImageAssets.drawableR,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Here comes "S"!',
          templateImagePath: ImageAssets.drawableS,
        ), // Placeholder
        DrawingActivity(
          prompt: 'And now "T"!',
          templateImagePath: ImageAssets.drawableT,
        ), // Placeholder
        AudioMatchingActivity(
          prompt: 'Match the sound to the letter!',
          pairs: [
            AudioWordPair(
              audioAssetPath: AudioAssets.q_en,
              word: 'Q',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.r_en,
              word: 'R',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.s_en,
              word: 'S',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.t_en,
              word: 'T',
            ), // Placeholder audio
          ],
        ),
      ],
    ),
  ),
  14: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is for Queen.',
        options: [
          FillTheBlankOption(optionText: 'Q'),
          FillTheBlankOption(optionText: 'R'),
          FillTheBlankOption(optionText: 'S'),
        ],
        correctIndex: 0,
      ),
    ),
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.tiger,
          ImageAssets.lion,
          ImageAssets.bear,
          ImageAssets.cat,
        ],
        correctIndex: 0,
        label: 'Rabbit', // Placeholder
      ),
    ),
  ]),
  15: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['is', 'The', 'sun', 'shining'], // Placeholder
        correctOrder: [1, 2, 0, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is for Tiger.',
        options: [
          FillTheBlankOption(optionText: 'R'),
          FillTheBlankOption(optionText: 'S'),
          FillTheBlankOption(optionText: 'T'),
        ],
        correctIndex: 2,
      ),
    ),
  ]),

  // ========== Group 6: U, V, W, X ==========
  16: LessonSet(
    Lesson(
      lessonId: 'alphabet_uvwx',
      title: 'Alphabet - U, V, W, X',
      introduction: 'Let\'s learn U, V, W, and X!',
      activities: [
        DrawingActivity(
          prompt: 'Let\'s write "U"!',
          templateImagePath: ImageAssets.drawableU,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Next is "V"!',
          templateImagePath: ImageAssets.drawableV,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Here comes "W"!',
          templateImagePath: ImageAssets.drawableW,
        ), // Placeholder
        DrawingActivity(
          prompt: 'And now "X"!',
          templateImagePath: ImageAssets.drawableX,
        ), // Placeholder
        AudioMatchingActivity(
          prompt: 'Match the sound to the letter!',
          pairs: [
            AudioWordPair(
              audioAssetPath: AudioAssets.u_en,
              word: 'U',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.v_en,
              word: 'V',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.w_en,
              word: 'W',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.x_en,
              word: 'X',
            ), // Placeholder audio
          ],
        ),
      ],
    ),
  ),
  17: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is for Umbrella.',
        options: [
          FillTheBlankOption(optionText: 'U'),
          FillTheBlankOption(optionText: 'V'),
          FillTheBlankOption(optionText: 'W'),
        ],
        correctIndex: 0,
      ),
    ),
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.cat,
          ImageAssets.dog,
          ImageAssets.bird,
          ImageAssets.fish,
        ],
        correctIndex: 0,
        label: 'Van', // Placeholder
      ),
    ),
  ]),
  18: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['is', 'a', 'This', 'watch'], // Placeholder
        correctOrder: [2, 0, 1, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is for X-ray.',
        options: [
          FillTheBlankOption(optionText: 'V'),
          FillTheBlankOption(optionText: 'W'),
          FillTheBlankOption(optionText: 'X'),
        ],
        correctIndex: 2,
      ),
    ),
  ]),

  // ========== Group 7: Y, Z ==========
  19: LessonSet(
    Lesson(
      lessonId: 'alphabet_yz',
      title: 'Alphabet - Y, Z',
      introduction: 'Let\'s learn the last two letters: Y and Z!',
      activities: [
        DrawingActivity(
          prompt: 'Let\'s write "Y"!',
          templateImagePath: ImageAssets.drawableY,
        ), // Placeholder
        DrawingActivity(
          prompt: 'And finally, "Z"!',
          templateImagePath: ImageAssets.drawableZ,
        ), // Placeholder
        AudioMatchingActivity(
          prompt: 'Match the sound to the letter!',
          pairs: [
            AudioWordPair(
              audioAssetPath: AudioAssets.y_en,
              word: 'Y',
            ), // Placeholder audio
            AudioWordPair(
              audioAssetPath: AudioAssets.z_en,
              word: 'Z',
            ), // Placeholder audio
          ],
        ),
      ],
    ),
  ),
  20: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is for Yo-yo.',
        options: [
          FillTheBlankOption(optionText: 'Y'),
          FillTheBlankOption(optionText: 'Z'),
          FillTheBlankOption(optionText: 'A'),
        ],
        correctIndex: 0,
      ),
    ),
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.cat,
          ImageAssets.dog,
          ImageAssets.bird,
          ImageAssets.fish,
        ],
        correctIndex: 0,
        label: 'Zebra', // Placeholder
      ),
    ),
  ]),
  21: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['is', 'a', 'This', 'zebra'], // Placeholder
        correctOrder: [2, 0, 1, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is for Zipper.',
        options: [
          FillTheBlankOption(optionText: 'X'),
          FillTheBlankOption(optionText: 'Y'),
          FillTheBlankOption(optionText: 'Z'),
        ],
        correctIndex: 2,
      ),
    ),
  ]),

  // ========== Animals: Farm ==========
  22: LessonSet(
    Lesson(
      lessonId: 'farm_animals_101',
      title: 'Fun on the Farm!',
      introduction: 'Let\'s learn about some animals that live on a farm.',
      activities: [
        VideoActivity(videoId: 'CA6Mofzh7jo'),
        AudioMatchingActivity(
          prompt: 'Match the animal to its sound!',
          pairs: [
            AudioWordPair(
              audioAssetPath: AudioAssets.a_en,
              word: 'Cow',
            ), // Placeholder
            AudioWordPair(
              audioAssetPath: AudioAssets.b_en,
              word: 'Sheep',
            ), // Placeholder
            AudioWordPair(
              audioAssetPath: AudioAssets.c_en,
              word: 'Pig',
            ), // Placeholder
            AudioWordPair(
              audioAssetPath: AudioAssets.d_en,
              word: 'Chicken',
            ), // Placeholder
          ],
        ),
      ],
    ),
  ),
  23: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: " says 'moo'.",
        options: [
          FillTheBlankOption(optionText: 'A Cow'),
          FillTheBlankOption(optionText: 'A Sheep'),
          FillTheBlankOption(optionText: 'A Pig'),
        ],
        correctIndex: 0,
      ),
    ),
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.cat, // Placeholder
          ImageAssets.dog, // Placeholder
          ImageAssets.bird, // Placeholder
          ImageAssets.fish, // Placeholder
        ],
        correctIndex: 1,
        label: 'Cow',
      ),
    ),
  ]),
  24: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['The', 'pig', 'likes', 'mud'],
        correctOrder: [0, 1, 2, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' gives us wool.',
        options: [
          FillTheBlankOption(optionText: 'A Chicken'),
          FillTheBlankOption(optionText: 'A Sheep'),
          FillTheBlankOption(optionText: 'A Cow'),
        ],
        correctIndex: 1,
      ),
    ),
  ]),

  // ========== Animals: Wild ==========
  25: LessonSet(
    Lesson(
      lessonId: 'wild_animals_101',
      title: 'A Trip to the Jungle!',
      introduction: 'Let\'s learn about some animals that live in the wild.',
      activities: [
        VideoActivity(videoId: 'T3_v_mmvCC4'),
        AudioMatchingActivity(
          prompt: 'Match the animal to its name!',
          pairs: [
            AudioWordPair(audioAssetPath: AudioAssets.lionName, word: 'Lion'),
            AudioWordPair(audioAssetPath: AudioAssets.tigerName, word: 'Tiger'),
            AudioWordPair(
              audioAssetPath: AudioAssets.elephantName,
              word: 'Elephant',
            ),
            AudioWordPair(
              audioAssetPath: AudioAssets.monkeyName,
              word: 'Monkey',
            ),
          ],
        ),
      ],
    ),
  ),
  26: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is the king of the jungle.',
        options: [
          FillTheBlankOption(optionText: 'A Tiger'),
          FillTheBlankOption(optionText: 'A Lion'),
          FillTheBlankOption(optionText: 'An Elephant'),
        ],
        correctIndex: 1,
      ),
    ),
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.tiger,
          ImageAssets.bear,
          ImageAssets.elephant,
          ImageAssets.lion,
        ],
        correctIndex: 0,
        label: 'Tiger',
      ),
    ),
  ]),
  27: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['The', 'monkey', 'eats', 'bananas'],
        correctOrder: [0, 1, 2, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' has a very long trunk.',
        options: [
          FillTheBlankOption(optionText: 'An Elephant'),
          FillTheBlankOption(optionText: 'A Monkey'),
          FillTheBlankOption(optionText: 'A Lion'),
        ],
        correctIndex: 0,
      ),
    ),
  ]),

  // ========== Animals: Mixed Review ==========
  28: ExerciseSet([
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.dog,
          ImageAssets.lion,
          ImageAssets.cat,
          ImageAssets.bear,
        ],
        correctIndex: 3,
        label: 'Monkey',
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' has black and white stripes.',
        options: [
          FillTheBlankOption(optionText: 'A Tiger'),
          FillTheBlankOption(optionText: 'A Zebra'),
          FillTheBlankOption(optionText: 'A Cow'),
        ],
        correctIndex: 1,
      ),
    ),
  ]),
  29: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['The', 'cow', 'lives', 'on', 'the', 'farm'],
        correctOrder: [0, 1, 2, 3, 4, 5],
      ),
    ),
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.bird,
          ImageAssets.tiger,
          ImageAssets.fish,
          ImageAssets.elephant,
        ],
        correctIndex: 3,
        label: 'Elephant',
      ),
    ),
  ]),
  30: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' is a big cat with stripes.',
        options: [
          FillTheBlankOption(optionText: 'A Lion'),
          FillTheBlankOption(optionText: 'A Tiger'),
          FillTheBlankOption(optionText: 'A Cat'),
        ],
        correctIndex: 1,
      ),
    ),
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['The', 'elephant', 'is', 'a', 'wild', 'animal'],
        correctOrder: [0, 1, 2, 3, 4, 5],
      ),
    ),
  ]),
};
