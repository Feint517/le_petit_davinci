import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/data/models/subject/level_content.dart';
import 'package:le_petit_davinci/features/exercises/models/count_by_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/crowssword_equation_model.dart';
import 'package:le_petit_davinci/features/exercises/models/draggable_item_model.dart';
import 'package:le_petit_davinci/features/exercises/models/follow_pattern_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/math_crossword_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/solve_equation_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/story_problem_exercise.dart';
import 'package:le_petit_davinci/features/lessons/models/activity_model.dart';
import 'package:le_petit_davinci/features/lessons/models/audio_matching_activity_model.dart';
import 'package:le_petit_davinci/features/lessons/models/audio_pair_model.dart';
import 'package:le_petit_davinci/features/lessons/models/drawing_activity_model.dart';
import 'package:le_petit_davinci/features/lessons/models/video_activity_model.dart';

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
  1: ExerciseSet([
    SolveEquationExercise(
      equation: '1 + 2 = ?',
      options: [2, 3, 4, 5],
      correctAnswer: 3,
    ),
  ]),

  2: ExerciseSet([
    CountByExercise(
      instruction: 'Comptez de 1 en 1 jusqu\'à 6',
      initialSequence: [1, 2, 3],
      numberOfInputs: 3,
      correctAnswers: [4, 5, 6],
    ),
    CountByExercise(
      instruction: 'Comptez de 2 en 2 jusqu\'à 12',
      initialSequence: [2, 4, 6],
      numberOfInputs: 3,
      correctAnswers: [8, 10, 12],
    ),
    CountByExercise(
      instruction: 'Comptez de 3 en 3 jusqu\'à 15',
      initialSequence: [3, 6, 9],
      numberOfInputs: 3,
      correctAnswers: [12, 15, 18],
    ),
    CountByExercise(
      instruction: 'Comptez de 4 en 4 jusqu\'à 24',
      initialSequence: [4, 8, 12],
      numberOfInputs: 3,
      correctAnswers: [16, 20, 24],
    ),
  ]),
  3: ExerciseSet([
    FollowPatternExercise(
      instruction: 'Follow the pattern to find the answer!',
      examples: ['3 + 1 = 4', '4 + 1 = 5'],
      question: '5 + 1 = ?',
      options: [6, 7],
      correctAnswerIndex: 0,
    ),
    FollowPatternExercise(
      instruction: 'What comes next?',
      examples: ['10 - 2 = 8', '8 - 2 = 6'],
      question: '6 - 2 = ?',
      options: [5, 4],
      correctAnswerIndex: 1,
    ),
  ]),
  4: ExerciseSet([
    StoryProblemExercise(
      instruction:
          'I offered to buy protein bars for 5 friends. Each bar costs \$3. How much will that cost me?',
      correctTotalValue: 15,
      unitName: 'dollars',
      draggableOptions: [
        // Use a generic money paper asset, the widget will handle the value text
        DraggableItem(id: '5', value: 5, assetPath: ImageAssets.moneyPaper),
        DraggableItem(id: '10', value: 10, assetPath: ImageAssets.moneyPaper),
      ],
    ),
    StoryProblemExercise(
      instruction:
          'I have 3 apples. If I buy 2 more, how many apples do I have now?',
      correctTotalValue: 5,
      unitName: 'apples',
      draggableOptions: [
        // Each draggable apple represents a value of 1
        DraggableItem(id: '1', value: 1, assetPath: ImageAssets.apple),
      ],
    ),
  ]),
  5: ExerciseSet([
    MathEquationCrosswordExercise(
      instruction: 'Solve the math crossword puzzle!',
      gridSize: 5,
      equations: [
        // Horizontal equations
        CrosswordEquation(
          equation: "2+?=5",
          answer: 3,
          isHorizontal: true,
          row: 1,
          column: 0,
        ),
        CrosswordEquation(
          equation: "?-2=4",
          answer: 6,
          isHorizontal: true,
          row: 3,
          column: 1,
        ),
        // Vertical equations
        CrosswordEquation(
          equation: "4×?=8",
          answer: 2,
          isHorizontal: false,
          row: 0,
          column: 2,
        ),
        CrosswordEquation(
          equation: "9÷?=3",
          answer: 3,
          isHorizontal: false,
          row: 2,
          column: 4,
        ),
      ],
    ),
  ]),
};
