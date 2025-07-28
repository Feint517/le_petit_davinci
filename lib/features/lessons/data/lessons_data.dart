import 'package:le_petit_davinci/features/lessons/models/lesson_model.dart';
import 'package:le_petit_davinci/features/lessons/models/lesson_activity_model.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';

final Map<int, LessonModel> englishLessons = {
  1: LessonModel(
    id: 'en_alphabets_1',
    title: 'Learning Letters A-E',
    description:
        'Introduction to the first five letters of the alphabet with fun activities!',
    language: LessonLanguage.english,
    status: LessonStatus.available,
    videoId: 'ccEpTTZW34g',
    videoTitle: 'ABC Song - Letters A to E',
    activities: [
      DrawLettersActivity(
        id: 'draw_letters_ae',
        title: 'Draw Your Letters',
        instruction: 'Practice drawing the letters you learned:',
        estimatedDurationMinutes: 5,
        letters: [
          LetterDrawingTask(
            letter: 'A',
            pronunciation: 'AY',
            exampleWords: ['Apple', 'Ant', 'Art'],
          ),
          LetterDrawingTask(
            letter: 'B',
            pronunciation: 'BEE',
            exampleWords: ['Ball', 'Bird', 'Book'],
          ),
          LetterDrawingTask(
            letter: 'C',
            pronunciation: 'SEE',
            exampleWords: ['Cat', 'Car', 'Cup'],
          ),
          LetterDrawingTask(
            letter: 'D',
            pronunciation: 'DEE',
            exampleWords: ['Dog', 'Duck', 'Door'],
          ),
          LetterDrawingTask(
            letter: 'E',
            pronunciation: 'EE',
            exampleWords: ['Elephant', 'Egg', 'Eye'],
          ),
        ],
      ),
      ColoringTemplateActivity(
        id: 'color_alphabet',
        title: 'Color the Alphabet',
        instruction: 'Color this beautiful alphabet picture!',
        estimatedDurationMinutes: 7,
        templateImagePath: 'assets/templates/alphabet_coloring.png',
        suggestedColors: ['red', 'blue', 'green', 'yellow', 'orange'],
        coloringPrompt:
            'Use your favorite colors to make this alphabet picture beautiful!',
      ),
    ],
    learningObjectives: [
      'Recognize letters A through E',
      'Understand the sound each letter makes',
      'Practice writing basic letter shapes',
      'Connect letters to common words',
    ],
  ),

  15: LessonModel(
    id: 'en_animals_1',
    title: 'Farm Animals',
    description: 'Learn about farm animals and their sounds!',
    language: LessonLanguage.english,
    status: LessonStatus.available,
    videoId: 'ccEpTTZW34g',
    videoTitle: 'Farm Animals for Kids',
    activities: [
      SelectItemsActivity(
        id: 'select_farm_animals',
        title: 'Find the Farm Animals',
        instruction: 'Select all the farm animals you saw in the video',
        estimatedDurationMinutes: 4,
        items: [
          SelectableItem(
            id: 'cow',
            label: 'Cow',
            imagePath: 'assets/images/animals/cow.png',
          ),
          SelectableItem(
            id: 'pig',
            label: 'Pig',
            imagePath: 'assets/images/animals/pig.png',
          ),
          SelectableItem(
            id: 'sheep',
            label: 'Sheep',
            imagePath: 'assets/images/animals/sheep.png',
          ),
          SelectableItem(
            id: 'lion',
            label: 'Lion',
            imagePath: 'assets/images/animals/lion.png',
          ),
          SelectableItem(
            id: 'chicken',
            label: 'Chicken',
            imagePath: 'assets/images/animals/chicken.png',
          ),
          SelectableItem(
            id: 'horse',
            label: 'Horse',
            imagePath: 'assets/images/animals/horse.png',
          ),
        ],
        correctIndices: [0, 1, 2, 4, 5], // Farm animals (not lion)
        selectionPrompt: 'Tap on the farm animals!',
      ),
      MatchPairsActivity(
        id: 'match_animal_sounds',
        title: 'Match Animal Sounds',
        instruction: 'Match each animal to the sound it makes',
        estimatedDurationMinutes: 5,
        pairs: [
          MatchPair(
            leftId: 'cow_img',
            rightId: 'moo_sound',
            leftContent: 'Cow',
            rightContent: 'Moo',
            leftImagePath: 'assets/images/animals/cow.png',
            rightImagePath: 'assets/sounds/moo.mp3',
          ),
          MatchPair(
            leftId: 'pig_img',
            rightId: 'oink_sound',
            leftContent: 'Pig',
            rightContent: 'Oink',
            leftImagePath: 'assets/images/animals/pig.png',
            rightImagePath: 'assets/sounds/oink.mp3',
          ),
          MatchPair(
            leftId: 'sheep_img',
            rightId: 'baa_sound',
            leftContent: 'Sheep',
            rightContent: 'Baa',
            leftImagePath: 'assets/images/animals/sheep.png',
            rightImagePath: 'assets/sounds/baa.mp3',
          ),
        ],
        matchingPrompt: 'Drag each animal to its sound!',
      ),
    ],
    learningObjectives: [
      'Identify common farm animals',
      'Learn animal sounds and names',
      'Practice vocabulary recognition',
      'Develop matching skills',
    ],
  ),

  22: LessonModel(
    id: 'en_colors_1',
    title: 'Basic Colors',
    description: 'Discover the wonderful world of colors!',
    language: LessonLanguage.english,
    status: LessonStatus.available,
    videoId: 'rXhOBD9lbQk', // Colors song for kids
    videoTitle: 'Colors Song for Children',
    // thumbnailImagePath: null,
    // estimatedTotalMinutes: 10,
    activities: [
      SelectItemsActivity(
        id: 'select_primary_colors',
        title: 'Find Primary Colors',
        instruction: 'Select the primary colors: Red, Blue, and Yellow',
        estimatedDurationMinutes: 3,
        items: [
          SelectableItem(
            id: 'red',
            label: 'Red',
            imagePath: 'assets/images/colors/red.png',
          ),
          SelectableItem(
            id: 'blue',
            label: 'Blue',
            imagePath: 'assets/images/colors/blue.png',
          ),
          SelectableItem(
            id: 'green',
            label: 'Green',
            imagePath: 'assets/images/colors/green.png',
          ),
          SelectableItem(
            id: 'yellow',
            label: 'Yellow',
            imagePath: 'assets/images/colors/yellow.png',
          ),
          SelectableItem(
            id: 'purple',
            label: 'Purple',
            imagePath: 'assets/images/colors/purple.png',
          ),
          SelectableItem(
            id: 'orange',
            label: 'Orange',
            imagePath: 'assets/images/colors/orange.png',
          ),
        ],
        correctIndices: [0, 1, 3], // Red, Blue, Yellow
        selectionPrompt: 'Tap on the primary colors!',
      ),
      ColoringTemplateActivity(
        id: 'color_rainbow',
        title: 'Color the Rainbow',
        instruction:
            'Use the colors you learned to create a beautiful rainbow!',
        estimatedDurationMinutes: 7,
        templateImagePath: 'assets/templates/rainbow_coloring.png',
        suggestedColors: ['red', 'orange', 'yellow', 'green', 'blue', 'purple'],
        coloringPrompt: 'Make a colorful rainbow!',
      ),
    ],
    learningObjectives: [
      'Identify basic colors',
      'Learn primary vs secondary colors',
      'Practice color recognition',
      'Develop creativity with colors',
    ],
  ),
};

final Map<int, LessonModel> frenchLessons = {
  1: LessonModel(
    id: 'fr_alphabets_1',
    title: 'Apprendre les lettres A-E',
    description:
        'Introduction aux cinq premières lettres de l\'alphabet avec des activités amusantes!',
    language: LessonLanguage.french,
    status: LessonStatus.available,
    videoId: 'dQw4w9WgXcQ', // Sample YouTube video ID
    videoTitle: 'Chanson ABC - Lettres A à E',
    // thumbnailImagePath: null,
    // estimatedTotalMinutes: 15,
    activities: [
      SelectItemsActivity(
        id: 'select_letters_ae_fr',
        title: 'Trouve les lettres',
        instruction:
            'Sélectionne toutes les lettres que tu as apprises dans la vidéo: A, B, C, D, E',
        estimatedDurationMinutes: 3,
        items: [
          SelectableItem(
            id: 'letter_a_fr',
            label: 'A',
            imagePath: SvgAssets.letterA,
          ),
          SelectableItem(
            id: 'letter_b_fr',
            label: 'B',
            imagePath: SvgAssets.letterB,
          ),
          SelectableItem(
            id: 'letter_c_fr',
            label: 'C',
            imagePath: SvgAssets.letterC,
          ),
          SelectableItem(
            id: 'wrong_letter_1_fr',
            label: 'X',
            imagePath: 'assets/svg/X.svg',
          ),
          SelectableItem(
            id: 'letter_d_fr',
            label: 'D',
            imagePath: 'assets/svg/D.svg',
          ),
          SelectableItem(
            id: 'letter_e_fr',
            label: 'E',
            imagePath: 'assets/svg/E.svg',
          ),
        ],
        correctIndices: [0, 1, 2, 4, 5], // A, B, C, D, E
        selectionPrompt: 'Touche les lettres A, B, C, D et E!',
      ),
      DrawLettersActivity(
        id: 'draw_letters_ae_fr',
        title: 'Dessine tes lettres',
        instruction:
            'Pratique le dessin des lettres que tu as apprises: A, B, C, D, E',
        estimatedDurationMinutes: 5,
        letters: [
          LetterDrawingTask(
            letter: 'A',
            pronunciation: 'AH',
            exampleWords: ['Arbre', 'Avion', 'Ami'],
          ),
          LetterDrawingTask(
            letter: 'B',
            pronunciation: 'BEH',
            exampleWords: ['Ballon', 'Bateau', 'Banane'],
          ),
          LetterDrawingTask(
            letter: 'C',
            pronunciation: 'SEH',
            exampleWords: ['Chat', 'Chien', 'Cheval'],
          ),
          LetterDrawingTask(
            letter: 'D',
            pronunciation: 'DEH',
            exampleWords: ['Dragon', 'Dauphin', 'Danse'],
          ),
          LetterDrawingTask(
            letter: 'E',
            pronunciation: 'EUH',
            exampleWords: ['Éléphant', 'École', 'Eau'],
          ),
        ],
      ),
    ],
    learningObjectives: [
      'Reconnaître les lettres A à E',
      'Comprendre le son de chaque lettre',
      'Pratiquer l\'écriture des formes de lettres de base',
      'Associer les lettres aux mots courants',
    ],
  ),
};
