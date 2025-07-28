enum ActivityType {
  selectItems,
  drawLetters,
  matchPairs,
  sequenceOrder,
  coloringTemplate,
}

abstract class LessonActivity {
  final String id;
  final String title;
  final String instruction;
  final ActivityType type;
  final int estimatedDurationMinutes;

  const LessonActivity({
    required this.id,
    required this.title,
    required this.instruction,
    required this.type,
    required this.estimatedDurationMinutes,
  });

  Map<String, dynamic> toJson();

  // Factory method to create activities from JSON
  static LessonActivity fromJson(Map<String, dynamic> json) {
    final type = ActivityType.values.firstWhere(
      (e) => e.toString() == json['type'],
    );

    switch (type) {
      case ActivityType.selectItems:
        return SelectItemsActivity.fromJson(json);
      case ActivityType.drawLetters:
        return DrawLettersActivity.fromJson(json);
      case ActivityType.matchPairs:
        return MatchPairsActivity.fromJson(json);
      case ActivityType.sequenceOrder:
        return SequenceOrderActivity.fromJson(json);
      case ActivityType.coloringTemplate:
        return ColoringTemplateActivity.fromJson(json);
    }
  }
}

// Activity for selecting specific items
class SelectItemsActivity extends LessonActivity {
  final List<SelectableItem> items;
  final List<int> correctIndices;
  final String selectionPrompt;

  const SelectItemsActivity({
    required super.id,
    required super.title,
    required super.instruction,
    required super.estimatedDurationMinutes,
    required this.items,
    required this.correctIndices,
    required this.selectionPrompt,
  }) : super(type: ActivityType.selectItems);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'instruction': instruction,
      'type': type.toString(),
      'estimatedDurationMinutes': estimatedDurationMinutes,
      'items': items.map((item) => item.toJson()).toList(),
      'correctIndices': correctIndices,
      'selectionPrompt': selectionPrompt,
    };
  }

  factory SelectItemsActivity.fromJson(Map<String, dynamic> json) {
    return SelectItemsActivity(
      id: json['id'],
      title: json['title'],
      instruction: json['instruction'],
      estimatedDurationMinutes: json['estimatedDurationMinutes'],
      items:
          (json['items'] as List)
              .map((item) => SelectableItem.fromJson(item))
              .toList(),
      correctIndices: List<int>.from(json['correctIndices']),
      selectionPrompt: json['selectionPrompt'],
    );
  }
}

class SelectableItem {
  final String id;
  final String label;
  final String imagePath;
  final String? soundPath;

  const SelectableItem({
    required this.id,
    required this.label,
    required this.imagePath,
    this.soundPath,
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
      soundPath: json['soundPath'],
    );
  }
}

// Activity for drawing letters
class DrawLettersActivity extends LessonActivity {
  final List<LetterDrawingTask> letters;
  final String? templateImagePath;
  final bool showGuideLines;

  const DrawLettersActivity({
    required super.id,
    required super.title,
    required super.instruction,
    required super.estimatedDurationMinutes,
    required this.letters,
    this.templateImagePath,
    this.showGuideLines = true,
  }) : super(type: ActivityType.drawLetters);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'instruction': instruction,
      'type': type.toString(),
      'estimatedDurationMinutes': estimatedDurationMinutes,
      'letters': letters.map((letter) => letter.toJson()).toList(),
      'templateImagePath': templateImagePath,
      'showGuideLines': showGuideLines,
    };
  }

  factory DrawLettersActivity.fromJson(Map<String, dynamic> json) {
    return DrawLettersActivity(
      id: json['id'],
      title: json['title'],
      instruction: json['instruction'],
      estimatedDurationMinutes: json['estimatedDurationMinutes'],
      letters:
          (json['letters'] as List)
              .map((letter) => LetterDrawingTask.fromJson(letter))
              .toList(),
      templateImagePath: json['templateImagePath'],
      showGuideLines: json['showGuideLines'] ?? true,
    );
  }
}

class LetterDrawingTask {
  final String letter;
  final String pronunciation;
  final List<String> exampleWords;
  final String? tracingImagePath;

  const LetterDrawingTask({
    required this.letter,
    required this.pronunciation,
    required this.exampleWords,
    this.tracingImagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'letter': letter,
      'pronunciation': pronunciation,
      'exampleWords': exampleWords,
      'tracingImagePath': tracingImagePath,
    };
  }

  factory LetterDrawingTask.fromJson(Map<String, dynamic> json) {
    return LetterDrawingTask(
      letter: json['letter'],
      pronunciation: json['pronunciation'],
      exampleWords: List<String>.from(json['exampleWords']),
      tracingImagePath: json['tracingImagePath'],
    );
  }
}

// Activity for matching pairs
class MatchPairsActivity extends LessonActivity {
  final List<MatchPair> pairs;
  final String matchingPrompt;

  const MatchPairsActivity({
    required super.id,
    required super.title,
    required super.instruction,
    required super.estimatedDurationMinutes,
    required this.pairs,
    required this.matchingPrompt,
  }) : super(type: ActivityType.matchPairs);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'instruction': instruction,
      'type': type.toString(),
      'estimatedDurationMinutes': estimatedDurationMinutes,
      'pairs': pairs.map((pair) => pair.toJson()).toList(),
      'matchingPrompt': matchingPrompt,
    };
  }

  factory MatchPairsActivity.fromJson(Map<String, dynamic> json) {
    return MatchPairsActivity(
      id: json['id'],
      title: json['title'],
      instruction: json['instruction'],
      estimatedDurationMinutes: json['estimatedDurationMinutes'],
      pairs:
          (json['pairs'] as List)
              .map((pair) => MatchPair.fromJson(pair))
              .toList(),
      matchingPrompt: json['matchingPrompt'],
    );
  }
}

class MatchPair {
  final String leftId;
  final String rightId;
  final String leftContent;
  final String rightContent;
  final String leftImagePath;
  final String rightImagePath;

  const MatchPair({
    required this.leftId,
    required this.rightId,
    required this.leftContent,
    required this.rightContent,
    required this.leftImagePath,
    required this.rightImagePath,
  });

  Map<String, dynamic> toJson() {
    return {
      'leftId': leftId,
      'rightId': rightId,
      'leftContent': leftContent,
      'rightContent': rightContent,
      'leftImagePath': leftImagePath,
      'rightImagePath': rightImagePath,
    };
  }

  factory MatchPair.fromJson(Map<String, dynamic> json) {
    return MatchPair(
      leftId: json['leftId'],
      rightId: json['rightId'],
      leftContent: json['leftContent'],
      rightContent: json['rightContent'],
      leftImagePath: json['leftImagePath'],
      rightImagePath: json['rightImagePath'],
    );
  }
}

// Activity for sequence ordering
class SequenceOrderActivity extends LessonActivity {
  final List<SequenceItem> items;
  final List<int> correctOrder;
  final String sequencePrompt;

  const SequenceOrderActivity({
    required super.id,
    required super.title,
    required super.instruction,
    required super.estimatedDurationMinutes,
    required this.items,
    required this.correctOrder,
    required this.sequencePrompt,
  }) : super(type: ActivityType.sequenceOrder);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'instruction': instruction,
      'type': type.toString(),
      'estimatedDurationMinutes': estimatedDurationMinutes,
      'items': items.map((item) => item.toJson()).toList(),
      'correctOrder': correctOrder,
      'sequencePrompt': sequencePrompt,
    };
  }

  factory SequenceOrderActivity.fromJson(Map<String, dynamic> json) {
    return SequenceOrderActivity(
      id: json['id'],
      title: json['title'],
      instruction: json['instruction'],
      estimatedDurationMinutes: json['estimatedDurationMinutes'],
      items:
          (json['items'] as List)
              .map((item) => SequenceItem.fromJson(item))
              .toList(),
      correctOrder: List<int>.from(json['correctOrder']),
      sequencePrompt: json['sequencePrompt'],
    );
  }
}

class SequenceItem {
  final String id;
  final String content;
  final String imagePath;
  final int position;

  const SequenceItem({
    required this.id,
    required this.content,
    required this.imagePath,
    required this.position,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'imagePath': imagePath,
      'position': position,
    };
  }

  factory SequenceItem.fromJson(Map<String, dynamic> json) {
    return SequenceItem(
      id: json['id'],
      content: json['content'],
      imagePath: json['imagePath'],
      position: json['position'],
    );
  }
}

// Activity for coloring templates
class ColoringTemplateActivity extends LessonActivity {
  final String templateImagePath;
  final List<String> suggestedColors;
  final String coloringPrompt;

  const ColoringTemplateActivity({
    required super.id,
    required super.title,
    required super.instruction,
    required super.estimatedDurationMinutes,
    required this.templateImagePath,
    required this.suggestedColors,
    required this.coloringPrompt,
  }) : super(type: ActivityType.coloringTemplate);

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'instruction': instruction,
      'type': type.toString(),
      'estimatedDurationMinutes': estimatedDurationMinutes,
      'templateImagePath': templateImagePath,
      'suggestedColors': suggestedColors,
      'coloringPrompt': coloringPrompt,
    };
  }

  factory ColoringTemplateActivity.fromJson(Map<String, dynamic> json) {
    return ColoringTemplateActivity(
      id: json['id'],
      title: json['title'],
      instruction: json['instruction'],
      estimatedDurationMinutes: json['estimatedDurationMinutes'],
      templateImagePath: json['templateImagePath'],
      suggestedColors: List<String>.from(json['suggestedColors']),
      coloringPrompt: json['coloringPrompt'],
    );
  }
}
