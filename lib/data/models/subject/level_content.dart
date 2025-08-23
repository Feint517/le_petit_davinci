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
