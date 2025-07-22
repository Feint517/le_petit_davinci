// lib/features/Mathematic/view/market_balance_screen.dart

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/animated_button.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/market_balance_controller.dart';
import 'package:le_petit_davinci/features/Mathematic/models/market_balance_model.dart';

class MarketBalanceScreen extends StatefulWidget {
  const MarketBalanceScreen({super.key});

  @override
  State<MarketBalanceScreen> createState() => _MarketBalanceScreenState();
}

class _MarketBalanceScreenState extends State<MarketBalanceScreen> {
  late MarketBalanceController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(MarketBalanceController());
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
                        // Balance scale
                        Expanded(flex: 3, child: _buildBalanceScale()),

                        const SizedBox(height: 16),

                        // Comparison display
                        _buildComparisonDisplay(),

                        const SizedBox(height: 16),

                        // Available items or comparison buttons - FIXED HEIGHT
                        SizedBox(height: 200, child: _buildInteractionArea()),

                        // Controls and progress
                        _buildControls(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
              'Balance du Marché',
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
                color: AppColors.accent2, // Green for market theme
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent2.withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'Niveau $currentLevel - $levelTitle',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
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

  Widget _buildBalanceScale() {
    return Obx(() {
      final scaleState = controller.scaleState.value;
      final tiltAngle = scaleState.tiltAngle;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Scale stand and arm
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Scale stand
                  Positioned(
                    bottom: 20,
                    child: Container(
                      width: 8,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.darkGrey,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),

                  // Scale base
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.darkGrey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  // Scale arm (with tilt animation)
                  Center(
                    child: AnimatedRotation(
                      duration: const Duration(milliseconds: 800),
                      turns: tiltAngle / 360, // Convert degrees to turns
                      curve: Curves.elasticOut,
                      child: Container(
                        width: 280,
                        height: 6,
                        decoration: BoxDecoration(
                          color: AppColors.darkGrey,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),

                  // Left scale pan
                  Positioned(
                    left: 20,
                    child: AnimatedRotation(
                      duration: const Duration(milliseconds: 800),
                      turns: tiltAngle / 360,
                      curve: Curves.elasticOut,
                      child: _buildScalePan(ScaleSide.left),
                    ),
                  ),

                  // Right scale pan
                  Positioned(
                    right: 20,
                    child: AnimatedRotation(
                      duration: const Duration(milliseconds: 800),
                      turns: tiltAngle / 360,
                      curve: Curves.elasticOut,
                      child: _buildScalePan(ScaleSide.right),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildScalePan(ScaleSide side) {
    return Obx(() {
      final items = controller.getItemsOnSide(side);
      final showTargetNumber = controller.showTargetNumber.value;
      final targetNumber = controller.targetNumber.value;
      final isNumberSide = side == ScaleSide.left && showTargetNumber;

      return DragTarget<MarketItem>(
        onAcceptWithDetails: (details) {
          if (!isNumberSide) {
            // Can't drop on number side
            controller.dropItemOnScale(details.data, side);
          }
        },
        onWillAcceptWithDetails: (details) {
          return !isNumberSide && controller.canDropItemOnSide(side);
        },
        builder: (context, candidateData, rejectedData) {
          final isHovering = candidateData.isNotEmpty && !isNumberSide;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 120,
            height: 100,
            decoration: BoxDecoration(
              color:
                  isHovering
                      ? AppColors.accent2.withValues(alpha: 0.2)
                      : AppColors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(60),
              border: Border.all(
                color: isHovering ? AppColors.accent2 : AppColors.borderPrimary,
                width: isHovering ? 3 : 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: isHovering ? 12 : 6,
                  offset: Offset(0, isHovering ? 6 : 3),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Scale pan content
                Padding(
                  padding: const EdgeInsets.all(8),
                  child:
                      isNumberSide
                          ? _buildNumberDisplay(targetNumber)
                          : _buildItemsDisplay(items),
                ),

                // Weight indicator
                Positioned(
                  top: 4,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color:
                          side == ScaleSide.left
                              ? AppColors.primary.withValues(alpha: 0.8)
                              : AppColors.secondary.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isNumberSide ? '$targetNumber' : '${items.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }

  Widget _buildNumberDisplay(int number) {
    return Center(
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryDeep],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ).animate().pulse(duration: 2000.ms);
  }

  Widget _buildItemsDisplay(List<MarketItem> items) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          'Vide',
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 14,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: items.length > 4 ? 3 : 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => controller.speakItemDescription(items[index]),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                items[index].emoji,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ).animate().scale(
          duration: 300.ms,
          delay: (index * 50).ms,
          curve: Curves.elasticOut,
        );
      },
    );
  }

  Widget _buildComparisonDisplay() {
    return Obx(() {
      final scaleState = controller.scaleState.value;
      final symbol = controller.getComparisonSymbol();
      final leftWeight = scaleState.leftWeight.toInt();
      final rightWeight = scaleState.rightWeight.toInt();

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                scaleState.isBalanced
                    ? AppColors.accent2
                    : scaleState.isLeftHeavier
                    ? AppColors.primary
                    : AppColors.secondary,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Left weight
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                leftWeight.toString(),
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Comparison symbol
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color:
                    scaleState.isBalanced
                        ? AppColors.accent2.withValues(alpha: 0.2)
                        : AppColors.warning.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                symbol,
                style: TextStyle(
                  color:
                      scaleState.isBalanced
                          ? AppColors.accent2
                          : AppColors.warning,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).animate().pulse(duration: 1000.ms),

            const SizedBox(width: 16),

            // Right weight
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                rightWeight.toString(),
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInteractionArea() {
    return Obx(() {
      // Get current level type to determine what to show
      final currentLevel = controller.currentLevel.value;
      final levelData = MarketBalanceData.getLevelData(currentLevel);
      final levelType = levelData.type;
      final availableItems = controller.availableItems;

      // For visual comparison and same item comparison levels, show comparison buttons
      if (levelType == LevelType.visualComparison ||
          levelType == LevelType.sameItemComparison) {
        return _buildComparisonButtons();
      }
      // For interactive levels (makeEqual and numberVsObject), show draggable items
      else if (availableItems.isNotEmpty) {
        return _buildAvailableItems();
      }
      // All items used
      else {
        return _buildCompletionMessage();
      }
    });
  }

  Widget _buildAvailableItems() {
    return Obx(() {
      final availableItems = controller.availableItems;

      return Container(
        width: double.infinity,
        height: 200, // Fixed height
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.accent2.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.accent2.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text('🛒', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(
                  'Objets du marché:',
                  style: TextStyle(
                    color: AppColors.accent2,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: availableItems.length > 6 ? 4 : 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: availableItems.length,
                itemBuilder: (context, index) {
                  return _buildDraggableItem(availableItems[index], index);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDraggableItem(MarketItem item, int index) {
    return Draggable<MarketItem>(
      data: item,
      onDragStarted: () => controller.onItemDragStart(item),
      feedback: Material(
        color: Colors.transparent,
        child: _buildItemWidget(item, isDragging: true),
      ),
      childWhenDragging: _buildItemWidget(item, isGhost: true),
      child: _buildItemWidget(item),
    ).animate().slideY(
      begin: 0.5,
      duration: 400.ms,
      delay: (index * 100).ms,
      curve: Curves.easeOutBack,
    );
  }

  Widget _buildItemWidget(
    MarketItem item, {
    bool isDragging = false,
    bool isGhost = false,
  }) {
    return GestureDetector(
      onTap: () => controller.speakItemDescription(item),
      child: Container(
        decoration: BoxDecoration(
          color:
              isGhost ? AppColors.grey.withValues(alpha: 0.3) : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isGhost
                    ? AppColors.grey.withValues(alpha: 0.3)
                    : AppColors.borderPrimary,
            width: 1,
          ),
          boxShadow:
              isGhost
                  ? []
                  : [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: isDragging ? 0.2 : 0.1,
                      ),
                      blurRadius: isDragging ? 12 : 6,
                      offset: Offset(0, isDragging ? 6 : 3),
                    ),
                  ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item.emoji, style: TextStyle(fontSize: isDragging ? 28 : 24)),
            const SizedBox(height: 4),
            Text(
              item.frenchName,
              style: TextStyle(
                color: isGhost ? AppColors.grey : AppColors.darkGrey,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonButtons() {
    return Container(
      width: double.infinity,
      height: 200, // Fixed height instead of using Expanded
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Quelle est la bonne comparaison?',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // Use regular Column instead of Expanded for buttons
          Expanded(
            child: Column(
              children: [
                // First button row
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              print("Left Greater button pressed"); // Debug
                              controller.checkComparison(
                                ComparisonType.leftGreater,
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Plus à gauche >',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              print("Equal button pressed"); // Debug
                              controller.checkComparison(ComparisonType.equal);
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.accent2.withValues(alpha: 0.8),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.accent2.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Équilibre =',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              print("Right Greater button pressed"); // Debug
                              controller.checkComparison(
                                ComparisonType.rightGreater,
                              );
                            },
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.secondary.withValues(
                                  alpha: 0.8,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.secondary.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Plus à droite <',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionMessage() {
    return Container(
      height: 200, // Fixed height
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '⚖️✨',
              style: TextStyle(fontSize: 48),
            ).animate().scale(duration: 800.ms, curve: Curves.elasticOut),
            const SizedBox(height: 16),
            Text(
              'Tous les objets ont été placés!',
              style: TextStyle(
                color: AppColors.accent2,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Obx(() {
      final currentLevel = controller.currentLevel.value;
      final maxLevel = controller.maxLevel;
      final progress = controller.getOverallProgress();

      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent2),
              minHeight: 6,
            ).animate().slideX(duration: 600.ms),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Level progress
                Row(
                  children: [
                    Icon(Icons.balance, color: AppColors.accent2, size: 20),
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
                Text('⚖️✨', style: TextStyle(fontSize: 60)),
                const SizedBox(height: 16),
                Text(
                  'Niveau terminé!',
                  style: TextStyle(
                    color: AppColors.accent2,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tu comprends bien les comparaisons!',
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
                Text('🎉⚖️🎉', style: TextStyle(fontSize: 60)),
                const SizedBox(height: 16),
                Text(
                  'Bravo!',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tu es maintenant un expert des comparaisons mathématiques!',
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                PrimaryAnimatedButton(
                  label: 'Rejouer',
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
