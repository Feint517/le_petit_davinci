// lib/features/Mathematic/view/shape_architect_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/animated_button.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/shape_architect_controller.dart';
import 'package:le_petit_davinci/features/Mathematic/models/shape_architect_model.dart';

class ShapeArchitectScreen extends StatefulWidget {
  const ShapeArchitectScreen({super.key});

  @override
  State<ShapeArchitectScreen> createState() => _ShapeArchitectScreenState();
}

class _ShapeArchitectScreenState extends State<ShapeArchitectScreen> {
  late ShapeArchitectController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ShapeArchitectController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              SvgAssets.mathbg,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholderBuilder:
                  (context) => Container(
                    color: AppColors.secondary,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  ),
            ),
          ),

          // Content
          SafeArea(
            child: Column(
              children: [
                // Top navigation bar
                _buildTopNavigation(),

                // Title and level info
                _buildTitleSection(),

                // Game content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Toolbox (left side)
                        Expanded(flex: 1, child: _buildToolbox()),

                        const SizedBox(width: 16),

                        // Construction area (right side)
                        Expanded(flex: 2, child: _buildConstructionArea()),
                      ],
                    ),
                  ),
                ),

                // Controls and progress
                _buildControls(),
              ],
            ),
          ),

          // Construction hint overlay
          Obx(
            () =>
                controller.showConstructionHint.value
                    ? _buildHintOverlay()
                    : const SizedBox.shrink(),
          ),

          // Level complete overlay
          Obx(
            () =>
                controller.showLevelComplete.value
                    ? _buildLevelCompleteOverlay()
                    : const SizedBox.shrink(),
          ),

          // Game complete celebration
          Obx(
            () =>
                controller.showCelebration.value
                    ? _buildCelebrationOverlay()
                    : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildTopNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.chevron_left, color: AppColors.darkGrey, size: 16),
                  const SizedBox(width: 2),
                  Text(
                    'Back',
                    style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          // Math label
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: AppColors.orangeAccentDark.withValues(alpha: 0.3),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Text(
              'Mathématiques',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Obx(() {
      final currentLevel = controller.currentLevel.value;
      final levelTitle = controller.getCurrentLevelTitle();
      final instruction = controller.getCurrentLevelInstruction();

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(
              'Architecte des Formes',
              style: TextStyle(
                color: AppColors.darkGrey,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // Level indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.accent,
                    AppColors.accentDark,
                  ], // Purple architect theme
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accentDark.withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🏗️', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 8),
                  Text(
                    'Niveau $currentLevel - $levelTitle',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Instruction
            Text(
              instruction,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    });
  }

  Widget _buildToolbox() {
    return Obx(() {
      final availableShapes = controller.availableShapes;
      final shapeCounts = controller.getShapeCountByType();

      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF8B4513).withValues(alpha: 0.8), // Wood brown
              const Color(0xFF654321).withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(-2, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Toolbox header
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF654321),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Text('🧰', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(
                    'Boîte à Outils',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Shape inventory
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child:
                    availableShapes.isEmpty
                        ? Center(
                          child: Text(
                            'Toutes les formes utilisées!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                        : SingleChildScrollView(
                          child: Column(
                            children: _buildShapeInventoryByType(shapeCounts),
                          ),
                        ),
              ),
            ),
          ],
        ),
      );
    });
  }

  List<Widget> _buildShapeInventoryByType(Map<BuildingShape, int> shapeCounts) {
    final widgets = <Widget>[];

    for (final entry in shapeCounts.entries) {
      if (entry.value == 0) continue;

      final shapeType = entry.key;
      final count = entry.value;
      final shapes =
          controller.availableShapes
              .where((s) => s.type == shapeType)
              .take(3)
              .toList();

      widgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Column(
            children: [
              // Type label with count
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${ShapeArchitectData.getShapeTypeFrenchName(shapeType)} ($count)',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Shape samples
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    shapes.map((shape) => _buildDraggableShape(shape)).toList(),
              ),
            ],
          ),
        ),
      );
    }

    return widgets;
  }

  Widget _buildDraggableShape(ArchitectShape shape) {
    return Draggable<ArchitectShape>(
      data: shape,
      onDragStarted: () => controller.onShapeDragStart(shape),
      feedback: Material(
        color: Colors.transparent,
        child: _buildShapeWidget(shape, isDragging: true),
      ),
      childWhenDragging: _buildShapeWidget(shape, isGhost: true),
      child: _buildShapeWidget(shape),
    );
  }

  Widget _buildShapeWidget(
    ArchitectShape shape, {
    bool isDragging = false,
    bool isGhost = false,
  }) {
    return GestureDetector(
      onTap: () => controller.speakShapeName(shape),
      child: Container(
        width: isDragging ? shape.width * 1.2 : shape.width,
        height: isDragging ? shape.height * 1.2 : shape.height,
        decoration: BoxDecoration(
          color: isGhost ? shape.color.withValues(alpha: 0.3) : shape.color,
          borderRadius: _getShapeBorderRadius(shape.type),
          border: Border.all(
            color: Colors.white.withValues(alpha: isGhost ? 0.3 : 0.7),
            width: 2,
          ),
          boxShadow:
              isGhost
                  ? []
                  : [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDragging ? 0.3 : 0.15,
                      ),
                      blurRadius: isDragging ? 12 : 6,
                      offset: Offset(0, isDragging ? 6 : 3),
                    ),
                  ],
        ),
        child: _buildShapeContent(shape, isGhost),
      ),
    );
  }

  BorderRadius _getShapeBorderRadius(BuildingShape shapeType) {
    switch (shapeType) {
      case BuildingShape.circle:
      case BuildingShape.oval:
        return BorderRadius.circular(50);
      case BuildingShape.square:
      case BuildingShape.rectangle:
        return BorderRadius.circular(8);
      case BuildingShape.triangle:
        return BorderRadius.circular(4);
      case BuildingShape.diamond:
        return BorderRadius.circular(4);
      case BuildingShape.semicircle:
        return BorderRadius.circular(25);
    }
  }

  Widget _buildShapeContent(ArchitectShape shape, bool isGhost) {
    final color = isGhost ? Colors.grey : Colors.white;

    switch (shape.type) {
      case BuildingShape.triangle:
        return CustomPaint(
          painter: TrianglePainter(color: color),
          size: Size(shape.width, shape.height),
        );
      case BuildingShape.diamond:
        return Transform.rotate(
          angle: 0.785398, // 45 degrees
          child: Container(
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      default:
        return Center(
          child: Text(
            shape.emoji,
            style: TextStyle(fontSize: shape.width * 0.4, color: color),
          ),
        );
    }
  }

  Widget _buildConstructionArea() {
    return Obx(() {
      final isFreeBuildingMode = controller.isFreeBuildingMode;

      return Container(
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.accent.withValues(alpha: 0.3),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Construction header
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    isFreeBuildingMode ? '🎨' : '📋',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isFreeBuildingMode
                        ? 'Construction Libre'
                        : 'Plan de Construction',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),

                  // Blueprint selector or feedback
                  if (!isFreeBuildingMode) _buildBlueprintSelector(),
                ],
              ),
            ),

            // Canvas area
            Expanded(
              child:
                  isFreeBuildingMode
                      ? _buildFreeCanvas()
                      : _buildBlueprintCanvas(),
            ),

            // Construction feedback
            _buildConstructionFeedback(),
          ],
        ),
      );
    });
  }

  Widget _buildBlueprintSelector() {
    return Obx(() {
      final blueprints = controller.getAvailableBlueprints();
      final selectedId = controller.selectedBlueprintId.value;

      if (blueprints.length <= 1) return const SizedBox.shrink();

      return DropdownButton<String>(
        value: selectedId,
        items:
            blueprints.map((blueprint) {
              return DropdownMenuItem<String>(
                value: blueprint.id,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(blueprint.emoji, style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 4),
                    Text(blueprint.frenchName, style: TextStyle(fontSize: 12)),
                    if (controller.isBlueprintCompleted(blueprint.id))
                      Text(' ✓', style: TextStyle(color: AppColors.accent2)),
                  ],
                ),
              );
            }).toList(),
        onChanged: (value) {
          if (value != null) {
            controller.selectBlueprint(value);
          }
        },
        underline: const SizedBox.shrink(),
      );
    });
  }

  Widget _buildFreeCanvas() {
    return Container(
      key: controller.canvasKey,
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.skyBlue.withValues(alpha: 0.3),
            AppColors.lightGrey.withValues(alpha: 0.5),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.2),
          width: 1,
          style: BorderStyle.solid,
        ),
      ),
      child: _buildCanvasWithShapes(),
    );
  }

  Widget _buildBlueprintCanvas() {
    return Obx(() {
      final blueprint = controller.getCurrentBlueprint();
      if (blueprint == null) return const SizedBox.shrink();

      return Container(
        key: controller.canvasKey,
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.accent.withValues(alpha: 0.3),
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Blueprint guidelines
            _buildBlueprintGuidelines(blueprint),

            // Placed shapes
            _buildCanvasWithShapes(),
          ],
        ),
      );
    });
  }

  Widget _buildBlueprintGuidelines(BlueprintObject blueprint) {
    return CustomPaint(
      painter: BlueprintPainter(
        blueprint: blueprint,
        placedShapes: controller.placedShapes,
      ),
      size: blueprint.canvasSize,
    );
  }

  Widget _buildCanvasWithShapes() {
    return Obx(() {
      final placedShapes = controller.placedShapes;

      return DragTarget<ArchitectShape>(
        onAcceptWithDetails: (details) {
          // Get drop position relative to canvas
          final RenderBox? renderBox =
              controller.canvasKey.currentContext?.findRenderObject()
                  as RenderBox?;
          if (renderBox != null) {
            final localPosition = renderBox.globalToLocal(details.offset);
            controller.dropShapeOnCanvas(details.data, localPosition);
          }
        },
        onWillAcceptWithDetails: (details) {
          return true; // Controller handles validation
        },
        builder: (context, candidateData, rejectedData) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color:
                  candidateData.isNotEmpty
                      ? AppColors.accent.withValues(alpha: 0.1)
                      : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children:
                  placedShapes.asMap().entries.map((entry) {
                    final index = entry.key;
                    final placedShape = entry.value;
                    return _buildPlacedShape(placedShape, index);
                  }).toList(),
            ),
          );
        },
      );
    });
  }

  Widget _buildPlacedShape(PlacedShape placedShape, int index) {
    return Positioned(
      left: placedShape.position.dx - (placedShape.shape.width / 2),
      top: placedShape.position.dy - (placedShape.shape.height / 2),
      child: GestureDetector(
        onTap: () => controller.removeShapeFromConstruction(placedShape),
        child: Transform.rotate(
          angle: placedShape.rotation,
          child: _buildShapeWidget(placedShape.shape),
        ),
      ).animate().scale(
        duration: 300.ms,
        delay: (index * 50).ms,
        curve: Curves.elasticOut,
      ),
    );
  }

  Widget _buildConstructionFeedback() {
    return Obx(() {
      final feedback = controller.getCurrentFeedback();

      return GestureDetector(
        onTap: () => controller.speakFeedback(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.accent, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  feedback,
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Icon(Icons.volume_up, color: AppColors.accent, size: 16),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildControls() {
    return Obx(() {
      final currentLevel = controller.currentLevel.value;
      final maxLevel = controller.maxLevel;
      final progress = controller.getCurrentLevelProgress();

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
              minHeight: 6,
            ).animate().slideX(duration: 600.ms),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Level progress
                Row(
                  children: [
                    Icon(Icons.architecture, color: AppColors.accent, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Niveau $currentLevel/$maxLevel',
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                // Control buttons
                Row(
                  children: [
                    // Instructions button
                    SecondaryAnimatedButton(
                      label: '🔊',
                      onPressed: () => controller.speakInstructions(),
                    ),

                    const SizedBox(width: 8),

                    // Hint button (blueprint mode only)
                    if (!controller.isFreeBuildingMode)
                      SecondaryAnimatedButton(
                        label: '💡',
                        onPressed: () => controller.showHint(),
                      ),

                    if (!controller.isFreeBuildingMode)
                      const SizedBox(width: 8),

                    // Reset level button
                    SecondaryAnimatedButton(
                      label: 'Reset',
                      icon: const Icon(Icons.refresh, size: 16),
                      onPressed: () => controller.resetCurrentLevel(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHintOverlay() {
    return Obx(() {
      final hint = controller.currentHint.value;

      return Positioned(
        top: 100,
        left: 20,
        right: 20,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.accent2,
                AppColors.accent2.withValues(alpha: 0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Text('💡', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  hint,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ).animate().slideY(
          begin: -1,
          duration: 400.ms,
          curve: Curves.easeOutBack,
        ),
      );
    });
  }

  Widget _buildLevelCompleteOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.7),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(32),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🏗️✨', style: TextStyle(fontSize: 60)),
                const SizedBox(height: 16),
                Text(
                  'Construction réussie!',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tu es un excellent architecte!',
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
        ),
      ),
    );
  }

  Widget _buildCelebrationOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withValues(alpha: 0.8),
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(32),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🎉🏗️🎉', style: TextStyle(fontSize: 60)),
                const SizedBox(height: 16),
                Text(
                  'Maître Architecte!',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tu es maintenant un maître architecte des formes!',
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                PrimaryAnimatedButton(
                  label: 'Nouveau projet',
                  onPressed: () => controller.resetGame(),
                ),
              ],
            ),
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
        ),
      ),
    );
  }
}

// Custom painter for triangle shapes
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for blueprint guidelines
class BlueprintPainter extends CustomPainter {
  final BlueprintObject blueprint;
  final List<PlacedShape> placedShapes;

  BlueprintPainter({required this.blueprint, required this.placedShapes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = AppColors.accent.withValues(alpha: 0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..strokeCap = StrokeCap.round;

    final dashedPaint =
        Paint()
          ..color = AppColors.accent.withValues(alpha: 0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

    // Draw blueprint requirements
    for (final requirement in blueprint.requirements) {
      if (requirement.isOptional) continue;

      // Check if this requirement is fulfilled
      final isFulfilled = placedShapes.any(
        (placedShape) =>
            placedShape.shape.type == requirement.shapeType &&
            _isWithinTolerance(
              placedShape.position,
              requirement.targetPosition,
              requirement.tolerance,
            ),
      );

      final currentPaint =
          isFulfilled
              ? (paint..color = AppColors.accent2.withValues(alpha: 0.6))
              : (paint..color = AppColors.accent.withValues(alpha: 0.4));

      // Draw shape outline based on type
      _drawShapeOutline(
        canvas,
        requirement.shapeType,
        requirement.targetPosition,
        currentPaint,
      );

      // Draw tolerance circle
      canvas.drawCircle(
        requirement.targetPosition,
        requirement.tolerance,
        dashedPaint,
      );
    }
  }

  void _drawShapeOutline(
    Canvas canvas,
    BuildingShape shapeType,
    Offset position,
    Paint paint,
  ) {
    switch (shapeType) {
      case BuildingShape.circle:
        canvas.drawCircle(position, 30, paint);
        break;
      case BuildingShape.square:
        canvas.drawRect(
          Rect.fromCenter(center: position, width: 60, height: 60),
          paint,
        );
        break;
      case BuildingShape.rectangle:
        canvas.drawRect(
          Rect.fromCenter(center: position, width: 80, height: 60),
          paint,
        );
        break;
      case BuildingShape.triangle:
        final path = Path();
        path.moveTo(position.dx, position.dy - 30);
        path.lineTo(position.dx - 35, position.dy + 30);
        path.lineTo(position.dx + 35, position.dy + 30);
        path.close();
        canvas.drawPath(path, paint);
        break;
      default:
        canvas.drawCircle(position, 25, paint);
    }
  }

  bool _isWithinTolerance(Offset position, Offset target, double tolerance) {
    final distance = (position - target).distance;
    return distance <= tolerance;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
