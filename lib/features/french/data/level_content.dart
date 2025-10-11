import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/data/models/subject/level_content.dart';
import 'package:le_petit_davinci/features/levels/models/activities/audio_matching_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/letter_tracing_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/fill_the_blank_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/listen_and_choose_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/reorder_words_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/memory_card_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/multiple_choice_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/solve_equation_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/count_by_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/follow_pattern_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/number_matching_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/shape_pattern_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/arrange_numbers_activity.dart';
import 'package:le_petit_davinci/features/levels/models/audio_pair_model.dart';
import 'package:le_petit_davinci/features/levels/models/fill_the_blank_option_model.dart';
import 'package:le_petit_davinci/features/levels/models/selectable_option_model.dart';
import 'package:le_petit_davinci/features/levels/models/pattern_models.dart';
import 'package:le_petit_davinci/features/levels/models/memory_card_models.dart';
import 'package:le_petit_davinci/features/levels/models/number_matching_models.dart';

final Map<int, LevelContent> unifiedFrenchLevels = {
  // ========== Group 1: A, B, C, D ==========
  1: LevelSet(
    title: 'Test Level - Toutes les Activités',
    introduction: 'Testons toutes les activités disponibles !',
    lessonId: 'test_all_activities_fr',
    activities: [
      // Lesson Activities (auto-complete) 
      LetterTracingActivity(
        letter: 'A',
        prompt: 'Trace la lettre "A" !',
      ), 
      MemoryCardActivity(
        instruction: 'Trouve les paires !',
        cardPairs: [
          CardPair(
            pairId: 'pair1',
            card1: MemoryCard(
              id: 'card1a',
              frontImage: ImageAssets.apple,
              backContent: ImageAssets.apple,
              type: CardType.image,
              label: 'Pomme',
            ),
            card2: MemoryCard(
              id: 'card1b',
              frontImage: ImageAssets.apple,
              backContent: ImageAssets.apple,
              type: CardType.image,
              label: 'Pomme',
            ),
          ),
          CardPair(
            pairId: 'pair2',
            card1: MemoryCard(
              id: 'card2a',
              frontImage: ImageAssets.cat,
              backContent: ImageAssets.cat,
              type: CardType.image,
              label: 'Chat',
            ),
            card2: MemoryCard(
              id: 'card2b',
              frontImage: ImageAssets.cat,
              backContent: ImageAssets.cat,
              type: CardType.image,
              label: 'Chat',
            ),
          ),
        ],
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
      MultipleChoiceActivity(
        instruction: 'Quelle lettre vient après A ?',
        options: [
          SelectableOption(label: 'B', imagePath: ImageAssets.apple),
          SelectableOption(label: 'C', imagePath: ImageAssets.cat),
          SelectableOption(label: 'D', imagePath: ImageAssets.dog),
        ],
        correctIndices: [0],
      ),
      // Exercise Activities (require validation)
      FillTheBlankActivity(
        questionSuffix: ' comme dans Arbre.',
        options: [
          FillTheBlankOption(optionText: 'A'),
          FillTheBlankOption(optionText: 'B'),
          FillTheBlankOption(optionText: 'C'),
        ],
        correctAnswer: 0,
      ),
      ListenAndChooseActivity(
        imageAssets: [
          ImageAssets.apple,
          ImageAssets.cat,
          ImageAssets.dog,
          ImageAssets.bird,
        ],
        correctAnswer: 0,
        label: 'Pomme',
      ),
      ReorderWordsActivity(
        words: ['est', 'un', 'Ceci', 'chat'],
        correctOrder: [2, 0, 1, 3],
      ),
      SolveEquationActivity(
        equation: '2 + 3 = ?',
        options: [3, 4, 5, 6],
        correctAnswer: 5,
      ),
      CountByActivity(
        instruction: 'Compte par 2 !',
        initialSequence: [2, 4, 6],
        numberOfInputs: 2,
        correctAnswers: [8, 10],
      ),
      FollowPatternActivity(
        instruction: 'Suit le motif !',
        examples: ['2, 4, 6', '1, 3, 5'],
        question: 'Quel est le prochain nombre ?',
        options: [7, 8, 9, 10],
        correctAnswerIndex: 1,
      ),
      NumberMatchingActivity(
        instruction: 'Associe les nombres !',
        items: [
          NumberMatchingItem(number: '1', imageAsset: ImageAssets.apple, quantity: 1),
          NumberMatchingItem(number: '2', imageAsset: ImageAssets.cat, quantity: 2),
        ],
      ),
      ShapePatternActivity(
        instruction: 'Trouve le motif des formes !',
        patternImages: [
          ImageAssets.apple,
          ImageAssets.cat,
          ImageAssets.apple,
        ],
        optionImages: [
          ImageAssets.cat,
          ImageAssets.dog,
          ImageAssets.bird,
        ],
        correctIndex: 0,
        patternType: PatternType.shapes,
      ),
      ArrangeNumbersActivity(
        instruction: 'Range les nombres dans l\'ordre !',
        numbers: [3, 1, 4, 2],
        isAscending: true,
      ),
      // StoryProblemActivity(
      //   instruction: 'Résous ce problème !',
      //   draggableOptions: [
      //     DraggableItem(id: 'apple1', label: 'Pomme', value: 1, imageAsset: ImageAssets.apple),
      //     DraggableItem(id: 'apple2', label: 'Pomme', value: 1, imageAsset: ImageAssets.apple),
      //   ],
      //   correctTotalValue: 2,
      // ),
      // StoryActivity(
      //   title: 'Histoire du petit chat',
      //   elements: [
      //     DialogueLine(
      //       characterName: 'Narrateur',
      //       avatarAsset: ImageAssets.cat,
      //       text: 'Il était une fois un petit chat qui aimait jouer dans le jardin.',
      //     ),
      //   ],
      // ),
    ],
  ),
  2: LevelSet(
    title: 'Exercices - A, B, C, D',
    introduction: 'Testons nos connaissances des lettres A, B, C, et D !',
    activities: [
      FillTheBlankActivity(
        questionSuffix: ' comme dans Arbre.',
        options: [
          FillTheBlankOption(optionText: 'A'),
          FillTheBlankOption(optionText: 'B'),
          FillTheBlankOption(optionText: 'C'),
        ],
        correctAnswer: 0,
      ),
      ListenAndChooseActivity(
        imageAssets: [
          ImageAssets.apple, // Placeholder for Arbre
          ImageAssets.cat,
          ImageAssets.dog,
          ImageAssets.bird,
        ],
        correctAnswer: 0,
        label: 'Arbre',
      ),
    ],
  ),
  3: LevelSet(
    title: 'Exercices avancés - A, B, C, D',
    introduction: 'Pratiquons avec des phrases et des mots !',
    activities: [
      ReorderWordsActivity(
        words: ['est', 'un', 'Ceci', 'chat'],
        correctOrder: [2, 0, 1, 3],
      ),
      FillTheBlankActivity(
        questionSuffix: ' comme dans Dinosaure.',
        options: [
          FillTheBlankOption(optionText: 'B'),
          FillTheBlankOption(optionText: 'C'),
          FillTheBlankOption(optionText: 'D'),
        ],
        correctAnswer: 2,
      ),
    ],
  ),

  // ========== Group 2: E, F, G, H ==========
  4: LevelSet(
    title: 'Alphabet - E, F, G, H',
    introduction: 'Il est temps d\'apprendre E, F, G, et H !',
    lessonId: 'alphabet_efgh_fr',
    activities: [
      LetterTracingActivity(
        letter: 'E',
        prompt: 'Trace la lettre "E" !',
      ),
      LetterTracingActivity(
        letter: 'F',
        prompt: 'Trace la lettre "F" !',
      ),
      LetterTracingActivity(
        letter: 'G',
        prompt: 'Trace la lettre "G" !',
      ),
      LetterTracingActivity(
        letter: 'H',
        prompt: 'Trace la lettre "H" !',
      ),
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
  5: LevelSet(
    title: 'Exercices - E, F, G, H',
    introduction: 'Testons nos connaissances des lettres E, F, G, et H !',
    activities: [
      FillTheBlankActivity(
        questionSuffix: ' comme dans Éléphant.',
        options: [
          FillTheBlankOption(optionText: 'E'),
          FillTheBlankOption(optionText: 'F'),
          FillTheBlankOption(optionText: 'G'),
        ],
        correctAnswer: 0,
      ),
      ListenAndChooseActivity(
        imageAssets: [
          ImageAssets.elephant,
          ImageAssets.fish,
          ImageAssets.lion,
          ImageAssets.bear,
        ],
        correctAnswer: 0,
        label: 'Éléphant',
      ),
    ],
  ),
  6: LevelSet(
    title: 'Exercices',
    introduction: 'Pratiquons nos connaissances !',
    activities: [
      ReorderWordsActivity(
        words: ['est', 'un', 'Ceci', 'poisson'],
        correctOrder: [2, 0, 1, 3],
      ),

      FillTheBlankActivity(
        questionSuffix: ' comme dans Hibou.',
        options: [
          FillTheBlankOption(optionText: 'F'),
          FillTheBlankOption(optionText: 'G'),
          FillTheBlankOption(optionText: 'H'),
        ],
        correctAnswer: 2,
      ),
    ],
  ),

  // ========== Group 3: I, J, K, L ==========
  7: LevelSet(
    title: 'Alphabet - I, J, K, L',
    introduction: 'Apprenons I, J, K, et L !',
    lessonId: 'alphabet_ijkl_fr',
    activities: [
      LetterTracingActivity(
        letter: 'I',
        prompt: 'Trace la lettre "I" !',
      ),
      LetterTracingActivity(
        letter: 'J',
        prompt: 'Trace la lettre "J" !',
      ),
      LetterTracingActivity(
        letter: 'K',
        prompt: 'Trace la lettre "K" !',
      ),
      LetterTracingActivity(
        letter: 'L',
        prompt: 'Trace la lettre "L" !',
      ),
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
  8: LevelSet(
    title: 'Exercices',
    introduction: 'Pratiquons nos connaissances !',
    activities: [
      FillTheBlankActivity(
        questionSuffix: ' comme dans Igloo.',
        options: [
          FillTheBlankOption(optionText: 'I'),
          FillTheBlankOption(optionText: 'J'),
          FillTheBlankOption(optionText: 'K'),
        ],
        correctAnswer: 0,
      ),

      ListenAndChooseActivity(
        imageAssets: [
          ImageAssets.lion,
          ImageAssets.tiger,
          ImageAssets.bear,
          ImageAssets.cat,
        ],
        correctAnswer: 0,
        label: 'Lion',
      ),
    ],
  ),
  9: LevelSet(
    title: 'Exercices',
    introduction: 'Pratiquons nos connaissances !',
    activities: [
      ReorderWordsActivity(
        words: ['un', 'est', 'Ceci', 'koala'], // Placeholder
        correctOrder: [2, 1, 0, 3],
      ),

      FillTheBlankActivity(
        questionSuffix: ' comme dans Jus.', // Placeholder
        options: [
          FillTheBlankOption(optionText: 'J'),
          FillTheBlankOption(optionText: 'K'),
          FillTheBlankOption(optionText: 'L'),
        ],
        correctAnswer: 0,
      ),
    ],
  ),
 
  
};
