// lib/features/Mathematic/controllers/tidy_room_controller.dart

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/Mathematic/models/tidy_room_model.dart';

class TidyRoomController extends GetxController {
  // Observable variables
  final currentLevel = 1.obs;
  final availableToys = <Toy>[].obs;
  final sortingBoxes = <SortingBox>[].obs;
  final completedLevels = <int>[].obs;
  final isLoading = false.obs;
  final showCelebration = false.obs;
  final showLevelComplete = false.obs;
  final isDraggingToy = false.obs;
  final animationTrigger = 0.obs;
  final draggedToy = Rxn<Toy>();

  // Current level data
  final currentLevelData = Rxn<TidyRoomLevel>();
  final sortingProgress = <String, int>{}.obs; // box_id -> toy_count

  // Non-reactive variables
  final FlutterTts flutterTts = FlutterTts();
  final int maxLevel = TidyRoomData.totalLevels;

  @override
  void onInit() {
    super.onInit();
    initTts();
    _initializeLevel();
  }

  @override
  void onClose() {
    flutterTts.stop();
    super.onClose();
  }

  Future<void> initTts() async {
    try {
      await flutterTts.setLanguage('fr-FR');
      await flutterTts.setSpeechRate(0.6);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.1);
    } catch (e) {
      print('TTS initialization error: $e');
    }
  }

  // Initialize current level
  void _initializeLevel() {
    isLoading.value = true;

    try {
      // Get level data
      currentLevelData.value = TidyRoomData.getLevelData(currentLevel.value);

      // Set available toys (copies to avoid modifying original data)
      availableToys.value = List.from(currentLevelData.value!.toysToSort);

      // Initialize sorting boxes (empty initially)
      sortingBoxes.value =
          currentLevelData.value!.sortingBoxes.map((box) {
            return box.copyWith(containedToys: []);
          }).toList();

      // Reset progress tracking
      sortingProgress.clear();
      for (final box in sortingBoxes) {
        sortingProgress[box.id] = 0;
      }

      // Reset drag state
      isDraggingToy.value = false;
      draggedToy.value = null;
    } catch (e) {
      print('Error initializing level: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Handle toy drag start
  void onToyDragStart(Toy toy) {
    isDraggingToy.value = true;
    draggedToy.value = toy;
  }

  // Handle toy drop on sorting box
  Future<void> sortToyIntoBox(Toy toy, SortingBox targetBox) async {
    try {
      // Validate placement
      if (!TidyRoomData.validatePlacement(toy, targetBox)) {
        await _handleIncorrectPlacement(toy, targetBox);
        return;
      }

      // Remove toy from available toys
      availableToys.remove(toy);

      // Add toy to sorting box
      final boxIndex = sortingBoxes.indexWhere((box) => box.id == targetBox.id);
      if (boxIndex != -1) {
        final updatedBox = sortingBoxes[boxIndex];
        updatedBox.containedToys.add(toy);
        sortingBoxes[boxIndex] = updatedBox;

        // Update progress tracking
        sortingProgress[targetBox.id] = updatedBox.containedToys.length;
      }

      // Trigger animation
      animationTrigger.value++;

      // Speak success message and toy description
      await _handleCorrectPlacement(toy, targetBox);

      // Check if level is complete
      if (availableToys.isEmpty) {
        await _handleLevelComplete();
      }
    } catch (e) {
      print('Error sorting toy: $e');
    } finally {
      isDraggingToy.value = false;
      draggedToy.value = null;
    }
  }

  // Handle correct toy placement
  Future<void> _handleCorrectPlacement(Toy toy, SortingBox box) async {
    // Speak success message
    final successMessages = ['Parfait!', 'Bien joué!', 'Excellent!'];
    final message =
        successMessages[DateTime.now().millisecond % successMessages.length];
    await flutterTts.speak(message);

    // Speak toy description
    await speakToyDescription(toy);

    // Speak box name
    await flutterTts.speak('dans la ${box.frenchLabel}');
  }

  // Handle incorrect toy placement
  Future<void> _handleIncorrectPlacement(Toy toy, SortingBox box) async {
    // Speak gentle correction
    final correctionMessages = [
      'Essaie encore!',
      'Pas dans cette boîte!',
      'Cherche la bonne boîte!',
    ];
    final message =
        correctionMessages[DateTime.now().millisecond %
            correctionMessages.length];
    await flutterTts.speak(message);

    // Give hint about correct placement
    await _giveHintForToy(toy);
  }

  // Give hint about where toy should go
  Future<void> _giveHintForToy(Toy toy) async {
    final levelData = currentLevelData.value;
    if (levelData == null) return;

    switch (levelData.sortingCriteria) {
      case SortingCriteria.color:
        await flutterTts.speak('Cherche la boîte ${toy.frenchColorName}');
        break;
      case SortingCriteria.type:
        await flutterTts.speak('Où vont les ${toy.frenchName}s?');
        break;
      case SortingCriteria.size:
        await flutterTts.speak(
          'Cherche la boîte pour les jouets ${toy.frenchSizeName}s',
        );
        break;
      case SortingCriteria.mixed:
        await flutterTts.speak('Regarde bien les critères de chaque boîte');
        break;
    }
  }

  // Handle level completion
  Future<void> _handleLevelComplete() async {
    completedLevels.add(currentLevel.value);
    showLevelComplete.value = true;

    // Speak completion message
    await flutterTts.speak('Bravo! La chambre est maintenant bien rangée!');

    // Count toys sorted
    final totalToysSorted = sortingBoxes.fold<int>(
      0,
      (total, box) => total + box.containedToys.length,
    );
    await speakNumber(totalToysSorted);
    await flutterTts.speak('jouets bien rangés!');

    // Hide level complete after 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    showLevelComplete.value = false;

    // Check if game is complete
    if (currentLevel.value >= maxLevel) {
      await _handleGameComplete();
    } else {
      // Move to next level
      currentLevel.value++;
      _initializeLevel();
    }
  }

  // Handle game completion
  Future<void> _handleGameComplete() async {
    showCelebration.value = true;
    await flutterTts.speak(
      'Félicitations! Tu es maintenant un expert du rangement!',
    );

    // Hide celebration after 4 seconds
    await Future.delayed(const Duration(seconds: 4));
    showCelebration.value = false;
  }

  // Speak number in French
  Future<void> speakNumber(int number) async {
    try {
      final frenchNumbers = {
        1: 'un',
        2: 'deux',
        3: 'trois',
        4: 'quatre',
        5: 'cinq',
        6: 'six',
        7: 'sept',
        8: 'huit',
        9: 'neuf',
        10: 'dix',
        11: 'onze',
        12: 'douze',
        13: 'treize',
        14: 'quatorze',
        15: 'quinze',
      };

      final frenchNumber = frenchNumbers[number] ?? number.toString();
      await flutterTts.speak(frenchNumber);
    } catch (e) {
      print('TTS speak number error: $e');
    }
  }

  // Speak toy description in French
  Future<void> speakToyDescription(Toy toy) async {
    try {
      await flutterTts.speak(toy.fullFrenchDescription);
    } catch (e) {
      print('TTS speak toy error: $e');
    }
  }

  // Speak sorting instructions
  Future<void> speakInstructions() async {
    final levelData = currentLevelData.value;
    if (levelData == null) return;

    try {
      await flutterTts.speak(levelData.instruction);
      await Future.delayed(const Duration(seconds: 1));
      await flutterTts.speak(levelData.description);
    } catch (e) {
      print('TTS speak instructions error: $e');
    }
  }

  // Reset current level
  void resetCurrentLevel() {
    _initializeLevel();
  }

  // Reset entire game
  void resetGame() {
    currentLevel.value = 1;
    completedLevels.clear();
    showCelebration.value = false;
    showLevelComplete.value = false;
    _initializeLevel();
  }

  // Skip to next level (for testing)
  void skipToNextLevel() {
    if (currentLevel.value < maxLevel) {
      currentLevel.value++;
      _initializeLevel();
    }
  }

  // Get current level title
  String getCurrentLevelTitle() {
    return currentLevelData.value?.frenchTitle ?? '';
  }

  // Get current level instruction
  String getCurrentLevelInstruction() {
    return currentLevelData.value?.instruction ?? '';
  }

  // Get progress percentage for current level
  double getCurrentLevelProgress() {
    final levelData = currentLevelData.value;
    if (levelData == null) return 0.0;

    final totalToys = levelData.toysToSort.length;
    final sortedToys = totalToys - availableToys.length;
    return totalToys == 0 ? 0.0 : sortedToys / totalToys;
  }

  // Get overall game progress
  double getOverallProgress() {
    return currentLevel.value / maxLevel;
  }

  // Check if can drop toy in box
  bool canDropToyInBox(Toy toy, SortingBox box) {
    return TidyRoomData.validatePlacement(toy, box);
  }

  // Get toys in specific sorting box
  List<Toy> getToysInBox(String boxId) {
    final box = sortingBoxes.firstWhereOrNull((box) => box.id == boxId);
    return box?.containedToys ?? [];
  }

  // Get total toys sorted this level
  int getTotalToysSorted() {
    final levelData = currentLevelData.value;
    if (levelData == null) return 0;

    return levelData.toysToSort.length - availableToys.length;
  }

  // Check if level is completed
  bool isLevelCompleted() {
    return availableToys.isEmpty;
  }

  // Get sorting summary for level
  Map<String, int> getSortingSummary() {
    final summary = <String, int>{};
    for (final box in sortingBoxes) {
      summary[box.frenchLabel] = box.containedToys.length;
    }
    return summary;
  }

  // Check which box toy should go to (for hints)
  SortingBox? getCorrectBoxForToy(Toy toy) {
    for (final box in sortingBoxes) {
      if (box.acceptsToy(toy)) {
        return box;
      }
    }
    return null;
  }

  // Speak hint for specific toy
  Future<void> speakToyHint(Toy toy) async {
    final correctBox = getCorrectBoxForToy(toy);
    if (correctBox != null) {
      await flutterTts.speak(
        '${toy.fullFrenchDescription} va dans ${correctBox.frenchLabel}',
      );
    } else {
      await flutterTts.speak('Où va ${toy.fullFrenchDescription}?');
    }
  }

  // Get room cleanliness percentage (for visual effect)
  double getRoomCleanliness() {
    return getCurrentLevelProgress();
  }
}
