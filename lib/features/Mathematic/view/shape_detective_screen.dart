// lib/features/Mathematic/view/shape_detective_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/animated_button.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/shape_detective_controller.dart';
import 'package:le_petit_davinci/features/Mathematic/models/shape_detective_model.dart';

class ShapeDetectiveScreen extends StatefulWidget {
  const ShapeDetectiveScreen({super.key});

  @override
  State<ShapeDetectiveScreen> createState() => _ShapeDetectiveScreenState();
}

class _ShapeDetectiveScreenState extends State<ShapeDetectiveScreen> {
  late ShapeDetectiveController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ShapeDetectiveController());
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
                    child: Column(
                      children: [
                        // Scene exploration area
                        Expanded(flex: 3, child: _buildSceneExplorer()),

                        const SizedBox(height: 16),

                        // Detective dashboard
                        _buildDetectiveDashboard(),

                        // Controls and progress
                        _buildControls(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Discovery animation overlay
          Obx(
            () =>
                controller.showShapeDiscovery.value
                    ? _buildDiscoveryOverlay()
                    : const SizedBox.shrink(),
          ),

          // Hint overlay
          Obx(
            () =>
                controller.showHintOverlay.value
                    ? _buildHintOverlay()
                    : const SizedBox.shrink(),
          ),

          // Ripple effects
          _buildRippleEffects(),

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
              'Détective des Formes',
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
                    AppColors.primary,
                    AppColors.primaryDeep,
                  ], // Detective blue theme
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryDeep.withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🔍', style: TextStyle(fontSize: 16)),
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

  Widget _buildSceneExplorer() {
    return Obx(() {
      final scene = controller.currentScene.value;
      if (scene == null) return const SizedBox.shrink();

      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Scene background
              _buildSceneBackground(scene),

              // Interactive overlay for tap detection
              _buildTapDetectionOverlay(scene),

              // Scene selector (if multiple scenes available)
              _buildSceneSelector(),

              // Found shapes indicators
              _buildFoundShapesOverlay(scene),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSceneBackground(DetectiveScene scene) {
    return Positioned.fill(
      key: controller.sceneKey,
      child: _getSceneBackground(scene),
    );
  }

  Widget _getSceneBackground(DetectiveScene scene) {
    switch (scene.type) {
      case SceneType.bedroom:
        return _buildBedroomScene(scene);
      case SceneType.kitchen:
        return _buildKitchenScene(scene);
      case SceneType.playground:
        return _buildPlaygroundScene(scene);
      case SceneType.city:
        return _buildCityScene(scene);
    }
  }

  Widget _buildBedroomScene(DetectiveScene scene) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFE1BEE7).withValues(alpha: 0.8), // Light purple
            const Color(0xFFF8BBD9).withValues(alpha: 0.6), // Pink
          ],
        ),
      ),
      child: Stack(
        children: [
          // Bed
          Positioned(
            left: 0.3,
            top: 0.5,
            child: Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF8B4513), // Brown
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text('🛏️', style: TextStyle(fontSize: 40))),
            ),
          ),

          // Clock (circle shape)
          Positioned(
            right: 0.1,
            top: 0.15,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.brown, width: 3),
              ),
              child: Center(child: Text('🕐', style: TextStyle(fontSize: 30))),
            ),
          ),

          // Picture frame (square shape)
          Positioned(
            left: 0.1,
            top: 0.25,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.brown, width: 2),
              ),
              child: Center(child: Text('🖼️', style: TextStyle(fontSize: 20))),
            ),
          ),

          // Mirror (oval shape)
          Positioned(
            right: 0.2,
            top: 0.35,
            child: Container(
              width: 40,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.lightBlue.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color(0xFFC0C0C0), width: 2),
              ),
              child: Center(child: Text('🪞', style: TextStyle(fontSize: 25))),
            ),
          ),

          // Lamp with button
          Positioned(
            left: 0.25,
            top: 0.45,
            child: Column(
              children: [
                Text('💡', style: TextStyle(fontSize: 30)),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKitchenScene(DetectiveScene scene) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFE082).withValues(alpha: 0.8), // Light yellow
            const Color(0xFFFFF9C4).withValues(alpha: 0.6), // Cream
          ],
        ),
      ),
      child: Stack(
        children: [
          // Refrigerator (rectangle)
          Positioned(
            left: 0.05,
            top: 0.3,
            child: Container(
              width: 60,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: Center(child: Text('🧊', style: TextStyle(fontSize: 25))),
            ),
          ),

          // Window (rectangle)
          Positioned(
            right: 0.1,
            top: 0.15,
            child: Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.lightBlue.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.brown, width: 3),
              ),
              child: Center(child: Text('🪟', style: TextStyle(fontSize: 35))),
            ),
          ),

          // Plates on shelf (circles)
          Positioned(
            left: 0.15,
            top: 0.25,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: Center(
                    child: Text('🍽️', style: TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: Center(
                    child: Text('🍽️', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),

          // Stove with burner (circle)
          Positioned(
            left: 0.45,
            top: 0.45,
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text('🔥', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),

          // Pizza slice (triangle)
          Positioned(
            left: 0.35,
            bottom: 0.2,
            child: CustomPaint(
              painter: TrianglePainter(color: Colors.orange),
              size: const Size(50, 40),
              child: Container(
                width: 50,
                height: 40,
                child: Center(
                  child: Text('🍕', style: TextStyle(fontSize: 25)),
                ),
              ),
            ),
          ),

          // Cutting board (rectangle)
          Positioned(
            right: 0.3,
            bottom: 0.3,
            child: Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF8B4513),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(child: Text('🔪', style: TextStyle(fontSize: 20))),
            ),
          ),

          // Egg (oval)
          Positioned(
            right: 0.2,
            bottom: 0.1,
            child: Container(
              width: 25,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Text('🥚', style: TextStyle(fontSize: 15))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaygroundScene(DetectiveScene scene) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF81C784).withValues(alpha: 0.8), // Light green
            const Color(0xFFA5D6A7).withValues(alpha: 0.6), // Lighter green
          ],
        ),
      ),
      child: Stack(
        children: [
          // Sky with sun (circle)
          Positioned(
            right: 0.1,
            top: 0.05,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
              child: Center(child: Text('☀️', style: TextStyle(fontSize: 30))),
            ),
          ),

          // Slide with triangle roof
          Positioned(
            right: 0.25,
            top: 0.2,
            child: Column(
              children: [
                CustomPaint(
                  painter: TrianglePainter(color: Colors.red),
                  size: const Size(60, 40),
                ),
                Container(
                  width: 60,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text('🛝', style: TextStyle(fontSize: 30)),
                  ),
                ),
              ],
            ),
          ),

          // Swings (rectangles)
          Positioned(
            left: 0.15,
            top: 0.5,
            child: Column(
              children: [
                Container(height: 40, width: 2, color: Colors.brown),
                Container(
                  width: 40,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: 0.25,
            top: 0.5,
            child: Column(
              children: [
                Container(height: 40, width: 2, color: Colors.brown),
                Container(
                  width: 40,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            ),
          ),

          // Sandbox (square)
          Positioned(
            left: 0.4,
            bottom: 0.1,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.brown[300],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.brown, width: 3),
              ),
              child: Center(child: Text('🏖️', style: TextStyle(fontSize: 35))),
            ),
          ),

          // Balls (circles)
          Positioned(
            right: 0.35,
            bottom: 0.25,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Center(child: Text('⚽', style: TextStyle(fontSize: 20))),
            ),
          ),

          Positioned(
            left: 0.45,
            bottom: 0.2,
            child: Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              child: Center(child: Text('🏀', style: TextStyle(fontSize: 15))),
            ),
          ),

          // Monkey bars (rectangle)
          Positioned(
            right: 0.1,
            top: 0.35,
            child: Container(
              width: 60,
              height: 15,
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(child: Text('🐵', style: TextStyle(fontSize: 10))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCityScene(DetectiveScene scene) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF90CAF9).withValues(alpha: 0.8), // Light blue sky
            const Color(0xFFE0E0E0).withValues(alpha: 0.6), // Gray city
          ],
        ),
      ),
      child: Stack(
        children: [
          // Buildings with windows (rectangles)
          Positioned(
            left: 0.05,
            top: 0.15,
            child: Container(
              width: 80,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(width: 20, height: 30, color: Colors.lightBlue),
                      Container(width: 20, height: 30, color: Colors.lightBlue),
                      Container(width: 20, height: 30, color: Colors.lightBlue),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(width: 20, height: 30, color: Colors.lightBlue),
                      Container(width: 20, height: 30, color: Colors.lightBlue),
                      Container(width: 20, height: 30, color: Colors.lightBlue),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Buildings with triangle roofs
          Positioned(
            right: 0.1,
            top: 0.1,
            child: Column(
              children: [
                CustomPaint(
                  painter: TrianglePainter(color: Colors.red),
                  size: const Size(60, 40),
                ),
                Container(
                  width: 60,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text('🏠', style: TextStyle(fontSize: 30)),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            right: 0.02,
            top: 0.15,
            child: Column(
              children: [
                CustomPaint(
                  painter: TrianglePainter(color: Colors.green),
                  size: const Size(50, 35),
                ),
                Container(
                  width: 50,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Text('🏠', style: TextStyle(fontSize: 25)),
                  ),
                ),
              ],
            ),
          ),

          // Traffic light (circles)
          Positioned(
            right: 0.25,
            top: 0.3,
            child: Container(
              width: 30,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Car with wheels (circles)
          Positioned(
            left: 0.3,
            bottom: 0.1,
            child: Stack(
              children: [
                Container(
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text('🚗', style: TextStyle(fontSize: 20)),
                  ),
                ),
                Positioned(
                  left: 10,
                  bottom: -5,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: -5,
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bus with windows (rectangles)
          Positioned(
            left: 0.25,
            bottom: 0.2,
            child: Container(
              width: 80,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(width: 15, height: 25, color: Colors.lightBlue),
                  Container(width: 15, height: 25, color: Colors.lightBlue),
                  Container(width: 15, height: 25, color: Colors.lightBlue),
                ],
              ),
            ),
          ),

          // Stop sign (square)
          Positioned(
            right: 0.35,
            top: 0.45,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(child: Text('🛑', style: TextStyle(fontSize: 20))),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTapDetectionOverlay(DetectiveScene scene) {
    return Positioned.fill(
      child: GestureDetector(
        onTapUp: (details) => controller.onScreenTap(details.globalPosition),
        child: Container(color: Colors.transparent),
      ),
    );
  }

  Widget _buildFoundShapesOverlay(DetectiveScene scene) {
    return Positioned.fill(
      child: Stack(
        children:
            scene.hiddenShapes
                .where((shape) => shape.isFound)
                .map((shape) => _buildFoundShapeIndicator(shape, scene))
                .toList(),
      ),
    );
  }

  Widget _buildFoundShapeIndicator(HiddenShape shape, DetectiveScene scene) {
    return Positioned(
      left:
          shape.position.dx * 300 -
          shape.size.width / 2, // Approximate conversion
      top: shape.position.dy * 200 - shape.size.height / 2,
      child: Container(
        width: shape.size.width,
        height: shape.size.height,
        decoration: BoxDecoration(
          border: Border.all(color: shape.shapeColor, width: 3),
          borderRadius: BorderRadius.circular(8),
          color: shape.shapeColor.withValues(alpha: 0.2),
        ),
        child: Center(
          child: Icon(Icons.check_circle, color: shape.shapeColor, size: 20),
        ),
      ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
    );
  }

  Widget _buildSceneSelector() {
    return Obx(() {
      final availableScenes = controller.getAvailableScenes();
      if (availableScenes.length <= 1) return const SizedBox.shrink();

      return Positioned(
        top: 16,
        left: 16,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children:
                availableScenes.map((scene) {
                  final isSelected =
                      scene.id == controller.currentSceneId.value;
                  return GestureDetector(
                    onTap: () => controller.switchScene(scene.id),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? scene.themeColor.withValues(alpha: 0.3)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(scene.emoji, style: TextStyle(fontSize: 20)),
                          Text(
                            scene.frenchName,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight:
                                  isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
          ),
        ),
      );
    });
  }

  Widget _buildDetectiveDashboard() {
    return Obx(() {
      final stats = controller.getProgressStats();
      final explorationMessage = controller.getExplorationFeedback();

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withValues(alpha: 0.1),
              AppColors.primaryDeep.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            // Dashboard header
            Row(
              children: [
                Text('🕵️‍♂️', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 12),
                Text(
                  'Tableau de Détective',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Statistics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatCard(
                  'Trouvées',
                  stats['totalFound'].toString(),
                  '🔍',
                ),
                _buildStatCard('Points', stats['totalPoints'].toString(), '⭐'),
                _buildStatCard(
                  'Restantes',
                  controller.getRemainingShapesCount().toString(),
                  '🎯',
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Exploration message
            GestureDetector(
              onTap: () => controller.speakExplorationMessage(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        explorationMessage,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Icon(Icons.volume_up, color: AppColors.primary, size: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildStatCard(String label, String value, String emoji) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(emoji, style: TextStyle(fontSize: 24)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(label, style: TextStyle(color: AppColors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildRippleEffects() {
    return Obx(() {
      final ripples = controller.getActiveRipples();

      return Stack(
        children:
            ripples.map((ripple) {
              final age =
                  DateTime.now().difference(ripple.value).inMilliseconds;
              final progress = (age / 2000.0).clamp(
                0.0,
                1.0,
              ); // 2 second animation

              return Positioned(
                left: ripple.key.dx - 25,
                top: ripple.key.dy - 25,
                child: IgnorePointer(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withValues(
                          alpha: 1.0 - progress,
                        ),
                        width: 2,
                      ),
                    ),
                  ).animate().scale(
                    begin: const Offset(0.0, 0.0),
                    end: const Offset(2.0, 2.0),
                    duration: 2000.ms,
                    curve: Curves.easeOut,
                  ),
                ),
              );
            }).toList(),
      );
    });
  }

  Widget _buildControls() {
    return Obx(() {
      final currentLevel = controller.currentLevel.value;
      final maxLevel = controller.maxLevel;
      final progress = controller.getCurrentLevelProgress();

      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 6,
            ).animate().slideX(duration: 600.ms),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Level progress
                Row(
                  children: [
                    Icon(Icons.search, color: AppColors.primary, size: 20),
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

                    // Hint button (if hints allowed)
                    if (controller.hintsAllowed)
                      SecondaryAnimatedButton(
                        label: '💡',
                        onPressed: () => controller.provideHint(),
                      ),

                    if (controller.hintsAllowed) const SizedBox(width: 8),

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

  Widget _buildDiscoveryOverlay() {
    return Obx(() {
      final foundShape = controller.recentlyFoundShape.value;
      if (foundShape == null) return const SizedBox.shrink();

      return Positioned(
        top: 120,
        left: 20,
        right: 20,
        child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    foundShape.shapeColor.withValues(alpha: 0.9),
                    foundShape.shapeColor.withValues(alpha: 0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: foundShape.shapeColor.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(foundShape.emoji, style: TextStyle(fontSize: 48)),
                  const SizedBox(height: 12),
                  Text(
                    'Trouvé!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${foundShape.frenchObjectName} - ${foundShape.frenchShapeName}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '+${foundShape.points} points',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
            .animate()
            .slideY(begin: -1, duration: 600.ms, curve: Curves.elasticOut)
            .then()
            .fadeOut(duration: 1000.ms, delay: 1000.ms),
      );
    });
  }

  Widget _buildHintOverlay() {
    return Obx(() {
      final hint = controller.currentHint.value;

      return Positioned(
        top: 80,
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
              Text('💡', style: TextStyle(fontSize: 32)),
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
                Text('🔍✨', style: TextStyle(fontSize: 60)),
                const SizedBox(height: 16),
                Text(
                  'Mission accomplie!',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() {
                  final rank = controller.getDetectiveRank();
                  return Text(
                    rank,
                    style: TextStyle(
                      color: AppColors.darkGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  );
                }),
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
                Text('🎉🔍🎉', style: TextStyle(fontSize: 60)),
                const SizedBox(height: 16),
                Text(
                  'Maître Détective!',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tu es maintenant un maître détective des formes!',
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                PrimaryAnimatedButton(
                  label: 'Nouvelle enquête',
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

// Custom painter for triangle shapes in scenes
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
