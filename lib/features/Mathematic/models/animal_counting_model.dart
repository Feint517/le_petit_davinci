// lib/features/Mathematic/models/animal_counting_model.dart

class Animal {
  final String name;
  final String frenchName;
  final String emoji;
  final String soundPath;
  final String imagePath;

  const Animal({
    required this.name,
    required this.frenchName,
    required this.emoji,
    required this.soundPath,
    required this.imagePath,
  });
}

class AnimalCountingData {
  // Available animals for the counting game
  static const List<Animal> allAnimals = [
    Animal(
      name: 'cow',
      frenchName: 'vache',
      emoji: '🐄',
      soundPath: 'sounds/cow.mp3',
      imagePath: 'assets/images/animals/cow.svg',
    ),
    Animal(
      name: 'sheep',
      frenchName: 'mouton',
      emoji: '🐑',
      soundPath: 'sounds/sheep.mp3',
      imagePath: 'assets/images/animals/sheep.svg',
    ),
    Animal(
      name: 'chicken',
      frenchName: 'poule',
      emoji: '🐔',
      soundPath: 'sounds/chicken.mp3',
      imagePath: 'assets/images/animals/chicken.svg',
    ),
    Animal(
      name: 'pig',
      frenchName: 'cochon',
      emoji: '🐷',
      soundPath: 'sounds/pig.mp3',
      imagePath: 'assets/images/animals/pig.svg',
    ),
    Animal(
      name: 'duck',
      frenchName: 'canard',
      emoji: '🦆',
      soundPath: 'sounds/duck.mp3',
      imagePath: 'assets/images/animals/duck.svg',
    ),
    Animal(
      name: 'horse',
      frenchName: 'cheval',
      emoji: '🐴',
      soundPath: 'sounds/horse.mp3',
      imagePath: 'assets/images/animals/horse.svg',
    ),
  ];

  // Get random animals for a specific count
  static List<Animal> getAnimalsForCount(int count) {
    if (count <= 0 || count > 10) return [];

    List<Animal> selectedAnimals = [];
    List<Animal> availableAnimals = List.from(allAnimals);

    for (int i = 0; i < count; i++) {
      if (availableAnimals.isEmpty) {
        // If we need more animals than available, repeat the list
        availableAnimals = List.from(allAnimals);
      }

      // Pick a random animal and remove it to avoid immediate duplicates
      final randomIndex = (i % availableAnimals.length);
      selectedAnimals.add(availableAnimals[randomIndex]);
      if (availableAnimals.length > 1) {
        availableAnimals.removeAt(randomIndex);
      }
    }

    return selectedAnimals;
  }
}

// Model for tracking counting progress
class CountingProgress {
  final int currentNumber;
  final int totalNumbers;
  final bool isCompleted;
  final List<int> completedNumbers;

  const CountingProgress({
    required this.currentNumber,
    required this.totalNumbers,
    required this.isCompleted,
    required this.completedNumbers,
  });

  CountingProgress copyWith({
    int? currentNumber,
    int? totalNumbers,
    bool? isCompleted,
    List<int>? completedNumbers,
  }) {
    return CountingProgress(
      currentNumber: currentNumber ?? this.currentNumber,
      totalNumbers: totalNumbers ?? this.totalNumbers,
      isCompleted: isCompleted ?? this.isCompleted,
      completedNumbers: completedNumbers ?? this.completedNumbers,
    );
  }
}
