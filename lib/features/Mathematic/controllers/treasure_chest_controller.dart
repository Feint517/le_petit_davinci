// lib/features/Mathematic/controllers/treasure_chest_controller.dart

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/Mathematic/models/treasure_chest_model.dart';

class TreasureChestController extends GetxController {
  // Observable variables
  final currentLevel = 1.obs;
  final treasureChest =
      TreasureChest(
        id: '',
        targetAmount: 0,
        currentAmount: 0,
        state: ChestState.closed,
        containedItems: [],
        title: '',
        frenchTitle: '',
      ).obs;

  final availableItems = <TreasureItem>[].obs;
  final discoveredBonds = <NumberBond>[].obs;
  final completedLevels = <int>[].obs;
  final isLoading = false.obs;
  final showCelebration = false.obs;
  final showLevelComplete = false.obs;
  final isDraggingItem = false.obs;
  final animationTrigger = 0.obs;
  final draggedItem = Rxn<TreasureItem>();

  // Current level data
  final currentLevelData = Rxn<TreasureLevel>();
  final currentTargetNumbers = <int>[].obs; // For level 4 cycling
  final currentTargetIndex = 0.obs;

  // Special states
  final showEquation = false.obs;
  final currentEquation = ''.obs;
  final showTreasureMap = false.obs;
  final mapPieces = 0.obs;

  // Non-reactive variables
  final FlutterTts flutterTts = FlutterTts();
  final int maxLevel = TreasureChestData.totalLevels;

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
      currentLevelData.value = TreasureChestData.getLevelData(
        currentLevel.value,
      );
      final levelData = currentLevelData.value!;

      // Set initial chest state
      treasureChest.value = levelData.initialChest;

      // Set available items
      availableItems.value = List.from(levelData.availableItems);

      // Level-specific initialization
      switch (levelData.type) {
        case LevelType.visualMake10:
          showEquation.value = false;
          showTreasureMap.value = false;
          break;

        case LevelType.numberBonds:
          showEquation.value = true;
          showTreasureMap.value = false;
          _updateEquation();
          break;

        case LevelType.discoverAll:
          showEquation.value = false;
          showTreasureMap.value = true;
          mapPieces.value = 0;
          discoveredBonds.clear();
          break;

        case LevelType.otherTargets:
          showEquation.value = false;
          showTreasureMap.value = false;
          currentTargetNumbers.value = [8, 9, 12];
          currentTargetIndex.value = 0;
          _updateTargetNumber();
          break;
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

  // Update equation display for number bonds level
  void _updateEquation() {
    final chest = treasureChest.value;
    final target = chest.targetAmount;
    final current = chest.currentAmount;
    final needed = target - current;

    currentEquation.value = '$current + ? = $target';
  }

  // Update target number for level 4
  void _updateTargetNumber() {
    final targetNumber = currentTargetNumbers[currentTargetIndex.value];
    final currentChest = treasureChest.value;

    treasureChest.value = currentChest.copyWith(
      targetAmount: targetNumber,
      currentAmount: 0,
      containedItems: [],
      state: ChestState.closed,
    );
  }

  // Handle item drag start
  void onItemDragStart(TreasureItem item) {
    isDraggingItem.value = true;
    draggedItem.value = item;
  }

  // Handle item drop on treasure chest
  Future<void> dropItemInChest(TreasureItem item) async {
    try {
      final currentChest = treasureChest.value;

      // Check if chest is already full or overfull
      if (currentChest.currentAmount >= currentChest.targetAmount) {
        await _handleChestFull();
        return;
      }

      // Remove item from available items
      availableItems.remove(item);

      // Add item to chest
      final newItems = List<TreasureItem>.from(currentChest.containedItems);
      newItems.add(item);
      final newAmount = newItems.length;

      // Calculate new chest state
      final newState = TreasureChestData.calculateChestState(
        newAmount,
        currentChest.targetAmount,
      );

      // Update chest
      treasureChest.value = currentChest.copyWith(
        currentAmount: newAmount,
        containedItems: newItems,
        state: newState,
      );

      // Update equation if needed
      if (showEquation.value) {
        _updateEquation();
      }

      // Trigger animation
      animationTrigger.value++;

      // Handle item placement
      await _handleItemPlaced(item);

      // Check for completion
      if (newAmount == currentChest.targetAmount) {
        await _handleChestCompleted();
      }
    } catch (e) {
      print('Error dropping item in chest: $e');
    } finally {
      isDraggingItem.value = false;
      draggedItem.value = null;
    }
  }

  // Handle item placement feedback
  Future<void> _handleItemPlaced(TreasureItem item) async {
    final chest = treasureChest.value;

    // Speak item name
    await flutterTts.speak(item.frenchName);

    // Give progress feedback
    if (chest.isNearTarget) {
      await flutterTts.speak('Presque!');
    } else if (chest.currentAmount < chest.targetAmount) {
      final remaining = chest.remainingSpace;
      await speakNumber(remaining);
      await flutterTts.speak(remaining == 1 ? 'encore un!' : 'encore!');
    }
  }

  // Handle chest full error
  Future<void> _handleChestFull() async {
    await flutterTts.speak('Le coffre est plein!');
  }

  // Handle chest completion
  Future<void> _handleChestCompleted() async {
    final chest = treasureChest.value;
    final levelData = currentLevelData.value!;

    // Update chest state to opened with sparkles
    treasureChest.value = chest.copyWith(state: ChestState.sparkling);

    // Create number bond for this completion
    final currentBond = _createCurrentBond();

    // Handle different level types
    switch (levelData.type) {
      case LevelType.visualMake10:
      case LevelType.numberBonds:
        await _handleSingleBondCompletion(currentBond);
        break;

      case LevelType.discoverAll:
        await _handleBondDiscovery(currentBond);
        break;

      case LevelType.otherTargets:
        await _handleTargetCompletion(currentBond);
        break;
    }
  }

  // Create number bond for current chest state
  NumberBond _createCurrentBond() {
    final chest = treasureChest.value;
    final levelData = currentLevelData.value!;

    // For pre-filled chests, calculate the bond differently
    if (levelData.type == LevelType.visualMake10 ||
        levelData.type == LevelType.numberBonds) {
      final initialAmount = levelData.initialChest.currentAmount;
      final addedAmount = chest.currentAmount - initialAmount;
      return NumberBond(
        firstNumber: initialAmount,
        secondNumber: addedAmount,
        target: chest.targetAmount,
        isDiscovered: true,
      );
    }

    // For empty chests, all items were added
    return NumberBond(
      firstNumber: 0,
      secondNumber: chest.currentAmount,
      target: chest.targetAmount,
      isDiscovered: true,
    );
  }

  // Handle single bond completion (levels 1-2)
  Future<void> _handleSingleBondCompletion(NumberBond bond) async {
    // Speak completion message
    final message = TreasureChestData.getCompletionMessage(
      bond.target,
      bond.firstNumber,
      bond.secondNumber,
    );
    await flutterTts.speak('Parfait! $message');

    // Complete level
    await _completCurrentLevel();
  }

  // Handle bond discovery (level 3)
  Future<void> _handleBondDiscovery(NumberBond bond) async {
    // Check if this bond is new
    final existingBond = discoveredBonds.firstWhereOrNull(
      (b) =>
          (b.firstNumber == bond.firstNumber &&
              b.secondNumber == bond.secondNumber) ||
          (b.firstNumber == bond.secondNumber &&
              b.secondNumber == bond.firstNumber),
    );

    if (existingBond == null) {
      // New discovery!
      discoveredBonds.add(bond);
      mapPieces.value++;

      // Speak discovery
      final message = TreasureChestData.getCompletionMessage(
        bond.target,
        bond.firstNumber,
        bond.secondNumber,
      );
      await flutterTts.speak('Nouvelle combinaison! $message');

      // Check if all bonds discovered
      final levelData = currentLevelData.value!;
      if (discoveredBonds.length >= levelData.targetBonds.length) {
        await flutterTts.speak('Toutes les combinaisons trouvées!');
        await _completCurrentLevel();
      } else {
        // Reset chest for next combination
        await _resetChestForNextTry();
      }
    } else {
      // Already discovered
      await flutterTts.speak('Déjà trouvée! Essaie une autre combinaison.');
      await _resetChestForNextTry();
    }
  }

  // Handle target completion (level 4)
  Future<void> _handleTargetCompletion(NumberBond bond) async {
    // Speak completion
    final message = TreasureChestData.getCompletionMessage(
      bond.target,
      bond.firstNumber,
      bond.secondNumber,
    );
    await flutterTts.speak('Excellent! $message');

    // Move to next target or complete level
    if (currentTargetIndex.value < currentTargetNumbers.length - 1) {
      currentTargetIndex.value++;
      await flutterTts.speak('Nouveau défi!');
      _updateTargetNumber();
    } else {
      await _completCurrentLevel();
    }
  }

  // Reset chest for next attempt
  Future<void> _resetChestForNextTry() async {
    final currentChest = treasureChest.value;

    // Return items to available pool
    availableItems.addAll(currentChest.containedItems);

    // Reset chest
    treasureChest.value = currentChest.copyWith(
      currentAmount: 0,
      containedItems: [],
      state: ChestState.closed,
    );

    // Small delay for visual effect
    await Future.delayed(const Duration(seconds: 1));
  }

  // Complete current level
  Future<void> _completCurrentLevel() async {
    completedLevels.add(currentLevel.value);
    showLevelComplete.value = true;

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
      'Incroyable! Tu es maintenant un maître des combinaisons de nombres!',
    );

    // Hide celebration after 4 seconds
    await Future.delayed(const Duration(seconds: 4));
    showCelebration.value = false;
  }

  // Speak number in French
  Future<void> speakNumber(int number) async {
    try {
      final frenchNumber = TreasureChestData.getFrenchNumber(number);
      await flutterTts.speak(frenchNumber);
    } catch (e) {
      print('TTS speak number error: $e');
    }
  }

  // Speak item description
  Future<void> speakItemDescription(TreasureItem item) async {
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

  // Speak current equation
  Future<void> speakEquation() async {
    if (!showEquation.value) return;

    try {
      final chest = treasureChest.value;
      final current = chest.currentAmount;
      final target = chest.targetAmount;
      final needed = target - current;

      await speakNumber(current);
      await flutterTts.speak('plus');
      await speakNumber(needed);
      await flutterTts.speak('égale');
      await speakNumber(target);
    } catch (e) {
      print('TTS speak equation error: $e');
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
    discoveredBonds.clear();
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

    switch (levelData.type) {
      case LevelType.visualMake10:
      case LevelType.numberBonds:
        return treasureChest.value.fillPercentage;

      case LevelType.discoverAll:
        if (levelData.targetBonds.isEmpty) return 0.0;
        return discoveredBonds.length / levelData.targetBonds.length;

      case LevelType.otherTargets:
        final totalTargets = currentTargetNumbers.length;
        if (totalTargets == 0) return 0.0;
        final completedTargets =
            currentTargetIndex.value + (treasureChest.value.isFull ? 1 : 0);
        return completedTargets / totalTargets;
    }
  }

  // Get overall game progress
  double getOverallProgress() {
    return completedLevels.length / maxLevel;
  }

  // Check if can drop item in chest
  bool canDropItemInChest() {
    return !treasureChest.value.isFull;
  }

  // Get chest glow intensity
  double getChestGlowIntensity() {
    final chest = treasureChest.value;

    switch (chest.state) {
      case ChestState.closed:
        return 0.0;
      case ChestState.glowing:
        return 0.7;
      case ChestState.opening:
      case ChestState.opened:
        return 1.0;
      case ChestState.sparkling:
        return 1.0;
    }
  }

  // Check if level allows multiple attempts
  bool get allowsMultipleAttempts {
    final levelData = currentLevelData.value;
    return levelData?.type == LevelType.discoverAll ||
        levelData?.type == LevelType.otherTargets;
  }

  // Get discovered bonds for display
  List<NumberBond> getDiscoveredBonds() {
    return discoveredBonds.toList();
  }

  // Get remaining bonds to discover
  List<NumberBond> getRemainingBonds() {
    final levelData = currentLevelData.value;
    if (levelData == null) return [];

    return levelData.targetBonds.where((bond) {
      return !discoveredBonds.any(
        (discovered) =>
            (discovered.firstNumber == bond.firstNumber &&
                discovered.secondNumber == bond.secondNumber) ||
            (discovered.firstNumber == bond.secondNumber &&
                discovered.secondNumber == bond.firstNumber),
      );
    }).toList();
  }

  // Get current target number for display
  int getCurrentTargetNumber() {
    return treasureChest.value.targetAmount;
  }

  // Get treasure map completion percentage
  double getTreasureMapProgress() {
    final levelData = currentLevelData.value;
    if (levelData?.type != LevelType.discoverAll) return 0.0;

    final totalPieces = levelData!.targetBonds.length;
    return totalPieces == 0 ? 0.0 : mapPieces.value / totalPieces;
  }
}
