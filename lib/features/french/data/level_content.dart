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

final Map<int, LevelContent> unifiedFrenchLevels = {
  // ========== Group 1: A, B, C, D ==========
  1: LessonSet(
    Lesson(
      lessonId: 'alphabet_abcd_fr',
      title: 'Alphabet - A, B, C, D',
      introduction: 'Apprenons les lettres A, B, C, et D !',
      activities: [
        DrawingActivity(
          prompt: 'Apprenons à écrire la lettre "A" !',
          templateImagePath: ImageAssets.drawableA,
        ),
        DrawingActivity(
          prompt: 'Super ! Maintenant, écrivons la lettre "B" !',
          templateImagePath: ImageAssets.drawableB,
        ),
        DrawingActivity(
          prompt: 'Génial ! Voici le "C" !',
          templateImagePath: ImageAssets.drawableC,
        ),
        DrawingActivity(
          prompt: 'Tu te débrouilles très bien ! Écrivons "D" !',
          templateImagePath: ImageAssets.drawableD,
        ),
        AudioMatchingActivity(
          prompt: 'Associe le son à la lettre !',
          pairs: [
            AudioWordPair(audioAssetPath: AudioAssets.a_fr, word: 'A'),
            AudioWordPair(audioAssetPath: AudioAssets.b_fr, word: 'B'),
            AudioWordPair(audioAssetPath: AudioAssets.c_fr, word: 'C'),
            AudioWordPair(audioAssetPath: AudioAssets.d_fr, word: 'D'),
          ],
        ),
      ],
    ),
  ),
  2: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' comme dans Arbre.',
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
          ImageAssets.apple, // Placeholder for Arbre
          ImageAssets.cat,
          ImageAssets.dog,
          ImageAssets.bird,
        ],
        correctIndex: 0,
        label: 'Arbre',
      ),
    ),
  ]),
  3: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['est', 'un', 'Ceci', 'chat'],
        correctOrder: [2, 0, 1, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' comme dans Dinosaure.',
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
      lessonId: 'alphabet_efgh_fr',
      title: 'Alphabet - E, F, G, H',
      introduction: 'Il est temps d\'apprendre E, F, G, et H !',
      activities: [
        DrawingActivity(
          prompt: 'Commençons par "E" !',
          templateImagePath: ImageAssets.drawableE,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Le suivant est "F" !',
          templateImagePath: ImageAssets.drawableF,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Maintenant, le "G" !',
          templateImagePath: ImageAssets.drawableG,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Et enfin, "H" !',
          templateImagePath: ImageAssets.drawableH,
        ), // Placeholder
        AudioMatchingActivity(
          prompt: 'Associe le son à la lettre !',
          pairs: [
            AudioWordPair(audioAssetPath: AudioAssets.e_fr, word: 'E'),
            AudioWordPair(audioAssetPath: AudioAssets.f_fr, word: 'F'),
            AudioWordPair(audioAssetPath: AudioAssets.g_fr, word: 'G'),
            AudioWordPair(audioAssetPath: AudioAssets.h_fr, word: 'H'),
          ],
        ),
      ],
    ),
  ),
  5: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' comme dans Éléphant.',
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
        label: 'Éléphant',
      ),
    ),
  ]),
  6: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['est', 'un', 'Ceci', 'poisson'],
        correctOrder: [2, 0, 1, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' comme dans Hibou.',
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
      lessonId: 'alphabet_ijkl_fr',
      title: 'Alphabet - I, J, K, L',
      introduction: 'Apprenons I, J, K, et L !',
      activities: [
        DrawingActivity(
          prompt: 'Écrivons "I" !',
          templateImagePath: ImageAssets.drawableI,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Le suivant est "J" !',
          templateImagePath: ImageAssets.drawableJ,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Voici le "K" !',
          templateImagePath: ImageAssets.drawableK,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Et maintenant "L" !',
          templateImagePath: ImageAssets.drawableL,
        ), // Placeholder
        AudioMatchingActivity(
          prompt: 'Associe le son à la lettre !',
          pairs: [
            AudioWordPair(audioAssetPath: AudioAssets.i_fr, word: 'I'),
            AudioWordPair(audioAssetPath: AudioAssets.j_fr, word: 'J'),
            AudioWordPair(audioAssetPath: AudioAssets.k_fr, word: 'K'),
            AudioWordPair(audioAssetPath: AudioAssets.l_fr, word: 'L'),
          ],
        ),
      ],
    ),
  ),
  8: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' comme dans Igloo.',
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
        words: ['un', 'est', 'Ceci', 'koala'], // Placeholder
        correctOrder: [2, 1, 0, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' comme dans Jus.', // Placeholder
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
      lessonId: 'alphabet_mnop_fr',
      title: 'Alphabet - M, N, O, P',
      introduction: 'Apprenons M, N, O, et P !',
      activities: [
        DrawingActivity(
          prompt: 'Écrivons "M" !',
          templateImagePath: ImageAssets.drawableM,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Le suivant est "N" !',
          templateImagePath: ImageAssets.drawableN,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Voici le "O" !',
          templateImagePath: ImageAssets.drawableO,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Et maintenant "P" !',
          templateImagePath: ImageAssets.drawableP,
        ), // Placeholder
        AudioMatchingActivity(
          prompt: 'Associe le son à la lettre !',
          pairs: [
            AudioWordPair(audioAssetPath: AudioAssets.m_fr, word: 'M'),
            AudioWordPair(audioAssetPath: AudioAssets.n_fr, word: 'N'),
            AudioWordPair(audioAssetPath: AudioAssets.o_fr, word: 'O'),
            AudioWordPair(audioAssetPath: AudioAssets.p_fr, word: 'P'),
          ],
        ),
      ],
    ),
  ),
  11: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' comme dans Montagne.',
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
        label: 'Nid', // Placeholder
      ),
    ),
  ]),
  12: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['est', 'un', 'Ceci', 'oiseau'], // Placeholder
        correctOrder: [2, 0, 1, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' comme dans Poisson.',
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
      lessonId: 'alphabet_qrst_fr',
      title: 'Alphabet - Q, R, S, T',
      introduction: 'Apprenons Q, R, S, et T !',
      activities: [
        DrawingActivity(
          prompt: 'Écrivons "Q" !',
          templateImagePath: ImageAssets.drawableQ,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Le suivant est "R" !',
          templateImagePath: ImageAssets.drawableR,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Voici le "S" !',
          templateImagePath: ImageAssets.drawableS,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Et maintenant "T" !',
          templateImagePath: ImageAssets.drawableT,
        ), // Placeholder
        AudioMatchingActivity(
          prompt: 'Associe le son à la lettre !',
          pairs: [
            AudioWordPair(audioAssetPath: AudioAssets.q_fr, word: 'Q'),
            AudioWordPair(audioAssetPath: AudioAssets.r_fr, word: 'R'),
            AudioWordPair(audioAssetPath: AudioAssets.s_fr, word: 'S'),
            AudioWordPair(audioAssetPath: AudioAssets.t_fr, word: 'T'),
          ],
        ),
      ],
    ),
  ),
  14: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' comme dans Quille.',
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
        label: 'Robot', // Placeholder
      ),
    ),
  ]),
  15: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['est', 'un', 'Ceci', 'serpent'], // Placeholder
        correctOrder: [2, 0, 1, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' comme dans Tortue.',
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
      lessonId: 'alphabet_uvwx_fr',
      title: 'Alphabet - U, V, W, X',
      introduction: 'Apprenons U, V, W, et X !',
      activities: [
        DrawingActivity(
          prompt: 'Écrivons "U" !',
          templateImagePath: ImageAssets.drawableU,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Le suivant est "V" !',
          templateImagePath: ImageAssets.drawableV,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Voici le "W" !',
          templateImagePath: ImageAssets.drawableW,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Et maintenant "X" !',
          templateImagePath: ImageAssets.drawableX,
        ), // Placeholder
        AudioMatchingActivity(
          prompt: 'Associe le son à la lettre !',
          pairs: [
            AudioWordPair(audioAssetPath: AudioAssets.u_fr, word: 'U'),
            AudioWordPair(audioAssetPath: AudioAssets.v_fr, word: 'V'),
            AudioWordPair(audioAssetPath: AudioAssets.w_fr, word: 'W'),
            AudioWordPair(audioAssetPath: AudioAssets.x_fr, word: 'X'),
          ],
        ),
      ],
    ),
  ),
  17: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' comme dans Uniforme.',
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
        label: 'Violon', // Placeholder
      ),
    ),
  ]),
  18: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['est', 'un', 'Ceci', 'wagon'], // Placeholder
        correctOrder: [2, 0, 1, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' comme dans Xylophone.',
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
      lessonId: 'alphabet_yz_fr',
      title: 'Alphabet - Y, Z',
      introduction: 'Apprenons les deux dernières lettres, Y et Z !',
      activities: [
        DrawingActivity(
          prompt: 'Presque fini ! Écrivons "Y" !',
          templateImagePath: ImageAssets.drawableY,
        ), // Placeholder
        DrawingActivity(
          prompt: 'Et la dernière, "Z" !',
          templateImagePath: ImageAssets.drawableZ,
        ), // Placeholder
        AudioMatchingActivity(
          prompt: 'Associe le son à la lettre !',
          pairs: [
            AudioWordPair(audioAssetPath: AudioAssets.y_fr, word: 'Y'),
            AudioWordPair(audioAssetPath: AudioAssets.z_fr, word: 'Z'),
          ],
        ),
      ],
    ),
  ),
  20: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' comme dans Yaourt.',
        options: [
          FillTheBlankOption(optionText: 'Y'),
          FillTheBlankOption(optionText: 'Z'),
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
        label: 'Zèbre', // Placeholder
      ),
    ),
  ]),
  21: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['est', 'un', 'Ceci', 'zèbre'],
        correctOrder: [2, 0, 1, 3],
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' comme dans Zéro.',
        options: [
          FillTheBlankOption(optionText: 'Y'),
          FillTheBlankOption(optionText: 'Z'),
        ],
        correctIndex: 1,
      ),
    ),
  ]),

  // ========== Animals Path ==========

  // ========== Lesson 1: Farm Animals ==========
  22: LessonSet(
    Lesson(
      lessonId: 'farm_animals_1_fr',
      title: 'Les animaux de la ferme',
      introduction: 'Apprenons à connaître les animaux de la ferme !',
      activities: [
        VideoActivity(videoId: 'febfeifibge'),
        AudioMatchingActivity(
          prompt: 'Associe l\'animal à son cri !',
          pairs: [
            AudioWordPair(
              audioAssetPath: AudioAssets.a_fr, // Placeholder
              word: 'Vache',
            ),
            AudioWordPair(
              audioAssetPath: AudioAssets.b_fr, // Placeholder
              word: 'Cochon',
            ),
            AudioWordPair(
              audioAssetPath: AudioAssets.c_fr, // Placeholder
              word: 'Mouton',
            ),
            AudioWordPair(
              audioAssetPath: AudioAssets.d_fr, // Placeholder
              word: 'Poule',
            ),
          ],
        ),
      ],
    ),
  ),
  23: ExerciseSet([
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.cat, // Placeholder for Vache
          ImageAssets.dog, // Placeholder for Cochon
          ImageAssets.bird, // Placeholder for Mouton
          ImageAssets.fish, // Placeholder for Poule
        ],
        correctIndex: 0,
        label: 'Vache',
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' dit "groin groin".',
        options: [
          FillTheBlankOption(optionText: 'Un cochon'),
          FillTheBlankOption(optionText: 'Une vache'),
          FillTheBlankOption(optionText: 'Un mouton'),
        ],
        correctIndex: 0,
      ),
    ),
  ]),
  24: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['donne', 'de', 'Le', 'mouton', 'la', 'laine'],
        correctOrder: [2, 3, 0, 1, 4, 5],
      ),
    ),
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.cat, // Placeholder for Cheval
          ImageAssets.dog, // Placeholder for Canard
          ImageAssets.bird, // Placeholder for Chèvre
          ImageAssets.fish, // Placeholder for Poule
        ],
        correctIndex: 3,
        label: 'Poule',
      ),
    ),
  ]),
  25: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' est un bébé mouton.',
        options: [
          FillTheBlankOption(optionText: 'Un agneau'),
          FillTheBlankOption(optionText: 'Un veau'),
          FillTheBlankOption(optionText: 'Un porcelet'),
        ],
        correctIndex: 0,
      ),
    ),
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['La', 'vache', 'mange', 'de', 'l\'herbe'],
        correctOrder: [0, 1, 2, 3, 4],
      ),
    ),
  ]),

  // ========== Lesson 2: Wild Animals ==========
  26: LessonSet(
    Lesson(
      lessonId: 'wild_animals_1_fr',
      title: 'Les animaux sauvages',
      introduction: 'Explorons les animaux dans la nature !',
      activities: [
        VideoActivity(
          videoId: 'febfeifibge', // Placeholder
        ),
        AudioMatchingActivity(
          prompt: 'Associe l\'animal à son cri !',
          pairs: [
            AudioWordPair(
              audioAssetPath: AudioAssets.e_fr, // Placeholder
              word: 'Lion',
            ),
            AudioWordPair(
              audioAssetPath: AudioAssets.f_fr, // Placeholder
              word: 'Tigre',
            ),
            AudioWordPair(
              audioAssetPath: AudioAssets.g_fr, // Placeholder
              word: 'Ours',
            ),
            AudioWordPair(
              audioAssetPath: AudioAssets.h_fr, // Placeholder
              word: 'Éléphant',
            ),
          ],
        ),
      ],
    ),
  ),
  27: ExerciseSet([
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.lion,
          ImageAssets.tiger,
          ImageAssets.bear,
          ImageAssets.elephant,
        ],
        correctIndex: 0,
        label: 'Lion',
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' est le roi de la jungle.',
        options: [
          FillTheBlankOption(optionText: 'Le lion'),
          FillTheBlankOption(optionText: 'Le tigre'),
          FillTheBlankOption(optionText: 'L\'ours'),
        ],
        correctIndex: 0,
      ),
    ),
  ]),
  28: ExerciseSet([
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['a', 'une', 'Un', 'éléphant', 'longue', 'trompe'],
        correctOrder: [2, 3, 0, 1, 4, 5],
      ),
    ),
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.lion, // Placeholder for Singe
          ImageAssets.tiger, // Placeholder for Girafe
          ImageAssets.bear, // Placeholder for Zèbre
          ImageAssets.elephant, // Placeholder for Tigre
        ],
        correctIndex: 3,
        label: 'Tigre',
      ),
    ),
  ]),
  29: ExerciseSet([
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' a des rayures noires et blanches.',
        options: [
          FillTheBlankOption(optionText: 'Un zèbre'),
          FillTheBlankOption(optionText: 'Une girafe'),
          FillTheBlankOption(optionText: 'Un singe'),
        ],
        correctIndex: 0,
      ),
    ),
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['Le', 'singe', 'aime', 'manger', 'des', 'bananes'],
        correctOrder: [0, 1, 2, 3, 4, 5],
      ),
    ),
  ]),
  30: ExerciseSet([
    Exercise.listenAndChoose(
      ListenAndChooseExercise(
        imageAssets: [
          ImageAssets.lion, // Placeholder for Girafe
          ImageAssets.dog, // Placeholder for Cochon
          ImageAssets.bear,
          ImageAssets.fish,
        ],
        correctIndex: 2,
        label: 'Ours',
      ),
    ),
    Exercise.fillTheBlank(
      FillTheBlankExercise(
        questionSuffix: ' a un très long cou.',
        options: [
          FillTheBlankOption(optionText: 'Une girafe'),
          FillTheBlankOption(optionText: 'Un éléphant'),
          FillTheBlankOption(optionText: 'Un lion'),
        ],
        correctIndex: 0,
      ),
    ),
  ]),
};
