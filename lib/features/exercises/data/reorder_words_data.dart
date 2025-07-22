import 'package:le_petit_davinci/features/exercises/controllers/reorder_words_controller.dart';

final reorderWordsEnglishLevels = {
  1: [
    ReorderWordsExercise(words: ['cat', 'a', 'is'], correctOrder: [2, 1, 0]),
    ReorderWordsExercise(
      words: ['dog', 'the', 'barks'],
      correctOrder: [1, 0, 2],
    ),
    ReorderWordsExercise(
      words: ['fish', 'swims', 'the'],
      correctOrder: [2, 0, 1],
    ),
    ReorderWordsExercise(
      words: ['bird', 'flies', 'the'],
      correctOrder: [2, 0, 1],
    ),
    ReorderWordsExercise(
      words: ['lion', 'roars', 'the'],
      correctOrder: [2, 0, 1],
    ),
  ],
  3: [
    ReorderWordsExercise(
      words: ['milk', 'likes', 'cat', 'the'],
      correctOrder: [3, 2, 1, 0],
    ),
    ReorderWordsExercise(
      words: ['swims', 'the', 'in', 'water', 'fish'],
      correctOrder: [1, 4, 0, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['the', 'barks', 'dog', 'loudly'],
      correctOrder: [0, 2, 1, 3],
    ),
    ReorderWordsExercise(
      words: ['the', 'flies', 'bird', 'high'],
      correctOrder: [0, 2, 1, 3],
    ),
    ReorderWordsExercise(
      words: ['the', 'lion', 'is', 'strong'],
      correctOrder: [0, 1, 2, 3],
    ),
  ],
  5: [
    ReorderWordsExercise(
      words: ['the', 'tiger', 'has', 'stripes'],
      correctOrder: [0, 1, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['the', 'elephant', 'is', 'big'],
      correctOrder: [0, 1, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['the', 'cow', 'gives', 'milk'],
      correctOrder: [0, 1, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['the', 'bear', 'likes', 'honey'],
      correctOrder: [0, 1, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['the', 'horse', 'runs', 'fast'],
      correctOrder: [0, 1, 2, 3],
    ),
  ],
};

final reorderWordsFrenchLevels = {
  2: [
    ReorderWordsExercise(words: ['chat', 'le', 'est'], correctOrder: [1, 0, 2]),
    ReorderWordsExercise(
      words: ['chien', 'le', 'aboie'],
      correctOrder: [1, 0, 2],
    ),
    ReorderWordsExercise(
      words: ['poisson', 'nage', 'le'],
      correctOrder: [2, 0, 1],
    ),
    ReorderWordsExercise(
      words: ['oiseau', 'vole', 'l'],
      correctOrder: [2, 0, 1],
    ),
    ReorderWordsExercise(
      words: ['lion', 'rugir', 'le'],
      correctOrder: [2, 0, 1],
    ),
    ReorderWordsExercise(
      words: ['ours', 'le', 'est', 'fort'],
      correctOrder: [1, 0, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['cheval', 'court', 'vite', 'le'],
      correctOrder: [3, 0, 1, 2],
    ),
    ReorderWordsExercise(
      words: ['vache', 'la', 'donne', 'du lait'],
      correctOrder: [1, 0, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['tigre', 'le', 'a', 'des rayures'],
      correctOrder: [1, 0, 2, 3],
    ),
  ],
  3: [
    ReorderWordsExercise(
      words: ['lait', 'aime', 'chat', 'le'],
      correctOrder: [3, 2, 1, 0],
    ),
    ReorderWordsExercise(
      words: ['nage', 'le', 'dans', 'eau', 'poisson'],
      correctOrder: [1, 4, 0, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['le', 'aboie', 'chien', 'fort'],
      correctOrder: [0, 2, 1, 3],
    ),
    ReorderWordsExercise(
      words: ['le', 'vole', 'oiseau', 'haut'],
      correctOrder: [0, 2, 1, 3],
    ),
    ReorderWordsExercise(
      words: ['le', 'lion', 'est', 'fort'],
      correctOrder: [0, 1, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['ours', 'le', 'mange', 'du miel'],
      correctOrder: [1, 0, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['chat', 'le', 'dort', 'sur', 'le canapé'],
      correctOrder: [1, 0, 2, 3, 4],
    ),
    ReorderWordsExercise(
      words: ['chien', 'le', 'court', 'dans', 'le jardin'],
      correctOrder: [1, 0, 2, 3, 4],
    ),
    ReorderWordsExercise(
      words: ['oiseau', 'le', 'chante', 'le matin'],
      correctOrder: [1, 0, 2, 3],
    ),
  ],
  6: [
    ReorderWordsExercise(
      words: ['le', 'tigre', 'a', 'des rayures'],
      correctOrder: [0, 1, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['l', 'éléphant', 'est', 'grand'],
      correctOrder: [0, 1, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['la', 'vache', 'donne', 'du lait'],
      correctOrder: [0, 1, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['l', 'ours', 'aime', 'le miel'],
      correctOrder: [0, 1, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['le', 'cheval', 'court', 'vite'],
      correctOrder: [0, 1, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['le', 'lion', 'vit', 'dans', 'la savane'],
      correctOrder: [0, 1, 2, 3, 4],
    ),
    ReorderWordsExercise(
      words: ['le', 'chat', 'aime', 'le poisson'],
      correctOrder: [0, 1, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['le', 'chien', 'garde', 'la maison'],
      correctOrder: [0, 1, 2, 3],
    ),
    ReorderWordsExercise(
      words: ['le', 'lapin', 'mange', 'des carottes'],
      correctOrder: [0, 1, 2, 3],
    ),
  ],
};
