import 'package:le_petit_davinci/features/levels/models/activity_model.dart';

// --- Legacy Support (Deprecated) ---

/// @deprecated Use Activity instead. All activities are now unified.
class Lesson {
  final String lessonId;
  final String title;
  final String introduction;
  final List<Activity> activities;

  Lesson({
    required this.lessonId,
    required this.title,
    required this.introduction,
    required this.activities,
  });
}
