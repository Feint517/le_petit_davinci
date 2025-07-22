// lib/features/Mathematic/controllers/market_balance_controller.dart

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/Mathematic/models/market_balance_model.dart';

class MarketBalanceController extends GetxController {
  // Observable variables
  final currentLevel = 1.obs;
  final scaleState =
      ScaleState(
        leftItems: [],
        rightItems: [],
        comparison: ComparisonType.equal,
        leftWeight: 0,
        rightWeight: 0,
        tiltAngle: 0,
      ).obs;

  final availableItems = <MarketItem>[].obs;
  final completedLevels = <int>[].obs;
  final isLoading = false.obs;
  final showCelebration = false.obs;
  final showLevelComplete = false.obs;
  final isDraggingItem = false.obs;
  final animationTrigger = 0.obs;
  final draggedItem = Rxn<MarketItem>();

  // Current level data
  final currentLevelData = Rxn<BalanceLevel>();
  final correctComparisons = 0.obs;
  final totalComparisons = 0.obs;

  // Special state for number vs object level
  final targetNumber = 0.obs;
  final showTargetNumber = false.obs;

  // Non-reactive variables
  final FlutterTts flutterTts = FlutterTts();
  final int maxLevel = MarketBalanceData.totalLevels;

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
      currentLevelData.value = MarketBalanceData.getLevelData(
        currentLevel.value,
      );
      final levelData = currentLevelData.value!;

      // Set initial scale state
      scaleState.value = levelData.initialState;

      // Set available items for interaction
      availableItems.value = List.from(levelData.availableItems);

      // Special setup for number vs object level
      if (levelData.type == LevelType.numberVsObject) {
        targetNumber.value = levelData.initialState.leftWeight.toInt();
        showTargetNumber.value = true;
      } else {
        showTargetNumber.value = false;
      }

      // Reset drag state
      isDraggingItem.value = false;
      draggedItem.value = null;
    } catch (e) {
      print('Error initializing level: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Handle item drag start
  void onItemDragStart(MarketItem item) {
    isDraggingItem.value = true;
    draggedItem.value = item;
  }

  // Handle item drop on scale side
  Future<void> dropItemOnScale(MarketItem item, ScaleSide side) async {
    try {
      // Remove item from available items
      availableItems.remove(item);

      // Add item to appropriate scale side
      final currentState = scaleState.value;
      List<MarketItem> leftItems = List.from(currentState.leftItems);
      List<MarketItem> rightItems = List.from(currentState.rightItems);

      if (side == ScaleSide.left) {
        leftItems.add(item);
      } else {
        rightItems.add(item);
      }

      // Calculate new weights
      double leftWeight = leftItems.length.toDouble();
      double rightWeight = rightItems.length.toDouble();

      // Special handling for number vs object level
      if (currentLevelData.value?.type == LevelType.numberVsObject) {
        leftWeight =
            targetNumber.value.toDouble(); // Number side stays constant
        rightWeight = rightItems.length.toDouble();
      }

      // Calculate comparison and tilt angle
      final comparison = MarketBalanceData.calculateComparison(
        leftWeight,
        rightWeight,
      );
      final tiltAngle = MarketBalanceData.calculateTiltAngle(
        leftWeight,
        rightWeight,
      );

      // Update scale state
      scaleState.value = ScaleState(
        leftItems: leftItems,
        rightItems: rightItems,
        comparison: comparison,
        leftWeight: leftWeight,
        rightWeight: rightWeight,
        tiltAngle: tiltAngle,
      );

      // Trigger animation
      animationTrigger.value++;

      // Speak item name and comparison
      await _handleItemPlaced(item, side);

      // Check if level is complete
      await _checkLevelCompletion();
    } catch (e) {
      print('Error dropping item: $e');
    } finally {
      isDraggingItem.value = false;
      draggedItem.value = null;
    }
  }

  // Handle item placement feedback
  Future<void> _handleItemPlaced(MarketItem item, ScaleSide side) async {
    // Speak item name
    await flutterTts.speak(item.frenchName);

    // Brief pause
    await Future.delayed(const Duration(milliseconds: 500));

    // Speak comparison result
    await _speakCurrentComparison();
  }

  // Speak current comparison
  Future<void> _speakCurrentComparison() async {
    final state = scaleState.value;
    final levelData = currentLevelData.value;
    if (levelData == null) return;

    try {
      String leftDescription, rightDescription;

      // Handle different level types
      switch (levelData.type) {
        case LevelType.visualComparison:
        case LevelType.sameItemComparison:
        case LevelType.makeEqual:
          // Get item descriptions
          leftDescription = _getItemsDescription(state.leftItems);
          rightDescription = _getItemsDescription(state.rightItems);
          break;

        case LevelType.numberVsObject:
          leftDescription = 'le chiffre ${targetNumber.value}';
          rightDescription = _getItemsDescription(state.rightItems);
          break;
      }

      // Speak comparison phrase
      final phrase = MarketBalanceData.getComparisonPhrase(
        state.comparison,
        leftDescription,
        rightDescription,
      );
      await flutterTts.speak(phrase);

      // Update comparison tracking
      totalComparisons.value++;
    } catch (e) {
      print('Error speaking comparison: $e');
    }
  }

  // Get description for list of items
  String _getItemsDescription(List<MarketItem> items) {
    if (items.isEmpty) return 'rien';

    final count = items.length;
    final itemName = items.first.frenchName;

    if (count == 1) {
      return '$itemName';
    } else {
      return '$itemName${itemName.endsWith('e') ? 's' : 's'}'; // Simple pluralization
    }
  }

  // Check if level is complete
  Future<void> _checkLevelCompletion() async {
    final levelData = currentLevelData.value;
    if (levelData == null) return;

    bool isComplete = false;

    switch (levelData.type) {
      case LevelType.visualComparison:
      case LevelType.sameItemComparison:
        // These levels complete automatically after showing comparison
        isComplete = true;
        break;

      case LevelType.makeEqual:
        // Complete when scales are balanced
        isComplete = scaleState.value.isBalanced;
        break;

      case LevelType.numberVsObject:
        // Complete when object count equals target number
        isComplete = scaleState.value.rightWeight == targetNumber.value;
        break;
    }

    if (isComplete) {
      correctComparisons.value++;
      await _handleLevelComplete();
    }
  }

  // Handle level completion
  Future<void> _handleLevelComplete() async {
    completedLevels.add(currentLevel.value);
    showLevelComplete.value = true;

    // Speak completion message
    await flutterTts.speak('Parfait! Tu comprends bien les comparaisons!');

    if (scaleState.value.isBalanced) {
      await flutterTts.speak('La balance est équilibrée!');
    }

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
      'Bravo! Tu es maintenant un expert des comparaisons mathématiques!',
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

  // Speak item description
  Future<void> speakItemDescription(MarketItem item) async {
    try {
      await flutterTts.speak(item.frenchName);
    } catch (e) {
      print('TTS speak item error: $e');
    }
  }

  // Speak level instructions
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
    correctComparisons.value = 0;
    totalComparisons.value = 0;
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
    // For comparison levels, progress is binary (complete/incomplete)
    // For interactive levels, progress is based on target achievement
    return completedLevels.contains(currentLevel.value) ? 1.0 : 0.0;
  }

  // Get overall game progress
  double getOverallProgress() {
    return completedLevels.length / maxLevel;
  }

  // Get comparison symbol for display
  String getComparisonSymbol() {
    return MarketBalanceData.getComparisonSymbol(scaleState.value.comparison);
  }

  // Check if can drop item on side
  bool canDropItemOnSide(ScaleSide side) {
    final levelData = currentLevelData.value;
    if (levelData == null) return false;

    final currentState = scaleState.value;
    final sideItems =
        side == ScaleSide.left
            ? currentState.leftItems
            : currentState.rightItems;

    // Check max items per side
    return sideItems.length < levelData.maxItemsPerSide;
  }

  // Get items on specific side
  List<MarketItem> getItemsOnSide(ScaleSide side) {
    final currentState = scaleState.value;
    return side == ScaleSide.left
        ? currentState.leftItems
        : currentState.rightItems;
  }

  // Check if level allows interaction
  bool get isInteractive {
    final levelData = currentLevelData.value;
    return levelData?.type == LevelType.makeEqual ||
        levelData?.type == LevelType.numberVsObject;
  }

  // Get accuracy percentage
  double getAccuracyPercentage() {
    if (totalComparisons.value == 0) return 0.0;
    return correctComparisons.value / totalComparisons.value;
  }

  // Manual comparison check (for non-interactive levels)
  Future<void> checkComparison(ComparisonType userChoice) async {
    final correctComparison = scaleState.value.comparison;

    if (userChoice == correctComparison) {
      correctComparisons.value++;
      await flutterTts.speak('Correct!');
      await _handleLevelComplete();
    } else {
      await flutterTts.speak('Essaie encore!');
      await _speakCurrentComparison();
    }

    totalComparisons.value++;
  }
}
