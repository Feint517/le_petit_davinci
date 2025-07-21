// lib/features/Mathematic/models/tidy_room_model.dart

enum ToyType { car, doll, book, ball, teddy, block, puzzle, robot }

enum ToyColor { red, blue, green, yellow, pink, purple }

enum ToySize { small, medium, large }

enum SortingCriteria {
  color,
  type,
  size,
  mixed, // Multiple criteria
}

class Toy {
  final String id;
  final ToyType type;
  final ToyColor color;
  final ToySize size;
  final String emoji;
  final String frenchName;
  final String description;

  const Toy({
    required this.id,
    required this.type,
    required this.color,
    required this.size,
    required this.emoji,
    required this.frenchName,
    required this.description,
  });

  // Get French color name
  String get frenchColorName {
    switch (color) {
      case ToyColor.red:
        return 'rouge';
      case ToyColor.blue:
        return 'bleu';
      case ToyColor.green:
        return 'vert';
      case ToyColor.yellow:
        return 'jaune';
      case ToyColor.pink:
        return 'rose';
      case ToyColor.purple:
        return 'violet';
    }
  }

  // Get French size name
  String get frenchSizeName {
    switch (size) {
      case ToySize.small:
        return 'petit';
      case ToySize.medium:
        return 'moyen';
      case ToySize.large:
        return 'grand';
    }
  }

  // Get full French description
  String get fullFrenchDescription {
    return '$frenchName ${frenchColorName} ${frenchSizeName}';
  }
}

class SortingBox {
  final String id;
  final SortingCriteria criteria;
  final dynamic targetValue; // ToyColor, ToyType, ToySize, or Map for mixed
  final String label;
  final String frenchLabel;
  final String emoji;
  final List<Toy> containedToys;

  SortingBox({
    required this.id,
    required this.criteria,
    required this.targetValue,
    required this.label,
    required this.frenchLabel,
    required this.emoji,
    List<Toy>? containedToys,
  }) : containedToys = containedToys ?? [];

  // Check if toy belongs in this box
  bool acceptsToy(Toy toy) {
    switch (criteria) {
      case SortingCriteria.color:
        return toy.color == targetValue;
      case SortingCriteria.type:
        return toy.type == targetValue;
      case SortingCriteria.size:
        return toy.size == targetValue;
      case SortingCriteria.mixed:
        if (targetValue is Map) {
          final Map<String, dynamic> criteria =
              targetValue as Map<String, dynamic>;
          return _matchesAllCriteria(toy, criteria);
        }
        return false;
    }
  }

  bool _matchesAllCriteria(Toy toy, Map<String, dynamic> criteria) {
    for (final entry in criteria.entries) {
      switch (entry.key) {
        case 'color':
          if (toy.color != entry.value) return false;
          break;
        case 'type':
          if (toy.type != entry.value) return false;
          break;
        case 'size':
          if (toy.size != entry.value) return false;
          break;
      }
    }
    return true;
  }

  SortingBox copyWith({List<Toy>? containedToys}) {
    return SortingBox(
      id: id,
      criteria: criteria,
      targetValue: targetValue,
      label: label,
      frenchLabel: frenchLabel,
      emoji: emoji,
      containedToys: containedToys ?? this.containedToys,
    );
  }
}

class TidyRoomLevel {
  final int level;
  final SortingCriteria sortingCriteria;
  final List<Toy> toysToSort;
  final List<SortingBox> sortingBoxes;
  final String title;
  final String frenchTitle;
  final String description;
  final String instruction;

  const TidyRoomLevel({
    required this.level,
    required this.sortingCriteria,
    required this.toysToSort,
    required this.sortingBoxes,
    required this.title,
    required this.frenchTitle,
    required this.description,
    required this.instruction,
  });
}

class TidyRoomData {
  // All available toys
  static const List<Toy> allToys = [
    // Cars
    Toy(
      id: 'car_red_small',
      type: ToyType.car,
      color: ToyColor.red,
      size: ToySize.small,
      emoji: '🚗',
      frenchName: 'voiture',
      description: 'Petite voiture rouge',
    ),
    Toy(
      id: 'car_blue_medium',
      type: ToyType.car,
      color: ToyColor.blue,
      size: ToySize.medium,
      emoji: '🚙',
      frenchName: 'voiture',
      description: 'Voiture bleue moyenne',
    ),
    Toy(
      id: 'car_green_large',
      type: ToyType.car,
      color: ToyColor.green,
      size: ToySize.large,
      emoji: '🚐',
      frenchName: 'voiture',
      description: 'Grande voiture verte',
    ),

    // Dolls
    Toy(
      id: 'doll_pink_small',
      type: ToyType.doll,
      color: ToyColor.pink,
      size: ToySize.small,
      emoji: '🪆',
      frenchName: 'poupée',
      description: 'Petite poupée rose',
    ),
    Toy(
      id: 'doll_purple_medium',
      type: ToyType.doll,
      color: ToyColor.purple,
      size: ToySize.medium,
      emoji: '👸',
      frenchName: 'poupée',
      description: 'Poupée violette moyenne',
    ),

    // Books
    Toy(
      id: 'book_red_small',
      type: ToyType.book,
      color: ToyColor.red,
      size: ToySize.small,
      emoji: '📕',
      frenchName: 'livre',
      description: 'Petit livre rouge',
    ),
    Toy(
      id: 'book_blue_medium',
      type: ToyType.book,
      color: ToyColor.blue,
      size: ToySize.medium,
      emoji: '📘',
      frenchName: 'livre',
      description: 'Livre bleu moyen',
    ),
    Toy(
      id: 'book_green_large',
      type: ToyType.book,
      color: ToyColor.green,
      size: ToySize.large,
      emoji: '📗',
      frenchName: 'livre',
      description: 'Grand livre vert',
    ),

    // Balls
    Toy(
      id: 'ball_red_small',
      type: ToyType.ball,
      color: ToyColor.red,
      size: ToySize.small,
      emoji: '🔴',
      frenchName: 'balle',
      description: 'Petite balle rouge',
    ),
    Toy(
      id: 'ball_blue_large',
      type: ToyType.ball,
      color: ToyColor.blue,
      size: ToySize.large,
      emoji: '🔵',
      frenchName: 'ballon',
      description: 'Grand ballon bleu',
    ),

    // Teddy bears
    Toy(
      id: 'teddy_yellow_medium',
      type: ToyType.teddy,
      color: ToyColor.yellow,
      size: ToySize.medium,
      emoji: '🧸',
      frenchName: 'nounours',
      description: 'Nounours jaune moyen',
    ),
    Toy(
      id: 'teddy_pink_large',
      type: ToyType.teddy,
      color: ToyColor.pink,
      size: ToySize.large,
      emoji: '🐻',
      frenchName: 'nounours',
      description: 'Grand nounours rose',
    ),

    // Blocks
    Toy(
      id: 'block_red_small',
      type: ToyType.block,
      color: ToyColor.red,
      size: ToySize.small,
      emoji: '🟥',
      frenchName: 'cube',
      description: 'Petit cube rouge',
    ),
    Toy(
      id: 'block_yellow_small',
      type: ToyType.block,
      color: ToyColor.yellow,
      size: ToySize.small,
      emoji: '🟨',
      frenchName: 'cube',
      description: 'Petit cube jaune',
    ),

    // Robots
    Toy(
      id: 'robot_blue_medium',
      type: ToyType.robot,
      color: ToyColor.blue,
      size: ToySize.medium,
      emoji: '🤖',
      frenchName: 'robot',
      description: 'Robot bleu moyen',
    ),
  ];

  // Level definitions
  static final List<TidyRoomLevel> levels = [
    // Level 1: Sort by Color (Red vs Blue)
    TidyRoomLevel(
      level: 1,
      sortingCriteria: SortingCriteria.color,
      toysToSort: [
        allToys[0], // red car
        allToys[1], // blue car
        allToys[5], // red book
        allToys[6], // blue book
        allToys[8], // red ball
        allToys[9], // blue ball
      ],
      sortingBoxes: [
        SortingBox(
          id: 'red_box',
          criteria: SortingCriteria.color,
          targetValue: ToyColor.red,
          label: 'Red Box',
          frenchLabel: 'Boîte Rouge',
          emoji: '🟥',
        ),
        SortingBox(
          id: 'blue_box',
          criteria: SortingCriteria.color,
          targetValue: ToyColor.blue,
          label: 'Blue Box',
          frenchLabel: 'Boîte Bleue',
          emoji: '🟦',
        ),
      ],
      title: 'Sort by Color',
      frenchTitle: 'Trier par Couleur',
      description:
          'Mets les jouets rouges dans la boîte rouge et les jouets bleus dans la boîte bleue.',
      instruction: 'Trie par couleur: rouge et bleu',
    ),

    // Level 2: Sort by Type (Cars vs Books)
    TidyRoomLevel(
      level: 2,
      sortingCriteria: SortingCriteria.type,
      toysToSort: [
        allToys[0], // red car
        allToys[1], // blue car
        allToys[2], // green car
        allToys[5], // red book
        allToys[6], // blue book
        allToys[7], // green book
      ],
      sortingBoxes: [
        SortingBox(
          id: 'car_garage',
          criteria: SortingCriteria.type,
          targetValue: ToyType.car,
          label: 'Car Garage',
          frenchLabel: 'Garage',
          emoji: '🏠',
        ),
        SortingBox(
          id: 'book_shelf',
          criteria: SortingCriteria.type,
          targetValue: ToyType.book,
          label: 'Bookshelf',
          frenchLabel: 'Bibliothèque',
          emoji: '📚',
        ),
      ],
      title: 'Sort by Type',
      frenchTitle: 'Trier par Type',
      description:
          'Mets les voitures au garage et les livres sur la bibliothèque.',
      instruction: 'Trie par type: voitures et livres',
    ),

    // Level 3: Sort by Size (Small vs Large)
    TidyRoomLevel(
      level: 3,
      sortingCriteria: SortingCriteria.size,
      toysToSort: [
        allToys[0], // small red car
        allToys[2], // large green car
        allToys[3], // small pink doll
        allToys[11], // large pink teddy
        allToys[12], // small red block
        allToys[13], // small yellow block
      ],
      sortingBoxes: [
        SortingBox(
          id: 'small_box',
          criteria: SortingCriteria.size,
          targetValue: ToySize.small,
          label: 'Small Box',
          frenchLabel: 'Petite Boîte',
          emoji: '📦',
        ),
        SortingBox(
          id: 'large_box',
          criteria: SortingCriteria.size,
          targetValue: ToySize.large,
          label: 'Large Box',
          frenchLabel: 'Grande Boîte',
          emoji: '📫',
        ),
      ],
      title: 'Sort by Size',
      frenchTitle: 'Trier par Taille',
      description:
          'Mets les petits jouets dans la petite boîte et les grands jouets dans la grande boîte.',
      instruction: 'Trie par taille: petits et grands',
    ),

    // Level 4: Mixed Criteria (Red Cars vs Blue Books)
    TidyRoomLevel(
      level: 4,
      sortingCriteria: SortingCriteria.mixed,
      toysToSort: [
        allToys[0], // red car
        allToys[1], // blue car
        allToys[5], // red book
        allToys[6], // blue book
        allToys[8], // red ball
        allToys[14], // blue robot
      ],
      sortingBoxes: [
        SortingBox(
          id: 'red_vehicles',
          criteria: SortingCriteria.mixed,
          targetValue: {'color': ToyColor.red, 'type': ToyType.car},
          label: 'Red Cars',
          frenchLabel: 'Voitures Rouges',
          emoji: '🚗',
        ),
        SortingBox(
          id: 'blue_books',
          criteria: SortingCriteria.mixed,
          targetValue: {'color': ToyColor.blue, 'type': ToyType.book},
          label: 'Blue Books',
          frenchLabel: 'Livres Bleus',
          emoji: '📘',
        ),
        SortingBox(
          id: 'other_toys',
          criteria: SortingCriteria.mixed,
          targetValue: {'other': true}, // Everything else
          label: 'Other Toys',
          frenchLabel: 'Autres Jouets',
          emoji: '🧸',
        ),
      ],
      title: 'Advanced Sorting',
      frenchTitle: 'Tri Avancé',
      description:
          'Trie avec plusieurs critères: voitures rouges, livres bleus, et autres jouets.',
      instruction: 'Tri complexe: deux critères à la fois',
    ),
  ];

  // Get level data
  static TidyRoomLevel getLevelData(int level) {
    if (level < 1 || level > levels.length) {
      return levels[0];
    }
    return levels[level - 1];
  }

  // Get total number of levels
  static int get totalLevels => levels.length;

  // Validate toy placement
  static bool validatePlacement(Toy toy, SortingBox box) {
    return box.acceptsToy(toy);
  }
}

// Model for tracking room progress
class RoomProgress {
  final int currentLevel;
  final int totalLevels;
  final int toysSorted;
  final int totalToys;
  final bool isLevelCompleted;
  final bool isGameCompleted;
  final List<int> completedLevels;
  final Map<String, List<Toy>> sortingResults;

  const RoomProgress({
    required this.currentLevel,
    required this.totalLevels,
    required this.toysSorted,
    required this.totalToys,
    required this.isLevelCompleted,
    required this.isGameCompleted,
    required this.completedLevels,
    required this.sortingResults,
  });

  RoomProgress copyWith({
    int? currentLevel,
    int? totalLevels,
    int? toysSorted,
    int? totalToys,
    bool? isLevelCompleted,
    bool? isGameCompleted,
    List<int>? completedLevels,
    Map<String, List<Toy>>? sortingResults,
  }) {
    return RoomProgress(
      currentLevel: currentLevel ?? this.currentLevel,
      totalLevels: totalLevels ?? this.totalLevels,
      toysSorted: toysSorted ?? this.toysSorted,
      totalToys: totalToys ?? this.totalToys,
      isLevelCompleted: isLevelCompleted ?? this.isLevelCompleted,
      isGameCompleted: isGameCompleted ?? this.isGameCompleted,
      completedLevels: completedLevels ?? this.completedLevels,
      sortingResults: sortingResults ?? this.sortingResults,
    );
  }

  double get progressPercentage {
    if (totalToys == 0) return 0.0;
    return toysSorted / totalToys;
  }
}
