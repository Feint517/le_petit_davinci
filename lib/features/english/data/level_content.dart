import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/fill_the_blank_option_model.dart';
import 'package:le_petit_davinci/features/exercises/models/listen_and_choose_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/reorder_words_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
import 'package:le_petit_davinci/features/lessons3/data/lessons_data3.dart';
import 'package:le_petit_davinci/features/lessons3/models/activity_model.dart';

/// A base class to represent the content of any given level.
abstract class LevelContent {}

/// A wrapper for levels that consist of a list of exercises.
class ExerciseSet extends LevelContent {
  ExerciseSet(this.exercises);

  final List<Exercise> exercises;
}

final Map<int, LevelContent> unifiedEnglishLevels = {
  1: LessonSet(exampleLesson),
  2: ExerciseSet([
    Exercise.fillTheBlank(
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
    Exercise.listenAndChoose(
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
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['cat', 'a', 'is', 'banana', 'blue'],
        correctOrder: [2, 1, 0],
      ),
    ),
  ]),
  3: ExerciseSet([
    Exercise.fillTheBlank(
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
    Exercise.listenAndChoose(
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
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['dog', 'the', 'barks', 'quickly', 'table'],
        correctOrder: [1, 0, 2],
      ),
    ),
  ]),
  4: ExerciseSet([
    Exercise.fillTheBlank(
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
    Exercise.listenAndChoose(
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
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['milk', 'likes', 'cat', 'the', 'banana', 'blue'],
        correctOrder: [3, 2, 1, 0],
      ),
    ),
  ]),
  5: ExerciseSet([
    Exercise.fillTheBlank(
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
    Exercise.listenAndChoose(
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
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['swims', 'the', 'in', 'water', 'fish', 'quickly', 'table'],
        correctOrder: [1, 4, 0, 2, 3],
      ),
    ),
  ]),
  6: ExerciseSet([
    Exercise.fillTheBlank(
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
    Exercise.listenAndChoose(
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
    Exercise.reorderWords(
      ReorderWordsExercise(
        words: ['the', 'tiger', 'has', 'stripes', 'banana', 'blue'],
        correctOrder: [0, 1, 2, 3],
      ),
    ),
  ]),
};

/// A wrapper for levels that are structured as a full lesson.
class LessonSet extends LevelContent {
  LessonSet(this.lesson);

  final Lesson lesson;
}
