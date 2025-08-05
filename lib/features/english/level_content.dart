import 'package:le_petit_davinci/features/exercises/models/unified_exercise_model.dart';
import 'package:le_petit_davinci/features/lessons3/models/activity_model.dart';

/// A base class to represent the content of any given level.
abstract class LevelContent {}

/// A wrapper for levels that consist of a list of exercises.
class ExerciseSet extends LevelContent {
  final List<UnifiedExercise> exercises;
  ExerciseSet(this.exercises);
}

/// A wrapper for levels that are structured as a full lesson.
class LessonSet extends LevelContent {
  final Lesson lesson;
  LessonSet(this.lesson);
}