// lib/features/Mathematic/models/shape_architect_model.dart

import 'package:flutter/material.dart';

enum BuildingShape {
  circle,
  square,
  rectangle,
  triangle,
  oval,
  diamond,
  semicircle,
}

enum BuildingObjectType {
  house,
  car,
  truck,
  bicycle,
  cat,
  dog,
  person,
  tree,
  flower,
  robot,
  castle,
  spaceship,
}

class ArchitectShape {
  final String id;
  final BuildingShape type;
  final String frenchName;
  final String emoji;
  final Color color;
  final double width;
  final double height;

  const ArchitectShape({
    required this.id,
    required this.type,
    required this.frenchName,
    required this.emoji,
    required this.color,
    required this.width,
    required this.height,
  });

  ArchitectShape copyWith({
    String? id,
    BuildingShape? type,
    String? frenchName,
    String? emoji,
    Color? color,
    double? width,
    double? height,
  }) {
    return ArchitectShape(
      id: id ?? this.id,
      type: type ?? this.type,
      frenchName: frenchName ?? this.frenchName,
      emoji: emoji ?? this.emoji,
      color: color ?? this.color,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}

class PlacedShape {
  final ArchitectShape shape;
  final Offset position;
  final double rotation;
  final DateTime placedTime;
  final int zIndex;

  const PlacedShape({
    required this.shape,
    required this.position,
    this.rotation = 0.0,
    required this.placedTime,
    this.zIndex = 0,
  });

  PlacedShape copyWith({
    ArchitectShape? shape,
    Offset? position,
    double? rotation,
    DateTime? placedTime,
    int? zIndex,
  }) {
    return PlacedShape(
      shape: shape ?? this.shape,
      position: position ?? this.position,
      rotation: rotation ?? this.rotation,
      placedTime: placedTime ?? this.placedTime,
      zIndex: zIndex ?? this.zIndex,
    );
  }
}

class BlueprintRequirement {
  final BuildingShape shapeType;
  final Offset targetPosition;
  final double tolerance; // How close the shape needs to be placed
  final bool isOptional;
  final String hint;

  const BlueprintRequirement({
    required this.shapeType,
    required this.targetPosition,
    this.tolerance = 50.0,
    this.isOptional = false,
    required this.hint,
  });
}

class BlueprintObject {
  final String id;
  final BuildingObjectType type;
  final String name;
  final String frenchName;
  final String description;
  final String emoji;
  final List<BlueprintRequirement> requirements;
  final Size canvasSize;

  const BlueprintObject({
    required this.id,
    required this.type,
    required this.name,
    required this.frenchName,
    required this.description,
    required this.emoji,
    required this.requirements,
    required this.canvasSize,
  });

  bool isComplete(List<PlacedShape> placedShapes) {
    return requirements.every((requirement) {
      if (requirement.isOptional) return true;

      return placedShapes.any(
        (placedShape) =>
            placedShape.shape.type == requirement.shapeType &&
            _isWithinTolerance(
              placedShape.position,
              requirement.targetPosition,
              requirement.tolerance,
            ),
      );
    });
  }

  bool _isWithinTolerance(Offset position, Offset target, double tolerance) {
    final distance = (position - target).distance;
    return distance <= tolerance;
  }

  int getCompletionPercentage(List<PlacedShape> placedShapes) {
    final requiredShapes = requirements.where((req) => !req.isOptional).length;
    if (requiredShapes == 0) return 100;

    int completedShapes = 0;
    for (final requirement in requirements) {
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

      if (hasShape) completedShapes++;
    }

    return (completedShapes / requiredShapes * 100).round();
  }
}

class ArchitectLevel {
  final int level;
  final String title;
  final String frenchTitle;
  final String description;
  final String instruction;
  final List<ArchitectShape> availableShapes;
  final List<BlueprintObject> blueprintObjects;
  final bool allowsFreeBuilding;
  final int maxShapesPerType;

  const ArchitectLevel({
    required this.level,
    required this.title,
    required this.frenchTitle,
    required this.description,
    required this.instruction,
    required this.availableShapes,
    required this.blueprintObjects,
    this.allowsFreeBuilding = false,
    this.maxShapesPerType = 5,
  });
}

class ShapeArchitectData {
  // Available building shapes
  static const List<ArchitectShape> allShapes = [
    // Basic shapes in different colors
    ArchitectShape(
      id: 'red_circle',
      type: BuildingShape.circle,
      frenchName: 'cercle rouge',
      emoji: '🔴',
      color: Colors.red,
      width: 60,
      height: 60,
    ),
    ArchitectShape(
      id: 'blue_circle',
      type: BuildingShape.circle,
      frenchName: 'cercle bleu',
      emoji: '🔵',
      color: Colors.blue,
      width: 60,
      height: 60,
    ),
    ArchitectShape(
      id: 'yellow_circle',
      type: BuildingShape.circle,
      frenchName: 'cercle jaune',
      emoji: '🟡',
      color: Colors.yellow,
      width: 60,
      height: 60,
    ),

    // Rectangles
    ArchitectShape(
      id: 'brown_rectangle',
      type: BuildingShape.rectangle,
      frenchName: 'rectangle marron',
      emoji: '🟤',
      color: Colors.brown,
      width: 80,
      height: 60,
    ),
    ArchitectShape(
      id: 'green_rectangle',
      type: BuildingShape.rectangle,
      frenchName: 'rectangle vert',
      emoji: '🟢',
      color: Colors.green,
      width: 80,
      height: 60,
    ),

    // Squares
    ArchitectShape(
      id: 'red_square',
      type: BuildingShape.square,
      frenchName: 'carré rouge',
      emoji: '🟥',
      color: Colors.red,
      width: 60,
      height: 60,
    ),
    ArchitectShape(
      id: 'blue_square',
      type: BuildingShape.square,
      frenchName: 'carré bleu',
      emoji: '🟦',
      color: Colors.blue,
      width: 60,
      height: 60,
    ),

    // Triangles
    ArchitectShape(
      id: 'red_triangle',
      type: BuildingShape.triangle,
      frenchName: 'triangle rouge',
      emoji: '🔺',
      color: Colors.red,
      width: 70,
      height: 60,
    ),
    ArchitectShape(
      id: 'green_triangle',
      type: BuildingShape.triangle,
      frenchName: 'triangle vert',
      emoji: '🔺',
      color: Colors.green,
      width: 70,
      height: 60,
    ),

    // Special shapes
    ArchitectShape(
      id: 'black_oval',
      type: BuildingShape.oval,
      frenchName: 'ovale noir',
      emoji: '⚫',
      color: Colors.black,
      width: 50,
      height: 30,
    ),
    ArchitectShape(
      id: 'orange_diamond',
      type: BuildingShape.diamond,
      frenchName: 'losange orange',
      emoji: '🔶',
      color: Colors.orange,
      width: 50,
      height: 50,
    ),
  ];

  // Blueprint objects for different levels
  static final List<BlueprintObject> allBlueprintObjects = [
    // Level 1: Simple House
    BlueprintObject(
      id: 'simple_house',
      type: BuildingObjectType.house,
      name: 'Simple House',
      frenchName: 'Maison Simple',
      description:
          'Construis une maison avec un toit triangulaire, des murs rectangulaires et une fenêtre ronde!',
      emoji: '🏠',
      canvasSize: const Size(300, 250),
      requirements: [
        BlueprintRequirement(
          shapeType: BuildingShape.rectangle,
          targetPosition: Offset(150, 180), // Bottom center for walls
          hint: 'Place le rectangle pour les murs',
        ),
        BlueprintRequirement(
          shapeType: BuildingShape.triangle,
          targetPosition: Offset(150, 120), // Top center for roof
          hint: 'Ajoute le triangle pour le toit',
        ),
        BlueprintRequirement(
          shapeType: BuildingShape.circle,
          targetPosition: Offset(130, 170), // Left side for window
          hint: 'Mets un cercle pour la fenêtre',
        ),
      ],
    ),

    // Level 2: Car
    BlueprintObject(
      id: 'simple_car',
      type: BuildingObjectType.car,
      name: 'Car',
      frenchName: 'Voiture',
      description:
          'Fabrique une voiture avec un corps rectangulaire et des roues rondes!',
      emoji: '🚗',
      canvasSize: const Size(300, 200),
      requirements: [
        BlueprintRequirement(
          shapeType: BuildingShape.rectangle,
          targetPosition: Offset(150, 120), // Center for car body
          hint: 'Place le rectangle pour le corps de la voiture',
        ),
        BlueprintRequirement(
          shapeType: BuildingShape.circle,
          targetPosition: Offset(120, 160), // Left wheel
          hint: 'Ajoute un cercle pour la roue gauche',
        ),
        BlueprintRequirement(
          shapeType: BuildingShape.circle,
          targetPosition: Offset(180, 160), // Right wheel
          hint: 'Ajoute un cercle pour la roue droite',
        ),
      ],
    ),

    // Level 2: Truck
    BlueprintObject(
      id: 'simple_truck',
      type: BuildingObjectType.truck,
      name: 'Truck',
      frenchName: 'Camion',
      description:
          'Construis un camion avec une cabine carrée et une remorque rectangulaire!',
      emoji: '🚚',
      canvasSize: const Size(350, 200),
      requirements: [
        BlueprintRequirement(
          shapeType: BuildingShape.square,
          targetPosition: Offset(100, 130), // Truck cab
          hint: 'Place le carré pour la cabine',
        ),
        BlueprintRequirement(
          shapeType: BuildingShape.rectangle,
          targetPosition: Offset(200, 130), // Truck bed
          hint: 'Ajoute le rectangle pour la remorque',
        ),
        BlueprintRequirement(
          shapeType: BuildingShape.circle,
          targetPosition: Offset(80, 170), // Front wheel
          hint: 'Mets un cercle pour la roue avant',
        ),
        BlueprintRequirement(
          shapeType: BuildingShape.circle,
          targetPosition: Offset(220, 170), // Back wheel
          hint: 'Mets un cercle pour la roue arrière',
        ),
      ],
    ),

    // Level 3: Cat
    BlueprintObject(
      id: 'simple_cat',
      type: BuildingObjectType.cat,
      name: 'Cat',
      frenchName: 'Chat',
      description:
          'Crée un chat avec une tête ronde, des oreilles triangulaires et un corps ovale!',
      emoji: '🐱',
      canvasSize: const Size(250, 300),
      requirements: [
        BlueprintRequirement(
          shapeType: BuildingShape.circle,
          targetPosition: Offset(125, 100), // Head
          hint: 'Place un cercle pour la tête',
        ),
        BlueprintRequirement(
          shapeType: BuildingShape.triangle,
          targetPosition: Offset(105, 80), // Left ear
          hint: 'Ajoute un triangle pour l\'oreille gauche',
        ),
        BlueprintRequirement(
          shapeType: BuildingShape.triangle,
          targetPosition: Offset(145, 80), // Right ear
          hint: 'Ajoute un triangle pour l\'oreille droite',
        ),
        BlueprintRequirement(
          shapeType: BuildingShape.oval,
          targetPosition: Offset(125, 180), // Body
          hint: 'Place un ovale pour le corps',
        ),
      ],
    ),

    // Level 3: Robot
    BlueprintObject(
      id: 'simple_robot',
      type: BuildingObjectType.robot,
      name: 'Robot',
      frenchName: 'Robot',
      description: 'Assemble un robot avec des formes géométriques!',
      emoji: '🤖',
      canvasSize: const Size(250, 350),
      requirements: [
        BlueprintRequirement(
          shapeType: BuildingShape.square,
          targetPosition: Offset(125, 100), // Head
          hint: 'Place un carré pour la tête',
        ),
        BlueprintRequirement(
          shapeType: BuildingShape.rectangle,
          targetPosition: Offset(125, 180), // Body
          hint: 'Ajoute un rectangle pour le corps',
        ),
        BlueprintRequirement(
          shapeType: BuildingShape.circle,
          targetPosition: Offset(90, 120), // Left eye
          hint: 'Mets un cercle pour l\'œil gauche',
        ),
        BlueprintRequirement(
          shapeType: BuildingShape.circle,
          targetPosition: Offset(160, 120), // Right eye
          hint: 'Mets un cercle pour l\'œil droit',
        ),
      ],
    ),
  ];

  // Level definitions
  static final List<ArchitectLevel> levels = [
    // Level 1: Simple House
    ArchitectLevel(
      level: 1,
      title: 'Build a House',
      frenchTitle: 'Construire une Maison',
      description:
          'Apprends à construire ta première maison avec des formes géométriques!',
      instruction: 'Glisse les formes pour construire une maison',
      availableShapes: [
        allShapes[3], // Brown rectangle for walls
        allShapes[7], // Red triangle for roof
        allShapes[2], // Yellow circle for window
      ],
      blueprintObjects: [allBlueprintObjects[0]], // Simple house
    ),

    // Level 2: Vehicles
    ArchitectLevel(
      level: 2,
      title: 'Build Vehicles',
      frenchTitle: 'Construire des Véhicules',
      description:
          'Crée des voitures et des camions avec des roues qui tournent!',
      instruction: 'Construis des véhicules avec des formes',
      availableShapes: [
        allShapes[4], // Green rectangle
        allShapes[5], // Red square
        allShapes[0], // Red circle
        allShapes[1], // Blue circle
      ],
      blueprintObjects: [
        allBlueprintObjects[1],
        allBlueprintObjects[2],
      ], // Car and truck
    ),

    // Level 3: Animals & Creatures
    ArchitectLevel(
      level: 3,
      title: 'Create Creatures',
      frenchTitle: 'Créer des Créatures',
      description:
          'Donne vie à des animaux et des robots avec ton imagination!',
      instruction: 'Assemble des créatures fantastiques',
      availableShapes: [
        allShapes[0], // Red circle
        allShapes[1], // Blue circle
        allShapes[7], // Red triangle
        allShapes[8], // Green triangle
        allShapes[9], // Black oval
        allShapes[6], // Blue square
      ],
      blueprintObjects: [
        allBlueprintObjects[3],
        allBlueprintObjects[4],
      ], // Cat and robot
    ),

    // Level 4: Creative Freedom
    ArchitectLevel(
      level: 4,
      title: 'Free Building',
      frenchTitle: 'Construction Libre',
      description:
          'Laisse libre cours à ton imagination! Construis tout ce que tu veux!',
      instruction: 'Crée ce que tu imagines',
      availableShapes: allShapes, // All shapes available
      blueprintObjects: [], // No specific requirements
      allowsFreeBuilding: true,
      maxShapesPerType: 10,
    ),
  ];

  // Get level data
  static ArchitectLevel getLevelData(int level) {
    if (level < 1 || level > levels.length) {
      return levels[0];
    }
    return levels[level - 1];
  }

  // Get total number of levels
  static int get totalLevels => levels.length;

  // Get shapes by type
  static List<ArchitectShape> getShapesByType(BuildingShape type) {
    return allShapes.where((shape) => shape.type == type).toList();
  }

  // Get French shape name
  static String getShapeTypeFrenchName(BuildingShape type) {
    switch (type) {
      case BuildingShape.circle:
        return 'cercle';
      case BuildingShape.square:
        return 'carré';
      case BuildingShape.rectangle:
        return 'rectangle';
      case BuildingShape.triangle:
        return 'triangle';
      case BuildingShape.oval:
        return 'ovale';
      case BuildingShape.diamond:
        return 'losange';
      case BuildingShape.semicircle:
        return 'demi-cercle';
    }
  }

  // Calculate construction completion
  static double calculateConstructionProgress(
    List<PlacedShape> placedShapes,
    List<BlueprintObject> blueprints,
  ) {
    if (blueprints.isEmpty) return 1.0; // Free building mode

    int totalCompletion = 0;
    int blueprintCount = blueprints.length;

    for (final blueprint in blueprints) {
      totalCompletion += blueprint.getCompletionPercentage(placedShapes);
    }

    return blueprintCount == 0 ? 1.0 : totalCompletion / (blueprintCount * 100);
  }

  // Check if any blueprint is complete
  static bool isAnyBlueprintComplete(
    List<PlacedShape> placedShapes,
    List<BlueprintObject> blueprints,
  ) {
    return blueprints.any((blueprint) => blueprint.isComplete(placedShapes));
  }

  // Get construction feedback
  static String getConstructionFeedback(
    List<PlacedShape> placedShapes,
    List<BlueprintObject> blueprints,
  ) {
    if (blueprints.isEmpty) {
      final shapeCount = placedShapes.length;
      if (shapeCount == 0) return 'Commence ta création!';
      if (shapeCount < 3) return 'Continue à construire!';
      if (shapeCount < 6) return 'Belle construction!';
      return 'Création magnifique!';
    }

    final progress = calculateConstructionProgress(placedShapes, blueprints);
    if (progress < 0.3) return 'Commence par les formes principales!';
    if (progress < 0.7) return 'Tu y es presque!';
    if (progress < 1.0) return 'Plus que quelques formes!';
    return 'Construction terminée!';
  }
}

// Model for tracking architect progress
class ArchitectProgress {
  final int currentLevel;
  final int totalLevels;
  final bool isLevelCompleted;
  final bool isGameCompleted;
  final List<int> completedLevels;
  final List<PlacedShape> currentConstruction;
  final int totalShapesUsed;
  final int blueprintsCompleted;

  const ArchitectProgress({
    required this.currentLevel,
    required this.totalLevels,
    required this.isLevelCompleted,
    required this.isGameCompleted,
    required this.completedLevels,
    required this.currentConstruction,
    required this.totalShapesUsed,
    required this.blueprintsCompleted,
  });

  ArchitectProgress copyWith({
    int? currentLevel,
    int? totalLevels,
    bool? isLevelCompleted,
    bool? isGameCompleted,
    List<int>? completedLevels,
    List<PlacedShape>? currentConstruction,
    int? totalShapesUsed,
    int? blueprintsCompleted,
  }) {
    return ArchitectProgress(
      currentLevel: currentLevel ?? this.currentLevel,
      totalLevels: totalLevels ?? this.totalLevels,
      isLevelCompleted: isLevelCompleted ?? this.isLevelCompleted,
      isGameCompleted: isGameCompleted ?? this.isGameCompleted,
      completedLevels: completedLevels ?? this.completedLevels,
      currentConstruction: currentConstruction ?? this.currentConstruction,
      totalShapesUsed: totalShapesUsed ?? this.totalShapesUsed,
      blueprintsCompleted: blueprintsCompleted ?? this.blueprintsCompleted,
    );
  }

  double get overallProgress {
    if (totalLevels == 0) return 0.0;
    return completedLevels.length / totalLevels;
  }

  double get currentLevelProgress {
    // Progress is based on construction completion
    return isLevelCompleted ? 1.0 : (totalShapesUsed / 10).clamp(0.0, 1.0);
  }
}
