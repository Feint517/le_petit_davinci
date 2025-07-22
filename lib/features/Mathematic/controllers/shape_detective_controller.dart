// lib/features/Mathematic/controllers/shape_detective_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/Mathematic/models/shape_detective_model.dart';

class ShapeDetectiveController extends GetxController {
  // Observable variables
  final currentLevel = 1.obs;
  final currentSceneId = ''.obs;
  final exploredScenes = <DetectiveScene>[].obs;
  final completedLevels = <int>[].obs;
  final isLoading = false.obs;
  final showCelebration = false.obs;
  final showLevelComplete = false.obs;
  final showShapeDiscovery = false.obs;
  final animationTrigger = 0.obs;

  // Current level data
  final currentLevelData = Rxn<DetectiveLevel>();
  final currentScene = Rxn<DetectiveScene>();

  // Discovery tracking
  final totalShapesFound = 0.obs;
  final totalPoints = 0.obs;
  final recentlyFoundShape = Rxn<HiddenShape>();
  final shapeTypeCount = <DetectiveShape, int>{}.obs;

  // Hints and feedback
  final showHintOverlay = false.obs;
  final currentHint = ''.obs;
  final explorationMessage = ''.obs;

  // Visual effects
  final foundShapePositions = <Offset>[].obs;
  final shapeRipples = <MapEntry<Offset, DateTime>>[].obs;

  // Non-reactive variables
  final FlutterTts flutterTts = FlutterTts();
  final int maxLevel = ShapeDetectiveData.totalLevels;
  final GlobalKey sceneKey = GlobalKey();

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
      currentLevelData.value = ShapeDetectiveData.getLevelData(
        currentLevel.value,
      );
      final levelData = currentLevelData.value!;

      // Initialize scenes with empty found states
      exploredScenes.value =
          levelData.scenes.map((scene) {
            return scene.copyWith(
              hiddenShapes:
                  scene.hiddenShapes
                      .map((shape) => shape.copyWith(isFound: false))
                      .toList(),
            );
          }).toList();

      // Set first scene as current
      if (exploredScenes.isNotEmpty) {
        currentSceneId.value = exploredScenes.first.id;
        currentScene.value = exploredScenes.first;
      }

      // Reset tracking
      totalShapesFound.value = 0;
      totalPoints.value = 0;
      shapeTypeCount.clear();
      foundShapePositions.clear();
      shapeRipples.clear();

      // Update exploration message
      _updateExplorationMessage();
    } catch (e) {
      print('Error initializing level: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Handle screen tap for shape detection
  Future<void> onScreenTap(Offset globalPosition) async {
    final scene = currentScene.value;
    if (scene == null) return;

    // Convert global position to local scene coordinates
    final RenderBox? renderBox =
        sceneKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final localPosition = renderBox.globalToLocal(globalPosition);
    final sceneSize = renderBox.size;

    // Convert to percentage-based coordinates (0.0 to 1.0)
    final relativePosition = Offset(
      localPosition.dx / sceneSize.width,
      localPosition.dy / sceneSize.height,
    );

    // Check if tap hits any hidden shape
    for (final shape in scene.hiddenShapes) {
      if (shape.isFound) continue; // Skip already found shapes

      if (_isPositionWithinShape(relativePosition, shape, sceneSize)) {
        await _handleShapeDiscovered(shape, localPosition);
        return;
      }
    }

    // No shape found - provide encouragement
    await _handleMissedTap(localPosition);
  }

  // Check if tap position is within shape bounds
  bool _isPositionWithinShape(
    Offset relativePosition,
    HiddenShape shape,
    Size sceneSize,
  ) {
    // Convert shape position and size to screen coordinates
    final shapeCenter = Offset(
      shape.position.dx * sceneSize.width,
      shape.position.dy * sceneSize.height,
    );

    final tapCenter = Offset(
      relativePosition.dx * sceneSize.width,
      relativePosition.dy * sceneSize.height,
    );

    // Check if tap is within shape bounds (using a rectangular hit area)
    final distance = (tapCenter - shapeCenter).distance;
    final maxDistance =
        (shape.size.width + shape.size.height) / 4; // Average radius

    return distance <= maxDistance;
  }

  // Handle successful shape discovery
  Future<void> _handleShapeDiscovered(
    HiddenShape shape,
    Offset screenPosition,
  ) async {
    try {
      // Mark shape as found in current scene
      final sceneIndex = exploredScenes.indexWhere(
        (s) => s.id == currentScene.value!.id,
      );
      if (sceneIndex == -1) return;

      final updatedScene = exploredScenes[sceneIndex];
      final shapeIndex = updatedScene.hiddenShapes.indexWhere(
        (s) => s.id == shape.id,
      );
      if (shapeIndex == -1) return;

      // Create updated shape and scene
      final foundShape = shape.copyWith(isFound: true);
      final newShapes = List<HiddenShape>.from(updatedScene.hiddenShapes);
      newShapes[shapeIndex] = foundShape;

      final newScene = updatedScene.copyWith(hiddenShapes: newShapes);

      // Update scenes list
      final newScenes = List<DetectiveScene>.from(exploredScenes);
      newScenes[sceneIndex] = newScene;
      exploredScenes.value = newScenes;

      // Update current scene reference
      currentScene.value = newScene;

      // Update tracking
      totalShapesFound.value++;
      totalPoints.value += shape.points;
      shapeTypeCount[shape.shapeType] =
          (shapeTypeCount[shape.shapeType] ?? 0) + 1;
      recentlyFoundShape.value = foundShape;

      // Visual effects
      foundShapePositions.add(screenPosition);
      shapeRipples.add(MapEntry(screenPosition, DateTime.now()));

      // Trigger animations
      animationTrigger.value++;
      showShapeDiscovery.value = true;

      // Speak discovery feedback
      await _speakDiscoveryFeedback(foundShape);

      // Hide discovery animation after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        showShapeDiscovery.value = false;
      });

      // Update exploration message
      _updateExplorationMessage();

      // Check level completion
      await _checkLevelCompletion();
    } catch (e) {
      print('Error handling shape discovery: $e');
    }
  }

  // Handle missed tap
  Future<void> _handleMissedTap(Offset position) async {
    // Add small ripple effect for missed taps
    shapeRipples.add(MapEntry(position, DateTime.now()));

    // Provide encouraging feedback occasionally
    if (DateTime.now().millisecond % 3 == 0) {
      final encouragements = [
        'Continue à chercher!',
        'Les formes sont cachées partout!',
        'Regarde bien les objets!',
      ];
      final message =
          encouragements[DateTime.now().millisecond % encouragements.length];
      await flutterTts.speak(message);
    }
  }

  // Speak discovery feedback
  Future<void> _speakDiscoveryFeedback(HiddenShape shape) async {
    try {
      final feedback = ShapeDetectiveData.getDiscoveryFeedback(shape);
      await flutterTts.speak(feedback);
    } catch (e) {
      print('TTS discovery feedback error: $e');
    }
  }

  // Update exploration message
  void _updateExplorationMessage() {
    final levelData = currentLevelData.value;
    if (levelData == null) return;

    final message = ShapeDetectiveData.getExplorationMessage(
      totalShapesFound.value,
      levelData.requiredFinds,
    );
    explorationMessage.value = message;
  }

  // Check level completion
  Future<void> _checkLevelCompletion() async {
    final levelData = currentLevelData.value;
    if (levelData == null) return;

    if (totalShapesFound.value >= levelData.requiredFinds) {
      await _handleLevelComplete();
    }
  }

  // Handle level completion
  Future<void> _handleLevelComplete() async {
    completedLevels.add(currentLevel.value);
    showLevelComplete.value = true;

    // Speak completion message
    final completionMessage = ShapeDetectiveData.getCompletionMessage(
      totalShapesFound.value,
      totalPoints.value,
    );
    await flutterTts.speak('Bravo! $completionMessage');

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
      'Fantastique! Tu es maintenant un maître détective des formes!',
    );

    // Hide celebration after 4 seconds
    await Future.delayed(const Duration(seconds: 4));
    showCelebration.value = false;
  }

  // Switch to different scene
  void switchScene(String sceneId) {
    final scene = exploredScenes.firstWhereOrNull((s) => s.id == sceneId);
    if (scene != null) {
      currentSceneId.value = sceneId;
      currentScene.value = scene;
    }
  }

  // Provide hint for next shape
  Future<void> provideHint() async {
    final scene = currentScene.value;
    final levelData = currentLevelData.value;

    if (scene == null || levelData == null || !levelData.allowsHints) {
      await flutterTts.speak('Pas d\'indices disponibles pour ce niveau!');
      return;
    }

    // Find next unfound shape
    final unfoundShapes = scene.getRemainingShapes();
    if (unfoundShapes.isEmpty) {
      await flutterTts.speak(
        'Toutes les formes de cette scène ont été trouvées!',
      );
      return;
    }

    // Give hint for first unfound shape
    final nextShape = unfoundShapes.first;
    currentHint.value = nextShape.hint;
    showHintOverlay.value = true;

    await flutterTts.speak('Indice: ${nextShape.hint}');

    // Hide hint after 4 seconds
    await Future.delayed(const Duration(seconds: 4));
    showHintOverlay.value = false;
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

  // Speak exploration message
  Future<void> speakExplorationMessage() async {
    try {
      await flutterTts.speak(explorationMessage.value);
    } catch (e) {
      print('TTS speak exploration error: $e');
    }
  }

  // Speak current scene description
  Future<void> speakSceneDescription() async {
    final scene = currentScene.value;
    if (scene == null) return;

    try {
      await flutterTts.speak(scene.description);
    } catch (e) {
      print('TTS speak scene error: $e');
    }
  }

  // Get progress statistics
  Map<String, dynamic> getProgressStats() {
    final scene = currentScene.value;
    return {
      'totalFound': totalShapesFound.value,
      'totalPoints': totalPoints.value,
      'currentSceneProgress': scene?.completionPercentage ?? 0.0,
      'shapesInCurrentScene': scene?.foundShapesCount ?? 0,
      'totalShapesInScene': scene?.totalShapesCount ?? 0,
    };
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

  // Get available scenes for current level
  List<DetectiveScene> getAvailableScenes() {
    return exploredScenes.toList();
  }

  // Get progress percentage for current level
  double getCurrentLevelProgress() {
    final levelData = currentLevelData.value;
    if (levelData == null) return 0.0;

    return (totalShapesFound.value / levelData.requiredFinds).clamp(0.0, 1.0);
  }

  // Get overall game progress
  double getOverallProgress() {
    return completedLevels.length / maxLevel;
  }

  // Get shapes found by type
  Map<DetectiveShape, int> getShapesFoundByType() {
    return Map.from(shapeTypeCount);
  }

  // Get current scene completion
  double getCurrentSceneCompletion() {
    return currentScene.value?.completionPercentage ?? 0.0;
  }

  // Check if current scene is complete
  bool isCurrentSceneComplete() {
    return currentScene.value?.isComplete ?? false;
  }

  // Get remaining shapes count
  int getRemainingShapesCount() {
    final levelData = currentLevelData.value;
    if (levelData == null) return 0;

    return (levelData.requiredFinds - totalShapesFound.value).clamp(
      0,
      levelData.requiredFinds,
    );
  }

  // Get detective rank
  String getDetectiveRank() {
    return ShapeDetectiveData.getCompletionMessage(
      totalShapesFound.value,
      totalPoints.value,
    );
  }

  // Get shape discovery positions for visual effects
  List<Offset> getFoundShapePositions() {
    return foundShapePositions.toList();
  }

  // Get active ripple effects
  List<MapEntry<Offset, DateTime>> getActiveRipples() {
    final now = DateTime.now();
    // Remove ripples older than 2 seconds
    shapeRipples.removeWhere(
      (entry) => now.difference(entry.value).inSeconds > 2,
    );
    return shapeRipples.toList();
  }

  // Check if hints are allowed for current level
  bool get hintsAllowed {
    return currentLevelData.value?.allowsHints ?? false;
  }

  // Get target shape for current level (if any)
  DetectiveShape? get targetShapeType {
    return currentLevelData.value?.targetShape;
  }

  // Get exploration feedback message
  String getExplorationFeedback() {
    return explorationMessage.value;
  }
}
