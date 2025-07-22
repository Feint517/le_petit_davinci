// lib/features/Mathematic/controllers/shape_architect_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/Mathematic/models/shape_architect_model.dart';

class ShapeArchitectController extends GetxController {
  // Observable variables
  final currentLevel = 1.obs;
  final availableShapes = <ArchitectShape>[].obs;
  final placedShapes = <PlacedShape>[].obs;
  final completedLevels = <int>[].obs;
  final isLoading = false.obs;
  final showCelebration = false.obs;
  final showLevelComplete = false.obs;
  final isDraggingShape = false.obs;
  final animationTrigger = 0.obs;
  final draggedShape = Rxn<ArchitectShape>();

  // Current level data
  final currentLevelData = Rxn<ArchitectLevel>();
  final currentBlueprintIndex = 0.obs;
  final completedBlueprints = <String>[].obs;

  // Construction feedback
  final constructionFeedback = ''.obs;
  final showConstructionHint = false.obs;
  final currentHint = ''.obs;

  // Special states
  final showBlueprintMode = true.obs;
  final selectedBlueprintId = Rxn<String>();

  // Non-reactive variables
  final FlutterTts flutterTts = FlutterTts();
  final int maxLevel = ShapeArchitectData.totalLevels;
  final GlobalKey canvasKey = GlobalKey();

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
      currentLevelData.value = ShapeArchitectData.getLevelData(
        currentLevel.value,
      );
      final levelData = currentLevelData.value!;

      // Set available shapes (with multiple copies)
      availableShapes.clear();
      for (final shape in levelData.availableShapes) {
        for (int i = 0; i < levelData.maxShapesPerType; i++) {
          availableShapes.add(shape.copyWith(id: '${shape.id}_$i'));
        }
      }

      // Clear construction
      placedShapes.clear();
      completedBlueprints.clear();

      // Set initial blueprint
      if (levelData.blueprintObjects.isNotEmpty) {
        selectedBlueprintId.value = levelData.blueprintObjects.first.id;
        showBlueprintMode.value = true;
      } else {
        // Free building mode
        showBlueprintMode.value = false;
        selectedBlueprintId.value = null;
      }

      // Reset states
      currentBlueprintIndex.value = 0;
      isDraggingShape.value = false;
      draggedShape.value = null;

      // Update feedback
      _updateConstructionFeedback();
    } catch (e) {
      print('Error initializing level: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Handle shape drag start
  void onShapeDragStart(ArchitectShape shape) {
    isDraggingShape.value = true;
    draggedShape.value = shape;
  }

  // Handle shape drop on canvas
  Future<void> dropShapeOnCanvas(ArchitectShape shape, Offset position) async {
    try {
      // Remove shape from available shapes
      availableShapes.remove(shape);

      // Create placed shape
      final placedShape = PlacedShape(
        shape: shape,
        position: position,
        placedTime: DateTime.now(),
        zIndex: placedShapes.length, // Layer order
      );

      // Add to construction
      placedShapes.add(placedShape);

      // Trigger animation
      animationTrigger.value++;

      // Speak shape name
      await speakShapeName(shape);

      // Update feedback
      _updateConstructionFeedback();

      // Check completion
      await _checkConstructionCompletion();
    } catch (e) {
      print('Error dropping shape: $e');
    } finally {
      isDraggingShape.value = false;
      draggedShape.value = null;
    }
  }

  // Update construction feedback
  void _updateConstructionFeedback() {
    final levelData = currentLevelData.value;
    if (levelData == null) return;

    final feedback = ShapeArchitectData.getConstructionFeedback(
      placedShapes,
      levelData.blueprintObjects,
    );
    constructionFeedback.value = feedback;
  }

  // Check construction completion
  Future<void> _checkConstructionCompletion() async {
    final levelData = currentLevelData.value;
    if (levelData == null) return;

    // Free building mode - complete after using several shapes
    if (levelData.allowsFreeBuilding) {
      if (placedShapes.length >= 8) {
        await _handleLevelComplete();
      }
      return;
    }

    // Blueprint mode - check if current blueprint is complete
    final currentBlueprint = getCurrentBlueprint();
    if (currentBlueprint != null && currentBlueprint.isComplete(placedShapes)) {
      await _handleBlueprintComplete(currentBlueprint);
    }
  }

  // Handle blueprint completion
  Future<void> _handleBlueprintComplete(BlueprintObject blueprint) async {
    completedBlueprints.add(blueprint.id);

    // Speak completion
    await flutterTts.speak('Parfait! ${blueprint.frenchName} terminé!');

    // Show completion animation
    animationTrigger.value++;

    // Check if more blueprints available
    final levelData = currentLevelData.value!;
    if (completedBlueprints.length >= levelData.blueprintObjects.length) {
      // Level complete
      await _handleLevelComplete();
    } else {
      // Move to next blueprint
      await _moveToNextBlueprint();
    }
  }

  // Move to next blueprint
  Future<void> _moveToNextBlueprint() async {
    final levelData = currentLevelData.value;
    if (levelData == null) return;

    final nextIndex = currentBlueprintIndex.value + 1;
    if (nextIndex < levelData.blueprintObjects.length) {
      currentBlueprintIndex.value = nextIndex;
      selectedBlueprintId.value = levelData.blueprintObjects[nextIndex].id;

      // Clear construction for next blueprint
      _clearConstruction();

      await flutterTts.speak('Nouveau défi!');
    }
  }

  // Handle level completion
  Future<void> _handleLevelComplete() async {
    completedLevels.add(currentLevel.value);
    showLevelComplete.value = true;

    // Speak completion message
    await flutterTts.speak('Bravo! Tu es un excellent architecte!');

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
      'Incroyable! Tu es maintenant un maître architecte des formes!',
    );

    // Hide celebration after 4 seconds
    await Future.delayed(const Duration(seconds: 4));
    showCelebration.value = false;
  }

  // Speak shape name
  Future<void> speakShapeName(ArchitectShape shape) async {
    try {
      await flutterTts.speak(shape.frenchName);
    } catch (e) {
      print('TTS speak shape error: $e');
    }
  }

  // Speak construction feedback
  Future<void> speakFeedback() async {
    try {
      await flutterTts.speak(constructionFeedback.value);
    } catch (e) {
      print('TTS speak feedback error: $e');
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

  // Show hint for current blueprint
  Future<void> showHint() async {
    final blueprint = getCurrentBlueprint();
    if (blueprint == null) return;

    // Find next required shape
    for (final requirement in blueprint.requirements) {
      if (requirement.isOptional) continue;

      final hasShape = placedShapes.any(
        (placedShape) =>
            placedShape.shape.type == requirement.shapeType &&
            _isWithinTolerance(
              placedShape.position,
              requirement.targetPosition,
              requirement.tolerance,
            ),
      );

      if (!hasShape) {
        currentHint.value = requirement.hint;
        showConstructionHint.value = true;
        await flutterTts.speak(requirement.hint);

        // Hide hint after 3 seconds
        await Future.delayed(const Duration(seconds: 3));
        showConstructionHint.value = false;
        break;
      }
    }
  }

  bool _isWithinTolerance(Offset position, Offset target, double tolerance) {
    final distance = (position - target).distance;
    return distance <= tolerance;
  }

  // Clear construction
  void _clearConstruction() {
    // Return shapes to available pool
    for (final placedShape in placedShapes) {
      availableShapes.add(placedShape.shape);
    }

    placedShapes.clear();
    _updateConstructionFeedback();
  }

  // Remove specific placed shape
  void removeShapeFromConstruction(PlacedShape placedShape) {
    placedShapes.remove(placedShape);
    availableShapes.add(placedShape.shape);

    animationTrigger.value++;
    _updateConstructionFeedback();
  }

  // Select different blueprint
  void selectBlueprint(String blueprintId) {
    final levelData = currentLevelData.value;
    if (levelData == null) return;

    final blueprintIndex = levelData.blueprintObjects.indexWhere(
      (b) => b.id == blueprintId,
    );
    if (blueprintIndex != -1) {
      selectedBlueprintId.value = blueprintId;
      currentBlueprintIndex.value = blueprintIndex;
      _clearConstruction();
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

  // Get current blueprint
  BlueprintObject? getCurrentBlueprint() {
    final levelData = currentLevelData.value;
    final blueprintId = selectedBlueprintId.value;

    if (levelData == null || blueprintId == null) return null;

    return levelData.blueprintObjects.firstWhereOrNull(
      (b) => b.id == blueprintId,
    );
  }

  // Get available blueprints
  List<BlueprintObject> getAvailableBlueprints() {
    return currentLevelData.value?.blueprintObjects ?? [];
  }

  // Get progress percentage for current level
  double getCurrentLevelProgress() {
    final levelData = currentLevelData.value;
    if (levelData == null) return 0.0;

    if (levelData.allowsFreeBuilding) {
      return (placedShapes.length / 8).clamp(0.0, 1.0);
    }

    return ShapeArchitectData.calculateConstructionProgress(
      placedShapes,
      levelData.blueprintObjects,
    );
  }

  // Get overall game progress
  double getOverallProgress() {
    return completedLevels.length / maxLevel;
  }

  // Check if can drop shape at position
  bool canDropShape(Offset position) {
    // Always allow dropping in free building mode
    final levelData = currentLevelData.value;
    if (levelData?.allowsFreeBuilding == true) return true;

    // In blueprint mode, check canvas bounds
    return _isWithinCanvasBounds(position);
  }

  bool _isWithinCanvasBounds(Offset position) {
    final blueprint = getCurrentBlueprint();
    if (blueprint == null) return true;

    return position.dx >= 0 &&
        position.dy >= 0 &&
        position.dx <= blueprint.canvasSize.width &&
        position.dy <= blueprint.canvasSize.height;
  }

  // Get shapes count by type
  Map<BuildingShape, int> getShapeCountByType() {
    final counts = <BuildingShape, int>{};

    for (final shape in availableShapes) {
      counts[shape.type] = (counts[shape.type] ?? 0) + 1;
    }

    return counts;
  }

  // Get construction statistics
  Map<String, dynamic> getConstructionStats() {
    return {
      'shapesUsed': placedShapes.length,
      'shapesAvailable': availableShapes.length,
      'blueprintsCompleted': completedBlueprints.length,
      'constructionTime':
          placedShapes.isEmpty
              ? 0
              : DateTime.now()
                  .difference(placedShapes.first.placedTime)
                  .inSeconds,
    };
  }

  // Check if blueprint is completed
  bool isBlueprintCompleted(String blueprintId) {
    return completedBlueprints.contains(blueprintId);
  }

  // Get blueprint completion percentage
  double getBlueprintProgress(BlueprintObject blueprint) {
    return blueprint.getCompletionPercentage(placedShapes) / 100.0;
  }

  // Toggle blueprint mode
  void toggleBlueprintMode() {
    showBlueprintMode.value = !showBlueprintMode.value;
  }

  // Get canvas size for current blueprint
  Size getCanvasSize() {
    final blueprint = getCurrentBlueprint();
    return blueprint?.canvasSize ?? const Size(350, 300);
  }

  // Check if level allows free building
  bool get isFreeBuildingMode {
    return currentLevelData.value?.allowsFreeBuilding == true;
  }

  // Get current feedback message
  String getCurrentFeedback() {
    return constructionFeedback.value;
  }
}
