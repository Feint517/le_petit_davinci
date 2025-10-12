import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/data/models/subject/level_content.dart';
import 'package:le_petit_davinci/features/levels/models/activities/activities.dart';
import 'package:le_petit_davinci/features/levels/models/audio_pair_model.dart';
import 'package:le_petit_davinci/features/levels/models/fill_the_blank_option_model.dart';
import 'package:le_petit_davinci/features/levels/models/memory_card_models.dart';
import 'package:le_petit_davinci/features/levels/models/draggable_item_model.dart';
import 'package:le_petit_davinci/features/levels/models/story_element_model.dart';

final Map<int, LevelContent> unifiedEnglishLevels = {
  // ========== Group 1: A, B, C, D ==========
  1: LevelSet(
    title: 'Alphabet - A, B, C, D',
    introduction: 'Let\'s learn the letters A, B, C, and D!',
    activities: [
      // Video introduction
      VideoActivity(videoId: 'ccEpTTZW34g'),

      // Letter tracing activities (auto-complete)
      LetterTracingActivity(
        letter: 'A',
        prompt: 'Let\'s learn to trace the letter "A"!',
      ),
      LetterTracingActivity(
        letter: 'B',
        prompt: 'Great! Now let\'s trace the letter "B"!',
      ),
      LetterTracingActivity(letter: 'C', prompt: 'Awesome! Here comes "C"!'),
      LetterTracingActivity(
        letter: 'D',
        prompt: 'You\'re doing great! Let\'s trace "D"!',
      ),

      // Audio matching (auto-complete)
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

  2: LevelSet(
    title: 'Memory Game - A, B, C, D',
    introduction: 'Let\'s play a memory game with the letters A, B, C, and D!',
    activities: [
      // Memory card game (auto-complete)
      MemoryCardActivity(
        instruction: 'Find the matching pairs of letters and words!',
        cardPairs: [
          CardPair(
            pairId: 'a_apple',
            card1: MemoryCard(
              id: 'a_letter',
              frontImage: ImageAssets.apple,
              backContent: 'A',
              type: CardType.text,
              label: 'Letter A',
            ),
            card2: MemoryCard(
              id: 'a_word',
              frontImage: ImageAssets.apple,
              backContent: ImageAssets.apple,
              type: CardType.image,
              label: 'Apple',
            ),
            pairDescription: 'A is for Apple',
          ),
          CardPair(
            pairId: 'b_ball',
            card1: MemoryCard(
              id: 'b_letter',
              frontImage: ImageAssets.apple,
              backContent: 'B',
              type: CardType.text,
              label: 'Letter B',
            ),
            card2: MemoryCard(
              id: 'b_word',
              frontImage: ImageAssets.apple,
              backContent: ImageAssets.cat, // Using cat as placeholder for ball
              type: CardType.image,
              label: 'Ball',
            ),
            pairDescription: 'B is for Ball',
          ),
          CardPair(
            pairId: 'c_cat',
            card1: MemoryCard(
              id: 'c_letter',
              frontImage: ImageAssets.apple,
              backContent: 'C',
              type: CardType.text,
              label: 'Letter C',
            ),
            card2: MemoryCard(
              id: 'c_word',
              frontImage: ImageAssets.apple,
              backContent: ImageAssets.cat,
              type: CardType.image,
              label: 'Cat',
            ),
            pairDescription: 'C is for Cat',
          ),
          CardPair(
            pairId: 'd_dog',
            card1: MemoryCard(
              id: 'd_letter',
              frontImage: ImageAssets.apple,
              backContent: 'D',
              type: CardType.text,
              label: 'Letter D',
            ),
            card2: MemoryCard(
              id: 'd_word',
              frontImage: ImageAssets.apple,
              backContent: ImageAssets.dog,
              type: CardType.image,
              label: 'Dog',
            ),
            pairDescription: 'D is for Dog',
          ),
        ],
        difficulty: MemoryDifficulty.medium,
      ),
    ],
  ),

  3: LevelSet(
    title: 'Practice - A, B, C, D',
    introduction: 'Let\'s practice what we learned about A, B, C, and D!',
    activities: [
      // Word reordering exercise (requires validation)
      ReorderWordsActivity(
        words: ['is', 'a', 'This', 'cat'],
        correctOrder: [2, 0, 1, 3],
      ),

      // Fill in the blank exercise (requires validation)
      FillTheBlankActivity(
        questionSuffix: ' is for Dog.',
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
    introduction: 'Time to learn E, F, G, and H!',
    activities: [
      // Letter tracing activities (auto-complete)
      LetterTracingActivity(letter: 'E', prompt: 'Let\'s start with "E"!'),
      LetterTracingActivity(letter: 'F', prompt: 'Next up is "F"!'),
      LetterTracingActivity(letter: 'G', prompt: 'Now for "G"!'),
      LetterTracingActivity(letter: 'H', prompt: 'And finally, "H"!'),

      // Audio matching (auto-complete)
      AudioMatchingActivity(
        prompt: 'Match the sound to the letter!',
        pairs: [
          AudioWordPair(audioAssetPath: AudioAssets.e_en, word: 'E'),
          AudioWordPair(audioAssetPath: AudioAssets.f_en, word: 'F'),
          AudioWordPair(audioAssetPath: AudioAssets.g_en, word: 'G'),
          AudioWordPair(audioAssetPath: AudioAssets.h_en, word: 'H'),
        ],
      ),
    ],
  ),

  5: LevelSet(
    title: 'Practice - E, F, G, H',
    introduction: 'Let\'s practice with E, F, G, and H!',
    activities: [
      // Fill in the blank exercise (requires validation)
      FillTheBlankActivity(
        questionSuffix: ' is for Elephant.',
        options: [
          FillTheBlankOption(optionText: 'E'),
          FillTheBlankOption(optionText: 'F'),
          FillTheBlankOption(optionText: 'G'),
        ],
        correctAnswer: 0,
      ),

      // Listen and choose exercise (requires validation)
      ListenAndChooseActivity(
        imageAssets: [
          ImageAssets.elephant,
          ImageAssets.fish,
          ImageAssets.lion,
          ImageAssets.bear,
        ],
        correctAnswer: 0,
        label: 'Elephant',
      ),
    ],
  ),

  6: LevelSet(
    title: 'More Practice - E, F, G, H',
    introduction: 'More practice with E, F, G, and H!',
    activities: [
      // Word reordering exercise (requires validation)
      ReorderWordsActivity(
        words: ['is', 'a', 'This', 'fish'],
        correctOrder: [2, 0, 1, 3],
      ),

      // Fill in the blank exercise (requires validation)
      FillTheBlankActivity(
        questionSuffix: ' is for Hat.',
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
    introduction: 'Let\'s learn I, J, K, and L!',
    activities: [
      // Letter tracing activities (auto-complete)
      LetterTracingActivity(letter: 'I', prompt: 'Let\'s trace "I"!'),
      LetterTracingActivity(letter: 'J', prompt: 'Next is "J"!'),
      LetterTracingActivity(letter: 'K', prompt: 'Here comes "K"!'),
      LetterTracingActivity(letter: 'L', prompt: 'And now "L"!'),

      // Audio matching (auto-complete)
      AudioMatchingActivity(
        prompt: 'Match the sound to the letter!',
        pairs: [
          AudioWordPair(audioAssetPath: AudioAssets.i_en, word: 'I'),
          AudioWordPair(audioAssetPath: AudioAssets.j_en, word: 'J'),
          AudioWordPair(audioAssetPath: AudioAssets.k_en, word: 'K'),
          AudioWordPair(audioAssetPath: AudioAssets.l_en, word: 'L'),
        ],
      ),
    ],
  ),

  8: LevelSet(
    title: 'Practice - I, J, K, L',
    introduction: 'Let\'s practice with I, J, K, and L!',
    activities: [
      // Fill in the blank exercise (requires validation)
      FillTheBlankActivity(
        questionSuffix: ' is for Igloo.',
        options: [
          FillTheBlankOption(optionText: 'I'),
          FillTheBlankOption(optionText: 'J'),
          FillTheBlankOption(optionText: 'K'),
        ],
        correctAnswer: 0,
      ),

      // Listen and choose exercise (requires validation)
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
    title: 'More Practice - I, J, K, L',
    introduction: 'More practice with I, J, K, and L!',
    activities: [
      // Word reordering exercise (requires validation)
      ReorderWordsActivity(
        words: ['a', 'is', 'This', 'kite'],
        correctOrder: [2, 1, 0, 3],
      ),

      // Fill in the blank exercise (requires validation)
      FillTheBlankActivity(
        questionSuffix: ' is for Jam.',
        options: [
          FillTheBlankOption(optionText: 'J'),
          FillTheBlankOption(optionText: 'K'),
          FillTheBlankOption(optionText: 'L'),
        ],
        correctAnswer: 0,
      ),
    ],
  ),

  // ========== Story Level Example ==========
  10: LevelSet(
    title: 'A Trip to the Supermarket',
    introduction: 'Join Leo and his mom on a shopping adventure!',
    activities: [
      // Story activity with mixed content
      StoryActivity(
        title: 'A Trip to the Supermarket',
        elements: [
          DialogueLine(
            characterName: 'Mom',
            avatarAsset: SvgAssets.bear,
            text: 'Leo, we need to buy some fruit.',
          ),
          DialogueLine(
            characterName: 'Leo',
            avatarAsset: SvgAssets.bearMasscot,
            text: 'Okay, Mom! I see a red fruit.',
          ),
          // Interactive question
          StoryQuestion(
            activity: FillTheBlankActivity(
              questionSuffix: ' is red.',
              options: [
                FillTheBlankOption(optionText: 'The apple'),
                FillTheBlankOption(optionText: 'The banana'),
              ],
              correctAnswer: 0,
            ),
          ),
          DialogueLine(
            characterName: 'Mom',
            avatarAsset: SvgAssets.bear,
            text: "That's right! Now, can you find a long, yellow fruit?",
          ),
          // Another interactive question
          StoryQuestion(
            activity: ListenAndChooseActivity(
              imageAssets: [
                ImageAssets.apple,
                ImageAssets.banana,
                ImageAssets.orange,
              ],
              correctAnswer: 1,
              label: 'Banana',
            ),
          ),
          DialogueLine(
            characterName: 'Mom',
            avatarAsset: SvgAssets.bear,
            text: 'Perfect! You found the banana. Great job!',
          ),
        ],
      ),
    ],
  ),

  // ========== Mixed Level Example ==========
  11: LevelSet(
    title: 'Mixed Learning Adventure',
    introduction: 'A fun mix of learning activities!',
    activities: [
      // Video introduction (auto-complete)
      VideoActivity(videoId: 'CA6Mofzh7jo'),

      // Letter tracing activity (auto-complete)
      LetterTracingActivity(letter: 'A', prompt: 'Let\'s trace something fun!'),

      // Fill in the blank exercise (requires validation)
      FillTheBlankActivity(
        questionSuffix: ' is for Apple.',
        options: [
          FillTheBlankOption(optionText: 'A'),
          FillTheBlankOption(optionText: 'B'),
          FillTheBlankOption(optionText: 'C'),
        ],
        correctAnswer: 0,
      ),

      // Listen and choose exercise (requires validation)
      ListenAndChooseActivity(
        imageAssets: [
          ImageAssets.apple,
          ImageAssets.banana,
          ImageAssets.cat,
          ImageAssets.dog,
        ],
        correctAnswer: 0,
        label: 'Apple',
      ),

      // Word reordering exercise (requires validation)
      ReorderWordsActivity(
        words: ['is', 'a', 'This', 'cat'],
        correctOrder: [2, 0, 1, 3],
      ),
    ],
  ),

  // ========== Animals: Farm ==========
  22: LevelSet(
    title: 'Fun on the Farm!',
    introduction: 'Let\'s learn about some animals that live on a farm.',
    activities: [
      // Video introduction (auto-complete)
      VideoActivity(videoId: 'CA6Mofzh7jo'),

      // Audio matching (auto-complete)
      AudioMatchingActivity(
        prompt: 'Match the animal to its sound!',
        pairs: [
          AudioWordPair(audioAssetPath: AudioAssets.a_en, word: 'Cow'),
          AudioWordPair(audioAssetPath: AudioAssets.b_en, word: 'Sheep'),
          AudioWordPair(audioAssetPath: AudioAssets.c_en, word: 'Pig'),
          AudioWordPair(audioAssetPath: AudioAssets.d_en, word: 'Chicken'),
        ],
      ),
    ],
  ),

  23: LevelSet(
    title: 'Farm Animal Practice',
    introduction: 'Let\'s practice with farm animals!',
    activities: [
      // Fill in the blank exercise (requires validation)
      FillTheBlankActivity(
        questionSuffix: " says 'moo'.",
        options: [
          FillTheBlankOption(optionText: 'A Cow'),
          FillTheBlankOption(optionText: 'A Sheep'),
          FillTheBlankOption(optionText: 'A Pig'),
        ],
        correctAnswer: 0,
      ),

      // Listen and choose exercise (requires validation)
      ListenAndChooseActivity(
        imageAssets: [
          ImageAssets.cat,
          ImageAssets.dog,
          ImageAssets.bird,
          ImageAssets.fish,
        ],
        correctAnswer: 1,
        label: 'Cow',
      ),
    ],
  ),

  24: LevelSet(
    title: 'More Farm Animal Practice',
    introduction: 'More practice with farm animals!',
    activities: [
      // Word reordering exercise (requires validation)
      ReorderWordsActivity(
        words: ['The', 'pig', 'likes', 'mud'],
        correctOrder: [0, 1, 2, 3],
      ),

      // Fill in the blank exercise (requires validation)
      FillTheBlankActivity(
        questionSuffix: ' gives us wool.',
        options: [
          FillTheBlankOption(optionText: 'A Chicken'),
          FillTheBlankOption(optionText: 'A Sheep'),
          FillTheBlankOption(optionText: 'A Cow'),
        ],
        correctAnswer: 1,
      ),
    ],
  ),

  // ========== Animals: Wild ==========
  25: LevelSet(
    title: 'A Trip to the Jungle!',
    introduction: 'Let\'s learn about some animals that live in the wild.',
    activities: [
      // Video introduction (auto-complete)
      VideoActivity(videoId: 'T3_v_mmvCC4'),

      // Audio matching (auto-complete)
      AudioMatchingActivity(
        prompt: 'Match the animal to its name!',
        pairs: [
          AudioWordPair(audioAssetPath: AudioAssets.lionName, word: 'Lion'),
          AudioWordPair(audioAssetPath: AudioAssets.tigerName, word: 'Tiger'),
          AudioWordPair(
            audioAssetPath: AudioAssets.elephantName,
            word: 'Elephant',
          ),
          AudioWordPair(audioAssetPath: AudioAssets.monkeyName, word: 'Monkey'),
        ],
      ),
    ],
  ),

  26: LevelSet(
    title: 'Wild Animal Practice',
    introduction: 'Let\'s practice with wild animals!',
    activities: [
      // Fill in the blank exercise (requires validation)
      FillTheBlankActivity(
        questionSuffix: ' is the king of the jungle.',
        options: [
          FillTheBlankOption(optionText: 'A Tiger'),
          FillTheBlankOption(optionText: 'A Lion'),
          FillTheBlankOption(optionText: 'An Elephant'),
        ],
        correctAnswer: 1,
      ),

      // Listen and choose exercise (requires validation)
      ListenAndChooseActivity(
        imageAssets: [
          ImageAssets.tiger,
          ImageAssets.bear,
          ImageAssets.elephant,
          ImageAssets.lion,
        ],
        correctAnswer: 0,
        label: 'Tiger',
      ),
    ],
  ),

  27: LevelSet(
    title: 'More Wild Animal Practice',
    introduction: 'More practice with wild animals!',
    activities: [
      // Word reordering exercise (requires validation)
      ReorderWordsActivity(
        words: ['The', 'monkey', 'eats', 'bananas'],
        correctOrder: [0, 1, 2, 3],
      ),

      // Fill in the blank exercise (requires validation)
      FillTheBlankActivity(
        questionSuffix: ' has a very long trunk.',
        options: [
          FillTheBlankOption(optionText: 'An Elephant'),
          FillTheBlankOption(optionText: 'A Monkey'),
          FillTheBlankOption(optionText: 'A Lion'),
        ],
        correctAnswer: 0,
      ),
    ],
  ),

  // ========== Story Problem Example ==========
  28: LevelSet(
    title: 'Counting Animals',
    introduction: 'Let\'s practice counting with animals!',
    activities: [
      // Story problem activity (requires validation)
      StoryProblemActivity(
        instruction: 'How many animals are in the zoo?',
        draggableOptions: [
          DraggableItem(
            id: 'lion1',
            label: 'Lion',
            value: 1,
            imageAsset: ImageAssets.lion,
          ),
          DraggableItem(
            id: 'lion2',
            label: 'Lion',
            value: 1,
            imageAsset: ImageAssets.lion,
          ),
          DraggableItem(
            id: 'tiger1',
            label: 'Tiger',
            value: 1,
            imageAsset: ImageAssets.tiger,
          ),
          DraggableItem(
            id: 'elephant1',
            label: 'Elephant',
            value: 1,
            imageAsset: ImageAssets.elephant,
          ),
        ],
        correctTotalValue: 4,
        unitName: 'animals',
      ),
    ],
  ),

  // ========== Mixed Review ==========
  29: LevelSet(
    title: 'Mixed Review',
    introduction: 'Let\'s review everything we\'ve learned!',
    activities: [
      // Listen and choose exercise (requires validation)
      ListenAndChooseActivity(
        imageAssets: [
          ImageAssets.dog,
          ImageAssets.lion,
          ImageAssets.cat,
          ImageAssets.bear,
        ],
        correctAnswer: 3,
        label: 'Monkey',
      ),

      // Fill in the blank exercise (requires validation)
      FillTheBlankActivity(
        questionSuffix: ' has black and white stripes.',
        options: [
          FillTheBlankOption(optionText: 'A Tiger'),
          FillTheBlankOption(optionText: 'A Zebra'),
          FillTheBlankOption(optionText: 'A Cow'),
        ],
        correctAnswer: 1,
      ),
    ],
  ),

  30: LevelSet(
    title: 'Final Review',
    introduction: 'Final review of everything we\'ve learned!',
    activities: [
      // Word reordering exercise (requires validation)
      ReorderWordsActivity(
        words: ['The', 'cow', 'lives', 'on', 'the', 'farm'],
        correctOrder: [0, 1, 2, 3, 4, 5],
      ),

      // Listen and choose exercise (requires validation)
      ListenAndChooseActivity(
        imageAssets: [
          ImageAssets.bird,
          ImageAssets.tiger,
          ImageAssets.fish,
          ImageAssets.elephant,
        ],
        correctAnswer: 3,
        label: 'Elephant',
      ),

      // Fill in the blank exercise (requires validation)
      FillTheBlankActivity(
        questionSuffix: ' is a big cat with stripes.',
        options: [
          FillTheBlankOption(optionText: 'A Lion'),
          FillTheBlankOption(optionText: 'A Tiger'),
          FillTheBlankOption(optionText: 'A Cat'),
        ],
        correctAnswer: 1,
      ),

      // Final word reordering exercise (requires validation)
      ReorderWordsActivity(
        words: ['The', 'elephant', 'is', 'a', 'wild', 'animal'],
        correctOrder: [0, 1, 2, 3, 4, 5],
      ),
    ],
  ),
};
