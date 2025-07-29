import 'package:le_petit_davinci/features/lessons2/models/lesson_model.dart';

class SelectItemsActivity extends LessonActivity {
  final List<SelectableItem> items;
  final List<String> correctAnswers;
  final int maxSelections;

  const SelectItemsActivity({
    required super.id,
    required super.title,
    required super.instruction,
    required this.items,
    required this.correctAnswers,
    this.maxSelections = 0,
  }) : super(type: ActivityType.selectItems);

  //* Check if a list of selections is correct
  bool isSelectionCorrect(List<String> selectedIds) {
    //? If maxSelections is set, ensure they've selected the right number
    if (maxSelections > 0 && selectedIds.length != maxSelections) {
      return false;
    }

    //* Check if all selected items are in the correct answers
    for (final selectedId in selectedIds) {
      if (!correctAnswers.contains(selectedId)) {
        return false;
      }
    }

    //* Check if all required answers are selected
    if (maxSelections == 0) {
      //? If no max is set, they need to select all correct answers
      for (final correctAnswer in correctAnswers) {
        if (!selectedIds.contains(correctAnswer)) {
          return false;
        }
      }
    }

    return true;
  }
}

class SelectableItem {
  final String id;
  final String label;
  final String imagePath;
  final String soundPath;

  const SelectableItem({
    required this.id,
    required this.label,
    required this.imagePath,
    this.soundPath = '',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'imagePath': imagePath,
      'soundPath': soundPath,
    };
  }

  factory SelectableItem.fromJson(Map<String, dynamic> json) {
    return SelectableItem(
      id: json['id'],
      label: json['label'],
      imagePath: json['imagePath'],
      soundPath: json['soundPath'] ?? '',
    );
  }
}
