import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/data/models/subject/level_content.dart';
import 'package:le_petit_davinci/features/levels/models/activities/count_by_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/follow_pattern_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/memory_card_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/solve_equation_activity.dart';
import 'package:le_petit_davinci/features/levels/models/activities/story_problem_activity.dart';
import 'package:le_petit_davinci/features/levels/models/draggable_item_model.dart';
import 'package:le_petit_davinci/features/levels/models/memory_card_models.dart';

final Map<int, LevelContent> unifiedMathLevels = {
  // ========== Group 1: Numbers 1-10 ==========
  // 1: LessonSet(
  //   Lesson(
  //     lessonId: 'math_numbers_1_10',
  //     title: 'Les nombres de 1 à 10',
  //     introduction: 'Apprenons à reconnaître et compter les nombres de 1 à 10!',
  //     activities: [
  //       VideoActivity(videoId: 'EXAMPLE_VIDEO_ID'),
  //       DrawingActivity(
  //         prompt: 'Dessine le chiffre 1!',
  //         templateImagePath: ImageAssets.drawableA,
  //         //TODO: change it to a number drawable
  //       ),
  //       DrawingActivity(
  //         prompt: 'Maintenant dessine le chiffre 2!',
  //         templateImagePath: ImageAssets.drawableA,
  //         //TODO: change it to a number drawable
  //       ),
  //       AudioMatchingActivity(
  //         prompt: 'Associe le nombre à son nom!',
  //         pairs: [
  //           AudioWordPair(audioAssetPath: AudioAssets.number1_fr, word: '1'),
  //           AudioWordPair(audioAssetPath: AudioAssets.number2_fr, word: '2'),
  //           AudioWordPair(audioAssetPath: AudioAssets.number3_fr, word: '3'),
  //         ],
  //       ),
  //     ],
  //   ),
  // ),
  1: LevelSet(
    title: 'Équations simples',
    introduction: 'Apprenons à résoudre des équations simples !',
    activities: [
      SolveEquationActivity(
        equation: '1 + 2 = ?',
        options: [2, 3, 4, 5],
        correctAnswer: 3,
      ),
    ],
  ),

  2: LevelSet(
    title: 'Compter par étapes',
    introduction: 'Apprenons à compter par étapes !',
    activities: [
      CountByActivity(
        instruction: 'Comptez de 1 en 1 jusqu\'à 6',
        initialSequence: [1, 2, 3],
        numberOfInputs: 3,
        correctAnswers: [4, 5, 6],
      ),
      CountByActivity(
        instruction: 'Comptez de 2 en 2 jusqu\'à 12',
        initialSequence: [2, 4, 6],
        numberOfInputs: 3,
        correctAnswers: [8, 10, 12],
      ),
      CountByActivity(
        instruction: 'Comptez de 3 en 3 jusqu\'à 15',
        initialSequence: [3, 6, 9],
        numberOfInputs: 3,
        correctAnswers: [12, 15, 18],
      ),
      CountByActivity(
        instruction: 'Comptez de 4 en 4 jusqu\'à 24',
        initialSequence: [4, 8, 12],
        numberOfInputs: 3,
        correctAnswers: [16, 20, 24],
      ),
    ],
  ),
  3: LevelSet(
    title: 'Suivre les motifs',
    introduction: 'Apprenons à suivre les motifs mathématiques !',
    activities: [
      FollowPatternActivity(
        instruction: 'Follow the pattern to find the answer!',
        examples: ['3 + 1 = 4', '4 + 1 = 5'],
        question: '5 + 1 = ?',
        options: [6, 7],
        correctAnswerIndex: 0,
      ),
      FollowPatternActivity(
        instruction: 'What comes next?',
        examples: ['10 - 2 = 8', '8 - 2 = 6'],
        question: '6 - 2 = ?',
        options: [5, 4],
        correctAnswerIndex: 1,
      ),
    ],
  ),
  4: LevelSet(
    title: 'Problèmes de mots',
    introduction: 'Résolvons des problèmes de mots ensemble !',
    activities: [
      StoryProblemActivity(
        instruction:
            'I offered to buy protein bars for 5 friends. Each bar costs \$3. How much will that cost me?',
        correctTotalValue: 15,
        unitName: 'dollars',
        draggableOptions: [
          // Use a generic money paper asset, the widget will handle the value text
          DraggableItem(
            id: '5',
            label: '5',
            value: 5,
            imageAsset: ImageAssets.moneyPaper,
          ),
          DraggableItem(
            id: '10',
            label: '10',
            value: 10,
            imageAsset: ImageAssets.moneyPaper,
          ),
        ],
      ),
      StoryProblemActivity(
        instruction:
            'I have 3 apples. If I buy 2 more, how many apples do I have now?',
        correctTotalValue: 5,
        unitName: 'apples',
        draggableOptions: [
          // Each draggable apple represents a value of 1
          DraggableItem(
            id: '1',
            label: 'Apple',
            value: 1,
            imageAsset: ImageAssets.apple,
          ),
        ],
      ),
    ],
  ),
  // ========== Memory Game for Numbers ==========
  6: LevelSet(
    title: 'Jeu de mémoire - Nombres 1-5',
    introduction: 'Jouons à un jeu de mémoire avec les nombres et quantités !',
    lessonId: 'math_numbers_memory',
    activities: [
      MemoryCardActivity(
        instruction: 'Match the numbers with their quantities!',
        cardPairs: [
          CardPair(
            pairId: 'one_1',
            card1: MemoryCard(
              id: 'number_1',
              frontImage: ImageAssets.apple, // Placeholder for card back
              backContent: '1',
              type: CardType.text,
              label: 'Number 1',
            ),
            card2: MemoryCard(
              id: 'quantity_1',
              frontImage: ImageAssets.apple, // Placeholder for card back
              backContent: ImageAssets.apple, // Single apple represents 1
              type: CardType.image,
              label: 'One Apple',
            ),
            pairDescription: '1 = One',
          ),
          CardPair(
            pairId: 'two_2',
            card1: MemoryCard(
              id: 'number_2',
              frontImage: ImageAssets.apple, // Placeholder for card back
              backContent: '2',
              type: CardType.text,
              label: 'Number 2',
            ),
            card2: MemoryCard(
              id: 'quantity_2',
              frontImage: ImageAssets.apple, // Placeholder for card back
              backContent:
                  ImageAssets.cat, // Using cat as placeholder for 2 items
              type: CardType.image,
              label: 'Two Items',
            ),
            pairDescription: '2 = Two',
          ),
          CardPair(
            pairId: 'three_3',
            card1: MemoryCard(
              id: 'number_3',
              frontImage: ImageAssets.apple, // Placeholder for card back
              backContent: '3',
              type: CardType.text,
              label: 'Number 3',
            ),
            card2: MemoryCard(
              id: 'quantity_3',
              frontImage: ImageAssets.apple, // Placeholder for card back
              backContent:
                  ImageAssets.dog, // Using dog as placeholder for 3 items
              type: CardType.image,
              label: 'Three Items',
            ),
            pairDescription: '3 = Three',
          ),
          CardPair(
            pairId: 'four_4',
            card1: MemoryCard(
              id: 'number_4',
              frontImage: ImageAssets.apple, // Placeholder for card back
              backContent: '4',
              type: CardType.text,
              label: 'Number 4',
            ),
            card2: MemoryCard(
              id: 'quantity_4',
              frontImage: ImageAssets.apple, // Placeholder for card back
              backContent:
                  ImageAssets.bird, // Using bird as placeholder for 4 items
              type: CardType.image,
              label: 'Four Items',
            ),
            pairDescription: '4 = Four',
          ),
          CardPair(
            pairId: 'five_5',
            card1: MemoryCard(
              id: 'number_5',
              frontImage: ImageAssets.apple, // Placeholder for card back
              backContent: '5',
              type: CardType.text,
              label: 'Number 5',
            ),
            card2: MemoryCard(
              id: 'quantity_5',
              frontImage: ImageAssets.apple, // Placeholder for card back
              backContent:
                  ImageAssets.fish, // Using fish as placeholder for 5 items
              type: CardType.image,
              label: 'Five Items',
            ),
            pairDescription: '5 = Five',
          ),
        ],
        difficulty: MemoryDifficulty.hard,
      ),
    ],
  ),
};
