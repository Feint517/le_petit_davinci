// lib/features/Mathematic/models/shape_detective_model.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum DetectiveShape { circle, square, rectangle, triangle, oval, diamond }

enum SceneType { bedroom, kitchen, playground, city }

class HiddenShape {
  final String id;
  final DetectiveShape shapeType;
  final String objectName;
  final String frenchObjectName;
  final String hint;
  final Offset position; // Position on screen (percentage-based)
  final Size size; // Size of the tappable area
  final String emoji;
  final bool isFound;
  final int points;

  const HiddenShape({
    required this.id,
    required this.shapeType,
    required this.objectName,
    required this.frenchObjectName,
    required this.hint,
    required this.position,
    required this.size,
    required this.emoji,
    this.isFound = false,
    this.points = 10,
  });

  HiddenShape copyWith({
    String? id,
    DetectiveShape? shapeType,
    String? objectName,
    String? frenchObjectName,
    String? hint,
    Offset? position,
    Size? size,
    String? emoji,
    bool? isFound,
    int? points,
  }) {
    return HiddenShape(
      id: id ?? this.id,
      shapeType: shapeType ?? this.shapeType,
      objectName: objectName ?? this.objectName,
      frenchObjectName: frenchObjectName ?? this.frenchObjectName,
      hint: hint ?? this.hint,
      position: position ?? this.position,
      size: size ?? this.size,
      emoji: emoji ?? this.emoji,
      isFound: isFound ?? this.isFound,
      points: points ?? this.points,
    );
  }

  String get frenchShapeName {
    switch (shapeType) {
      case DetectiveShape.circle:
        return 'cercle';
      case DetectiveShape.square:
        return 'carré';
      case DetectiveShape.rectangle:
        return 'rectangle';
      case DetectiveShape.triangle:
        return 'triangle';
      case DetectiveShape.oval:
        return 'ovale';
      case DetectiveShape.diamond:
        return 'losange';
    }
  }

  Color get shapeColor {
    switch (shapeType) {
      case DetectiveShape.circle:
        return Colors.red;
      case DetectiveShape.square:
        return Colors.blue;
      case DetectiveShape.rectangle:
        return Colors.green;
      case DetectiveShape.triangle:
        return Colors.orange;
      case DetectiveShape.oval:
        return Colors.purple;
      case DetectiveShape.diamond:
        return Colors.pink;
    }
  }
}

class DetectiveScene {
  final String id;
  final SceneType type;
  final String name;
  final String frenchName;
  final String description;
  final String backgroundAsset;
  final List<HiddenShape> hiddenShapes;
  final String emoji;
  final Color themeColor;

  const DetectiveScene({
    required this.id,
    required this.type,
    required this.name,
    required this.frenchName,
    required this.description,
    required this.backgroundAsset,
    required this.hiddenShapes,
    required this.emoji,
    required this.themeColor,
  });

  DetectiveScene copyWith({
    String? id,
    SceneType? type,
    String? name,
    String? frenchName,
    String? description,
    String? backgroundAsset,
    List<HiddenShape>? hiddenShapes,
    String? emoji,
    Color? themeColor,
  }) {
    return DetectiveScene(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      frenchName: frenchName ?? this.frenchName,
      description: description ?? this.description,
      backgroundAsset: backgroundAsset ?? this.backgroundAsset,
      hiddenShapes: hiddenShapes ?? this.hiddenShapes,
      emoji: emoji ?? this.emoji,
      themeColor: themeColor ?? this.themeColor,
    );
  }

  bool get isComplete {
    return hiddenShapes.every((shape) => shape.isFound);
  }

  int get foundShapesCount {
    return hiddenShapes.where((shape) => shape.isFound).length;
  }

  int get totalShapesCount {
    return hiddenShapes.length;
  }

  double get completionPercentage {
    if (totalShapesCount == 0) return 1.0;
    return foundShapesCount / totalShapesCount;
  }

  int get totalPoints {
    return hiddenShapes
        .where((shape) => shape.isFound)
        .fold(0, (sum, shape) => sum + shape.points);
  }

  List<HiddenShape> getShapesByType(DetectiveShape shapeType) {
    return hiddenShapes.where((shape) => shape.shapeType == shapeType).toList();
  }

  List<HiddenShape> getFoundShapes() {
    return hiddenShapes.where((shape) => shape.isFound).toList();
  }

  List<HiddenShape> getRemainingShapes() {
    return hiddenShapes.where((shape) => !shape.isFound).toList();
  }
}

class DetectiveLevel {
  final int level;
  final String title;
  final String frenchTitle;
  final String description;
  final String instruction;
  final List<DetectiveScene> scenes;
  final DetectiveShape?
  targetShape; // Specific shape to find, or null for all shapes
  final int requiredFinds;
  final bool allowsHints;

  const DetectiveLevel({
    required this.level,
    required this.title,
    required this.frenchTitle,
    required this.description,
    required this.instruction,
    required this.scenes,
    this.targetShape,
    required this.requiredFinds,
    this.allowsHints = true,
  });
}

class ShapeDetectiveData {
  // All available scenes
  static final List<DetectiveScene> allScenes = [
    // Bedroom Scene
    DetectiveScene(
      id: 'bedroom',
      type: SceneType.bedroom,
      name: 'Bedroom',
      frenchName: 'Chambre',
      description:
          'Trouve toutes les formes cachées dans cette chambre douillette!',
      backgroundAsset: 'bedroom_scene.svg', // Would be actual asset path
      emoji: '🛏️',
      themeColor: const Color(0xFFE1BEE7), // Light purple
      hiddenShapes: [
        // Clock - Circle
        HiddenShape(
          id: 'bedroom_clock',
          shapeType: DetectiveShape.circle,
          objectName: 'Clock',
          frenchObjectName: 'horloge',
          hint: 'L\'horloge murale a une forme ronde',
          position: Offset(0.8, 0.2), // Top right
          size: Size(60, 60),
          emoji: '🕐',
        ),

        // Bed - Rectangle
        HiddenShape(
          id: 'bedroom_bed',
          shapeType: DetectiveShape.rectangle,
          objectName: 'Bed',
          frenchObjectName: 'lit',
          hint: 'Le lit a une forme rectangulaire',
          position: Offset(0.5, 0.6), // Center
          size: Size(120, 80),
          emoji: '🛏️',
        ),

        // Picture frame - Square
        HiddenShape(
          id: 'bedroom_picture',
          shapeType: DetectiveShape.square,
          objectName: 'Picture Frame',
          frenchObjectName: 'cadre',
          hint: 'Le cadre photo est un carré parfait',
          position: Offset(0.2, 0.3), // Left side
          size: Size(50, 50),
          emoji: '🖼️',
        ),

        // Roof in picture - Triangle
        HiddenShape(
          id: 'bedroom_roof',
          shapeType: DetectiveShape.triangle,
          objectName: 'House Roof',
          frenchObjectName: 'toit de maison',
          hint: 'Dans l\'image, le toit de la maison est triangulaire',
          position: Offset(0.2, 0.25), // Inside the picture
          size: Size(30, 25),
          emoji: '🏠',
        ),

        // Mirror - Oval
        HiddenShape(
          id: 'bedroom_mirror',
          shapeType: DetectiveShape.oval,
          objectName: 'Mirror',
          frenchObjectName: 'miroir',
          hint: 'Le miroir de la commode est ovale',
          position: Offset(0.7, 0.4), // Right side
          size: Size(40, 60),
          emoji: '🪞',
        ),

        // Lamp buttons - Circles
        HiddenShape(
          id: 'bedroom_lamp_button',
          shapeType: DetectiveShape.circle,
          objectName: 'Lamp Button',
          frenchObjectName: 'bouton de lampe',
          hint: 'Le bouton de la lampe est un petit cercle',
          position: Offset(0.3, 0.5), // Bedside
          size: Size(20, 20),
          emoji: '💡',
        ),
      ],
    ),

    // Kitchen Scene
    DetectiveScene(
      id: 'kitchen',
      type: SceneType.kitchen,
      name: 'Kitchen',
      frenchName: 'Cuisine',
      description:
          'Explore la cuisine et découvre les formes dans les objets du quotidien!',
      backgroundAsset: 'kitchen_scene.svg',
      emoji: '🍳',
      themeColor: const Color(0xFFFFE082), // Light yellow
      hiddenShapes: [
        // Plates - Circles
        HiddenShape(
          id: 'kitchen_plate1',
          shapeType: DetectiveShape.circle,
          objectName: 'Plate',
          frenchObjectName: 'assiette',
          hint: 'Les assiettes sur l\'étagère sont rondes',
          position: Offset(0.2, 0.3),
          size: Size(40, 40),
          emoji: '🍽️',
        ),

        HiddenShape(
          id: 'kitchen_plate2',
          shapeType: DetectiveShape.circle,
          objectName: 'Plate',
          frenchObjectName: 'assiette',
          hint: 'Une autre assiette ronde',
          position: Offset(0.25, 0.35),
          size: Size(35, 35),
          emoji: '🍽️',
        ),

        // Window - Rectangle
        HiddenShape(
          id: 'kitchen_window',
          shapeType: DetectiveShape.rectangle,
          objectName: 'Window',
          frenchObjectName: 'fenêtre',
          hint: 'La fenêtre de la cuisine est rectangulaire',
          position: Offset(0.8, 0.25),
          size: Size(80, 100),
          emoji: '🪟',
        ),

        // Cutting board - Rectangle
        HiddenShape(
          id: 'kitchen_cutting_board',
          shapeType: DetectiveShape.rectangle,
          objectName: 'Cutting Board',
          frenchObjectName: 'planche à découper',
          hint: 'La planche à découper est rectangulaire',
          position: Offset(0.6, 0.6),
          size: Size(60, 40),
          emoji: '🔪',
        ),

        // Pizza slice - Triangle
        HiddenShape(
          id: 'kitchen_pizza',
          shapeType: DetectiveShape.triangle,
          objectName: 'Pizza Slice',
          frenchObjectName: 'part de pizza',
          hint: 'La part de pizza sur la table est triangulaire',
          position: Offset(0.4, 0.7),
          size: Size(50, 40),
          emoji: '🍕',
        ),

        // Refrigerator - Rectangle
        HiddenShape(
          id: 'kitchen_fridge',
          shapeType: DetectiveShape.rectangle,
          objectName: 'Refrigerator',
          frenchObjectName: 'réfrigérateur',
          hint: 'Le réfrigérateur a une forme rectangulaire',
          position: Offset(0.1, 0.5),
          size: Size(60, 120),
          emoji: '🧊',
        ),

        // Stove burner - Circle
        HiddenShape(
          id: 'kitchen_burner',
          shapeType: DetectiveShape.circle,
          objectName: 'Stove Burner',
          frenchObjectName: 'plaque de cuisson',
          hint: 'La plaque de cuisson est ronde',
          position: Offset(0.5, 0.5),
          size: Size(35, 35),
          emoji: '🔥',
        ),

        // Egg - Oval
        HiddenShape(
          id: 'kitchen_egg',
          shapeType: DetectiveShape.oval,
          objectName: 'Egg',
          frenchObjectName: 'œuf',
          hint: 'L\'œuf dans le panier est ovale',
          position: Offset(0.7, 0.8),
          size: Size(25, 35),
          emoji: '🥚',
        ),
      ],
    ),

    // Playground Scene
    DetectiveScene(
      id: 'playground',
      type: SceneType.playground,
      name: 'Playground',
      frenchName: 'Aire de Jeux',
      description: 'Amuse-toi à chercher des formes sur l\'aire de jeux!',
      backgroundAsset: 'playground_scene.svg',
      emoji: '🛝',
      themeColor: const Color(0xFFA5D6A7), // Light green
      hiddenShapes: [
        // Swing seats - Rectangles
        HiddenShape(
          id: 'playground_swing1',
          shapeType: DetectiveShape.rectangle,
          objectName: 'Swing Seat',
          frenchObjectName: 'siège de balançoire',
          hint: 'Le siège de la balançoire est rectangulaire',
          position: Offset(0.2, 0.6),
          size: Size(40, 20),
          emoji: '🏷️',
        ),

        HiddenShape(
          id: 'playground_swing2',
          shapeType: DetectiveShape.rectangle,
          objectName: 'Swing Seat',
          frenchObjectName: 'siège de balançoire',
          hint: 'Un autre siège rectangulaire',
          position: Offset(0.3, 0.6),
          size: Size(40, 20),
          emoji: '🏷️',
        ),

        // Slide triangle
        HiddenShape(
          id: 'playground_slide_roof',
          shapeType: DetectiveShape.triangle,
          objectName: 'Slide Roof',
          frenchObjectName: 'toit de toboggan',
          hint: 'Le toit du toboggan forme un triangle',
          position: Offset(0.7, 0.3),
          size: Size(60, 40),
          emoji: '🛝',
        ),

        // Sandbox - Square
        HiddenShape(
          id: 'playground_sandbox',
          shapeType: DetectiveShape.square,
          objectName: 'Sandbox',
          frenchObjectName: 'bac à sable',
          hint: 'Le bac à sable est un grand carré',
          position: Offset(0.5, 0.8),
          size: Size(80, 80),
          emoji: '🏖️',
        ),

        // Balls - Circles
        HiddenShape(
          id: 'playground_ball1',
          shapeType: DetectiveShape.circle,
          objectName: 'Ball',
          frenchObjectName: 'ballon',
          hint: 'Le ballon près du toboggan est rond',
          position: Offset(0.6, 0.7),
          size: Size(30, 30),
          emoji: '⚽',
        ),

        HiddenShape(
          id: 'playground_ball2',
          shapeType: DetectiveShape.circle,
          objectName: 'Ball',
          frenchObjectName: 'ballon',
          hint: 'Un autre ballon rond dans le bac à sable',
          position: Offset(0.45, 0.75),
          size: Size(25, 25),
          emoji: '🏀',
        ),

        // Monkey bars - Rectangles
        HiddenShape(
          id: 'playground_monkey_bar',
          shapeType: DetectiveShape.rectangle,
          objectName: 'Monkey Bar',
          frenchObjectName: 'barre de singe',
          hint: 'Les barres de singe sont rectangulaires',
          position: Offset(0.8, 0.4),
          size: Size(60, 15),
          emoji: '🐵',
        ),

        // Sun in sky - Circle
        HiddenShape(
          id: 'playground_sun',
          shapeType: DetectiveShape.circle,
          objectName: 'Sun',
          frenchObjectName: 'soleil',
          hint: 'Le soleil dans le ciel est un grand cercle',
          position: Offset(0.85, 0.15),
          size: Size(50, 50),
          emoji: '☀️',
        ),
      ],
    ),

    // City Scene
    DetectiveScene(
      id: 'city',
      type: SceneType.city,
      name: 'City',
      frenchName: 'Ville',
      description:
          'Explore la grande ville et trouve toutes les formes géométriques!',
      backgroundAsset: 'city_scene.svg',
      emoji: '🏙️',
      themeColor: const Color(0xFF90CAF9), // Light blue
      hiddenShapes: [
        // Building windows - Rectangles (multiple)
        HiddenShape(
          id: 'city_window1',
          shapeType: DetectiveShape.rectangle,
          objectName: 'Building Window',
          frenchObjectName: 'fenêtre d\'immeuble',
          hint: 'Les fenêtres des immeubles sont rectangulaires',
          position: Offset(0.15, 0.3),
          size: Size(20, 30),
          emoji: '🏢',
        ),

        HiddenShape(
          id: 'city_window2',
          shapeType: DetectiveShape.rectangle,
          objectName: 'Building Window',
          frenchObjectName: 'fenêtre d\'immeuble',
          hint: 'Une autre fenêtre rectangulaire',
          position: Offset(0.2, 0.3),
          size: Size(20, 30),
          emoji: '🏢',
        ),

        HiddenShape(
          id: 'city_window3',
          shapeType: DetectiveShape.rectangle,
          objectName: 'Building Window',
          frenchObjectName: 'fenêtre d\'immeuble',
          hint: 'Encore une fenêtre rectangulaire',
          position: Offset(0.25, 0.3),
          size: Size(20, 30),
          emoji: '🏢',
        ),

        // Car wheels - Circles
        HiddenShape(
          id: 'city_car_wheel1',
          shapeType: DetectiveShape.circle,
          objectName: 'Car Wheel',
          frenchObjectName: 'roue de voiture',
          hint: 'Les roues des voitures sont rondes',
          position: Offset(0.4, 0.8),
          size: Size(25, 25),
          emoji: '🚗',
        ),

        HiddenShape(
          id: 'city_car_wheel2',
          shapeType: DetectiveShape.circle,
          objectName: 'Car Wheel',
          frenchObjectName: 'roue de voiture',
          hint: 'L\'autre roue de la voiture',
          position: Offset(0.5, 0.8),
          size: Size(25, 25),
          emoji: '🚗',
        ),

        // Traffic light - Circles
        HiddenShape(
          id: 'city_traffic_light1',
          shapeType: DetectiveShape.circle,
          objectName: 'Traffic Light',
          frenchObjectName: 'feu de circulation',
          hint: 'Les feux de circulation sont ronds',
          position: Offset(0.7, 0.4),
          size: Size(20, 20),
          emoji: '🚦',
        ),

        HiddenShape(
          id: 'city_traffic_light2',
          shapeType: DetectiveShape.circle,
          objectName: 'Traffic Light',
          frenchObjectName: 'feu de circulation',
          hint: 'Un autre feu rond',
          position: Offset(0.7, 0.45),
          size: Size(20, 20),
          emoji: '🚦',
        ),

        // Street signs - Various shapes
        HiddenShape(
          id: 'city_stop_sign',
          shapeType: DetectiveShape.square,
          objectName: 'Stop Sign',
          frenchObjectName: 'panneau stop',
          hint: 'Le panneau stop est carré... ou presque!',
          position: Offset(0.6, 0.5),
          size: Size(30, 30),
          emoji: '🛑',
        ),

        // Building roof - Triangle
        HiddenShape(
          id: 'city_roof1',
          shapeType: DetectiveShape.triangle,
          objectName: 'Building Roof',
          frenchObjectName: 'toit d\'immeuble',
          hint: 'Ce toit d\'immeuble est triangulaire',
          position: Offset(0.8, 0.2),
          size: Size(60, 40),
          emoji: '🏠',
        ),

        HiddenShape(
          id: 'city_roof2',
          shapeType: DetectiveShape.triangle,
          objectName: 'Building Roof',
          frenchObjectName: 'toit d\'immeuble',
          hint: 'Un autre toit triangulaire',
          position: Offset(0.9, 0.25),
          size: Size(50, 35),
          emoji: '🏠',
        ),

        // Bus windows - Rectangles
        HiddenShape(
          id: 'city_bus_window',
          shapeType: DetectiveShape.rectangle,
          objectName: 'Bus Window',
          frenchObjectName: 'fenêtre de bus',
          hint: 'Les fenêtres du bus sont rectangulaires',
          position: Offset(0.35, 0.75),
          size: Size(40, 25),
          emoji: '🚌',
        ),
      ],
    ),
  ];

  // Level definitions
  static final List<DetectiveLevel> levels = [
    // Level 1: Bedroom - Find circles
    DetectiveLevel(
      level: 1,
      title: 'Bedroom Circles',
      frenchTitle: 'Cercles dans la Chambre',
      description:
          'Trouve tous les cercles cachés dans cette chambre douillette!',
      instruction: 'Tape sur tous les objets ronds que tu vois',
      scenes: [allScenes[0]], // Bedroom only
      targetShape: DetectiveShape.circle,
      requiredFinds: 2, // Find 2 circles to complete
    ),

    // Level 2: Kitchen Adventure - All shapes
    DetectiveLevel(
      level: 2,
      title: 'Kitchen Adventure',
      frenchTitle: 'Aventure en Cuisine',
      description:
          'Explore la cuisine et trouve toutes les formes géométriques!',
      instruction: 'Cherche toutes les formes dans la cuisine',
      scenes: [allScenes[1]], // Kitchen only
      targetShape: null, // All shapes
      requiredFinds: 6, // Find 6 shapes to complete
    ),

    // Level 3: Playground Hunt - Rectangles and circles
    DetectiveLevel(
      level: 3,
      title: 'Playground Hunt',
      frenchTitle: 'Chasse sur l\'Aire de Jeux',
      description:
          'Amuse-toi à chercher des rectangles et des cercles sur l\'aire de jeux!',
      instruction: 'Trouve les rectangles et les cercles',
      scenes: [allScenes[2]], // Playground only
      targetShape: null, // Rectangles and circles
      requiredFinds: 5, // Find 5 shapes to complete
    ),

    // Level 4: City Explorer - All scenes, all shapes
    DetectiveLevel(
      level: 4,
      title: 'City Explorer',
      frenchTitle: 'Explorateur de la Ville',
      description:
          'Deviens un vrai détective et explore tous les lieux pour trouver toutes les formes!',
      instruction: 'Explore tous les lieux et trouve toutes les formes',
      scenes: allScenes, // All scenes available
      targetShape: null, // All shapes
      requiredFinds: 15, // Find 15 shapes total to complete
      allowsHints: true,
    ),
  ];

  // Get level data
  static DetectiveLevel getLevelData(int level) {
    if (level < 1 || level > levels.length) {
      return levels[0];
    }
    return levels[level - 1];
  }

  // Get total number of levels
  static int get totalLevels => levels.length;

  // Get French shape name
  static String getShapeTypeFrenchName(DetectiveShape type) {
    switch (type) {
      case DetectiveShape.circle:
        return 'cercle';
      case DetectiveShape.square:
        return 'carré';
      case DetectiveShape.rectangle:
        return 'rectangle';
      case DetectiveShape.triangle:
        return 'triangle';
      case DetectiveShape.oval:
        return 'ovale';
      case DetectiveShape.diamond:
        return 'losange';
    }
  }

  // Get scene by ID
  static DetectiveScene? getSceneById(String id) {
    return allScenes.firstWhereOrNull((scene) => scene.id == id);
  }

  // Get exploration progress message
  static String getExplorationMessage(int foundShapes, int targetShapes) {
    final progress = foundShapes / targetShapes;

    if (progress < 0.2) {
      return 'Commence ton exploration!';
    } else if (progress < 0.5) {
      return 'Bon début, détective!';
    } else if (progress < 0.8) {
      return 'Tu es sur la bonne piste!';
    } else if (progress < 1.0) {
      return 'Presque terminé!';
    } else {
      return 'Mission accomplie!';
    }
  }

  // Get discovery feedback
  static String getDiscoveryFeedback(HiddenShape shape) {
    final responses = [
      'Excellent! Tu as trouvé ${shape.frenchObjectName}!',
      'Bravo! C\'est bien un ${shape.frenchShapeName}!',
      'Parfait! ${shape.frenchObjectName} découvert!',
      'Super détective! ${shape.frenchShapeName} trouvé!',
    ];

    return responses[DateTime.now().millisecond % responses.length];
  }

  // Get hint for shape
  static String getShapeHint(DetectiveShape shapeType, DetectiveScene scene) {
    final shapesOfType = scene.getShapesByType(shapeType);
    final unfoundShapes = shapesOfType.where((s) => !s.isFound).toList();

    if (unfoundShapes.isEmpty) {
      return 'Tous les ${getShapeTypeFrenchName(shapeType)}s ont été trouvés!';
    }

    return unfoundShapes.first.hint;
  }

  // Calculate total score
  static int calculateTotalScore(List<DetectiveScene> scenes) {
    return scenes.fold(0, (total, scene) => total + scene.totalPoints);
  }

  // Get completion certificate message
  static String getCompletionMessage(int totalFound, int totalPoints) {
    if (totalFound >= 20) {
      return 'Détective Expert! $totalFound formes trouvées!';
    } else if (totalFound >= 15) {
      return 'Super Détective! $totalFound découvertes!';
    } else if (totalFound >= 10) {
      return 'Bon Détective! $totalFound formes identifiées!';
    } else {
      return 'Détective Débutant! $totalFound formes trouvées!';
    }
  }
}

// Model for tracking detective progress
class DetectiveProgress {
  final int currentLevel;
  final int totalLevels;
  final bool isLevelCompleted;
  final bool isGameCompleted;
  final List<int> completedLevels;
  final List<DetectiveScene> exploredScenes;
  final int totalShapesFound;
  final int totalPoints;
  final Map<DetectiveShape, int> shapeTypeCount;

  const DetectiveProgress({
    required this.currentLevel,
    required this.totalLevels,
    required this.isLevelCompleted,
    required this.isGameCompleted,
    required this.completedLevels,
    required this.exploredScenes,
    required this.totalShapesFound,
    required this.totalPoints,
    required this.shapeTypeCount,
  });

  DetectiveProgress copyWith({
    int? currentLevel,
    int? totalLevels,
    bool? isLevelCompleted,
    bool? isGameCompleted,
    List<int>? completedLevels,
    List<DetectiveScene>? exploredScenes,
    int? totalShapesFound,
    int? totalPoints,
    Map<DetectiveShape, int>? shapeTypeCount,
  }) {
    return DetectiveProgress(
      currentLevel: currentLevel ?? this.currentLevel,
      totalLevels: totalLevels ?? this.totalLevels,
      isLevelCompleted: isLevelCompleted ?? this.isLevelCompleted,
      isGameCompleted: isGameCompleted ?? this.isGameCompleted,
      completedLevels: completedLevels ?? this.completedLevels,
      exploredScenes: exploredScenes ?? this.exploredScenes,
      totalShapesFound: totalShapesFound ?? this.totalShapesFound,
      totalPoints: totalPoints ?? this.totalPoints,
      shapeTypeCount: shapeTypeCount ?? this.shapeTypeCount,
    );
  }

  double get overallProgress {
    if (totalLevels == 0) return 0.0;
    return completedLevels.length / totalLevels;
  }

  double get currentSceneProgress {
    if (exploredScenes.isEmpty) return 0.0;
    final currentScene = exploredScenes.last;
    return currentScene.completionPercentage;
  }

  String get detectiveRank {
    return ShapeDetectiveData.getCompletionMessage(
      totalShapesFound,
      totalPoints,
    );
  }
}
