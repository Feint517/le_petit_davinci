import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/features/exercises/models/arrange_number_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/math_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/number_matching_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/shape_pattern_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/solve_equation_exercise_model.dart';
import 'package:le_petit_davinci/features/lessons/models/activity_model.dart';

/// A base class to represent the content of any given math level.
abstract class MathLevelContent {}

/// A wrapper for math levels that are structured as a full lesson.
class MathLessonSet extends MathLevelContent {
  MathLessonSet(this.lesson);
  
  final Lesson lesson;
}

/// A wrapper for math levels that consist of a list of exercises.
class MathExerciseSet extends MathLevelContent {
  MathExerciseSet(this.exercises);

  final List<MathExercise> exercises;
}

final Map<int, MathLevelContent> mathLevels = {
  // ========== Group 1: Numbers 1-10 ==========
  1: MathLessonSet(
    Lesson(
      lessonId: 'math_numbers_1_10',
      title: 'Les nombres de 1 à 10',
      introduction: 'Apprenons à reconnaître et compter les nombres de 1 à 10!',
      activities: [
        VideoActivity(videoId: 'EXAMPLE_VIDEO_ID'),
        DrawingActivity(
          prompt: 'Dessine le chiffre 1!',
          templateImagePath: ImageAssets.drawableA,
          //TODO: change it to a number drawable
        ),
        DrawingActivity(
          prompt: 'Maintenant dessine le chiffre 2!',
          templateImagePath: ImageAssets.drawableA,
          //TODO: change it to a number drawable
        ),
        AudioMatchingActivity(
          prompt: 'Associe le nombre à son nom!',
          pairs: [
            AudioWordPair(
              audioAssetPath: AudioAssets.number1_fr,
              word: '1',
            ),
            AudioWordPair(
              audioAssetPath: AudioAssets.number2_fr,
              word: '2',
            ),
            AudioWordPair(
              audioAssetPath: AudioAssets.number3_fr,
              word: '3',
            ),
          ],
        ),
      ],
    ),
  ),
  
  2: MathExerciseSet([
    MathExercise.numberMatching(
      NumberMatchingExercise(
        instruction: 'Associe le nombre avec la bonne quantité d\'objets',
        items: [
          NumberMatchingItem(
            number: '1',
            imageAsset: ImageAssets.apple,
            quantity: 1,
          ),
          NumberMatchingItem(
            number: '2',
            imageAsset: ImageAssets.banana,
            quantity: 2,
          ),
          NumberMatchingItem(
            number: '3',
            imageAsset: ImageAssets.orange,
            quantity: 3,
          ),
        ],
      ),
    ),
    MathExercise.solveEquation(
      SolveEquationExercise(
        equation: '1 + ? = 3',
        missingNumber: 2,
        options: [1, 2, 3, 4],
        type: EquationType.addition,
      ),
    ),
  ]),

  // ========== Group 2: Addition ==========
  3: MathLessonSet(
    Lesson(
      lessonId: 'math_addition',
      title: 'Addition Simple',
      introduction: 'Apprenons à additionner des nombres!',
      activities: [
        VideoActivity(videoId: 'EXAMPLE_ADDITION_VIDEO_ID'),
        // Add more activities for addition learning
      ],
    ),
  ),

  4: MathExerciseSet([
    MathExercise.solveEquation(
      SolveEquationExercise(
        equation: '2 + 3 = ?',
        missingNumber: 5,
        options: [4, 5, 6, 7],
        type: EquationType.addition,
      ),
    ),
    MathExercise.arrangeNumbers(
      ArrangeNumbersExercise(
        numbers: [6, 3, 1, 9, 2],
        isAscending: true,
        instruction: 'Range les nombres du plus petit au plus grand',
      ),
    ),
  ]),

  // ========== Group 3: Shapes ==========
  5: MathLessonSet(
    Lesson(
      lessonId: 'math_shapes',
      title: 'Les Formes Géométriques',
      introduction: 'Découvrons les formes de base!',
      activities: [
        VideoActivity(videoId: 'EXAMPLE_SHAPES_VIDEO_ID'),
        // Add shape-related activities
      ],
    ),
  ),

  6: MathExerciseSet([
    MathExercise.shapePattern(
      ShapePatternExercise(
        patternImages: [
          ImageAssets.circle,
          ImageAssets.square,
          ImageAssets.circle,
          ImageAssets.square,
        ],
        optionImages: [
          ImageAssets.circle,
          ImageAssets.triangle,
          ImageAssets.rectangle,
        ],
        correctIndex: 0,
        instruction: 'Quelle forme vient ensuite dans le motif?',
        patternType: PatternType.shapes,
      ),
    ),
  ]),
};