import 'package:le_petit_davinci/features/lessons2/models/draw_letter_activity_model.dart';
import 'package:le_petit_davinci/features/lessons2/models/select_item_activity_model.dart';

class Lesson {
  final String id;
  final String title;
  final String description;
  final String youtubeVideoId;
  final List<LessonActivity> activities;
  final int levelNumber;
  final String thumbnailImagePath;

  const Lesson({
    required this.id,
    required this.title,
    required this.description,
    required this.youtubeVideoId,
    required this.activities,
    required this.levelNumber,
    required this.thumbnailImagePath,
  });
}

enum ActivityType { drawLetters, selectItems, matchPairs, coloringTemplate }

abstract class LessonActivity {
  final String id;
  final String title;
  final String instruction;
  final ActivityType type;

  const LessonActivity({
    required this.id,
    required this.title,
    required this.instruction,
    required this.type,
  });

  // Factory methods to easily create different activity types
  factory LessonActivity.drawLetters({
    required String id,
    required String title,
    required String instruction,
    required List<LetterModel> letters,
  }) {
    return DrawLettersActivity(
      id: id,
      title: title,
      instruction: instruction,
      letters: letters,
    );
  }

  factory LessonActivity.selectItems({
    required String id,
    required String title,
    required String instruction,
    required List<SelectableItem> items,
    required List<String> correctAnswers,
    int maxSelections = 0,
  }) {
    return SelectItemsActivity(
      id: id,
      title: title,
      instruction: instruction,
      items: items,
      correctAnswers: correctAnswers,
      maxSelections: maxSelections,
    );
  }
}
