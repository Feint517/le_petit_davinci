import 'package:le_petit_davinci/features/levels/models/activity_model.dart';

/// A base class to represent the content of any given level.
abstract class LevelContent {}

/// A unified level that contains a list of activities.
/// This is the new simplified approach - a level is just a set of activities.
class LevelSet extends LevelContent {
  LevelSet({
    required this.title,
    required this.introduction,
    required this.activities,
    this.lessonId,
  });

  final String title;
  final String introduction;
  final String? lessonId;
  final List<Activity> activities;

  /// Helper getter to check if level contains only lesson activities (auto-complete)
  bool get isLessonOnly =>
      activities.every((activity) => activity.isLessonActivity);

  /// Helper getter to check if level contains only exercises (require validation)
  bool get isExerciseOnly =>
      activities.every((activity) => activity.isExercise);

  /// Helper getter to check if level is mixed (contains both types)
  bool get isMixed => !isLessonOnly && !isExerciseOnly;

  /// Helper getter to get all lesson activities
  List<Activity> get lessonActivities =>
      activities.where((a) => a.isLessonActivity).toList();

  /// Helper getter to get all exercises
  List<Activity> get exercises =>
      activities.where((a) => a.isExercise).toList();
}

// --- Legacy Support (Deprecated) ---

/// @deprecated Use LevelSet instead. All content is now unified as activities.
// class LessonSet extends LevelContent {
//   LessonSet(this.lesson);

//   final Lesson lesson;
// }

// /// @deprecated Use LevelSet instead. All content is now unified as activities.
// class ExerciseSet extends LevelContent {
//   ExerciseSet(this.exercises);

//   final List<Activity> exercises;
// }
