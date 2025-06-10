import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/shapes.dart';

class MathGeometryScreen extends StatefulWidget {
  const MathGeometryScreen({super.key});

  @override
  State<MathGeometryScreen> createState() => _MathGeometryScreenState();
}

class _MathGeometryScreenState extends State<MathGeometryScreen> {
  // Track matched shapes
  Map<String, bool> shapeMatches = {};
  Map<String, String?> droppedLabels = {};
  List<String> availableLabels = [];
  
  // Current level shapes (showing 4 at a time)
  List<ShapeData> currentShapes = [];
  int currentLevel = 0;
  int totalLevels = 2; // 8 shapes divided by 4
  
  @override
  void initState() {
    super.initState();
    _initializeLevel();
  }
  
  void _initializeLevel() {
    // Get 4 shapes for current level
    int startIndex = currentLevel * 4;
    int endIndex = (startIndex + 4).clamp(0, ShapeData.allShapes.length);
    currentShapes = ShapeData.allShapes.sublist(startIndex, endIndex);
    
    // Initialize available labels
    availableLabels = currentShapes.map((shape) => shape.frenchName).toList();
    availableLabels.shuffle(); // Randomize label order
    
    // Reset matches
    shapeMatches.clear();
    droppedLabels.clear();
    for (var shape in currentShapes) {
      shapeMatches[shape.name] = false;
      droppedLabels[shape.name] = null;
    }
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
              placeholderBuilder: (context) => Container(
                color: AppColors.secondary,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
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
                
                // Title and subtitle
                _buildTitleSection(),
                
                // Game content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Shapes grid
                        Expanded(
                          flex: 2,
                          child: _buildShapesGrid(),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Draggable labels
                        Expanded(
                          flex: 1,
                          child: _buildDraggableLabels(),
                        ),
                        
                        // Next level button
                        if (_allShapesMatched())
                          _buildNextLevelButton(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.chevron_left,
                    color: AppColors.darkGrey,
                    size: 16,
                  ),
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: AppColors.orangeAccentDark.withOpacity(0.3),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Text(
            'Le jeu des formes géométriques',
            style: TextStyle(
              color: AppColors.darkGrey,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Fais glisser le nom de chaque forme vers la forme correspondante.',
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildShapesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.1,
      ),
      itemCount: currentShapes.length,
      itemBuilder: (context, index) {
        final shape = currentShapes[index];
        return _buildShapeDropTarget(shape);
      },
    );
  }

  Widget _buildShapeDropTarget(ShapeData shape) {
    bool isMatched = shapeMatches[shape.name] ?? false;
    String? droppedLabel = droppedLabels[shape.name];
    
    return DragTarget<String>(
      onAcceptWithDetails: (details) {
        setState(() {
          // Remove old assignment if exists
          droppedLabels.forEach((key, value) {
            if (value == details.data) {
              droppedLabels[key] = null;
              shapeMatches[key] = false;
            }
          });
          
          // Add new assignment
          droppedLabels[shape.name] = details.data;
          shapeMatches[shape.name] = details.data == shape.frenchName;
          
          // Remove from available labels if correct
          if (shapeMatches[shape.name]!) {
            availableLabels.remove(details.data);
          }
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          decoration: BoxDecoration(
            color: isMatched 
              ? Colors.grey.shade200 // Light grey for better visibility
              : candidateData.isNotEmpty 
                ? AppColors.secondary.withOpacity(0.2)
                : AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isMatched 
                ? Colors.green.shade600 // Green border when correct
                : candidateData.isNotEmpty 
                  ? AppColors.secondary
                  : AppColors.grey.withOpacity(0.3),
              width: isMatched ? 3 : 2, // Thicker border when matched
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Shape SVG
              SizedBox(
                width: 60,
                height: 60,
                child: SvgPicture.string(
                  shape.svgString,
                  fit: BoxFit.contain,
                ),
              ),
              
              const SizedBox(height: 6),
              
              // Dropped label or placeholder
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: droppedLabel != null 
                    ? (isMatched ? Colors.grey.shade300 : Colors.red.withOpacity(0.1))
                    : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  droppedLabel ?? '?',
                  style: TextStyle(
                    color: droppedLabel != null 
                      ? (isMatched ? Colors.green.shade700 : Colors.red.shade700)
                      : AppColors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              
              // Checkmark or X for feedback
              if (droppedLabel != null)
                Icon(
                  isMatched ? Icons.check_circle : Icons.cancel,
                  color: isMatched ? Colors.green.shade600 : Colors.red,
                  size: 16,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDraggableLabels() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Fais glisser les étiquettes:',
            style: TextStyle(
              color: AppColors.darkGrey,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: availableLabels.map((label) => _buildDraggableLabel(label)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableLabel(String label) {
    return Draggable<String>(
      data: label,
      feedback: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      childWhenDragging: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.orangeAccentDark.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: AppColors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildNextLevelButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: _nextLevel,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          currentLevel < totalLevels - 1 ? 'Niveau suivant' : 'Recommencer',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  bool _allShapesMatched() {
    return shapeMatches.values.every((matched) => matched);
  }

  void _nextLevel() {
    setState(() {
      if (currentLevel < totalLevels - 1) {
        currentLevel++;
      } else {
        currentLevel = 0; // Restart from beginning
      }
      _initializeLevel();
    });
  }
}