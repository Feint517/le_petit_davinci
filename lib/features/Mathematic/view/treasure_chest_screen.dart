// lib/features/Mathematic/view/treasure_chest_screen.dart

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/animated_button.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/treasure_chest_controller.dart';
import 'package:le_petit_davinci/features/Mathematic/models/treasure_chest_model.dart';

class TreasureChestScreen extends StatefulWidget {
  const TreasureChestScreen({super.key});

  @override
  State<TreasureChestScreen> createState() => _TreasureChestScreenState();
}

class _TreasureChestScreenState extends State<TreasureChestScreen> {
  late TreasureChestController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(TreasureChestController());
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
                        // Treasure chest area
                        Expanded(flex: 3, child: _buildTreasureChestArea()),

                        const SizedBox(height: 16),

                        // Equation or treasure map
                        _buildMathDisplay(),

                        const SizedBox(height: 16),

                        // Available treasure items
                        Expanded(flex: 2, child: _buildTreasureItems()),

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
              'Coffre aux Trésors',
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
                    AppColors.secondary,
                    AppColors.orangeAccentDark,
                  ], // Gold pirate theme
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.orangeAccentDark.withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🏴‍☠️', style: TextStyle(fontSize: 16)),
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

  Widget _buildTreasureChestArea() {
    return Obx(() {
      final chest = controller.treasureChest.value;
      final glowIntensity = controller.getChestGlowIntensity();

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(
                0xFF1E3A5F,
              ).withValues(alpha: 0.8), // Dark pirate blue
              const Color(0xFF2D4A6B).withValues(alpha: 0.6),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Pirate decorations
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('⚓', style: TextStyle(fontSize: 24)),
                Text('🗺️', style: TextStyle(fontSize: 24)),
                Text('⚔️', style: TextStyle(fontSize: 24)),
              ],
            ).animate().fadeIn(duration: 800.ms),

            const SizedBox(height: 20),

            // Main treasure chest
            Expanded(child: _buildAnimatedTreasureChest(chest, glowIntensity)),

            const SizedBox(height: 20),

            // Chest status and progress
            _buildChestStatus(chest),
          ],
        ),
      );
    });
  }

  Widget _buildAnimatedTreasureChest(
    TreasureChest chest,
    double glowIntensity,
  ) {
    return DragTarget<TreasureItem>(
      onAcceptWithDetails: (details) {
        controller.dropItemInChest(details.data);
      },
      onWillAcceptWithDetails: (details) {
        return controller.canDropItemInChest();
      },
      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;
        final willAccept = isHovering && controller.canDropItemInChest();

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              if (glowIntensity > 0 || isHovering)
                BoxShadow(
                  color:
                      willAccept
                          ? AppColors.secondary.withValues(
                            alpha: glowIntensity * 0.8,
                          )
                          : AppColors.warning.withValues(alpha: 0.5),
                  blurRadius: 20 * (glowIntensity + (isHovering ? 0.3 : 0)),
                  spreadRadius: 5 * glowIntensity,
                ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Treasure chest base
              _buildChestBase(chest, isHovering),

              // Chest contents
              if (chest.containedItems.isNotEmpty)
                _buildChestContents(chest.containedItems),

              // Sparkling effects for opened chest
              if (chest.state == ChestState.sparkling) _buildSparklingEffects(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildChestBase(TreasureChest chest, bool isHovering) {
    final isOpen =
        chest.state == ChestState.opened || chest.state == ChestState.sparkling;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      width: 200,
      height: 160,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
              isHovering
                  ? [
                    AppColors.orangeAccentDark.withValues(alpha: 0.9),
                    AppColors.secondary.withValues(alpha: 0.9),
                  ]
                  : [
                    const Color(0xFF8B4513), // Brown chest
                    const Color(0xFF654321),
                  ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondary, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Chest body
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 120,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [const Color(0xFF8B4513), const Color(0xFF5D2F0A)],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
            ),
          ),

          // Chest lid
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.elasticOut,
            top: isOpen ? -40 : 0,
            left: 0,
            right: 0,
            height: 80,
            child: Transform.rotate(
              angle: isOpen ? -0.8 : 0,
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [const Color(0xFF8B4513), const Color(0xFF654321)],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 15,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChestContents(List<TreasureItem> items) {
    return Positioned(
      bottom: 40,
      left: 20,
      right: 20,
      height: 60,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: items.length > 6 ? 4 : 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                items[index].emoji,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ).animate().scale(
            duration: 300.ms,
            delay: (index * 50).ms,
            curve: Curves.elasticOut,
          );
        },
      ),
    );
  }

  Widget _buildSparklingEffects() {
    return Positioned.fill(
      child: Stack(
        children: List.generate(6, (index) {
          final random = (index * 37) % 100;
          final x = (random % 180) + 10.0;
          final y = ((random * 3) % 120) + 20.0;

          return Positioned(
            left: x,
            top: y,
            child: Text(
                  '✨',
                  style: TextStyle(
                    fontSize: 20 + (random % 10),
                    color: AppColors.secondary,
                  ),
                )
                .animate()
                .fadeIn(duration: 500.ms)
                .then()
                .fadeOut(duration: 500.ms),
          );
        }),
      ),
    );
  }

  Widget _buildChestStatus(TreasureChest chest) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Current amount
          Column(
            children: [
              Text(
                chest.currentAmount.toString(),
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Actuel',
                style: TextStyle(color: AppColors.grey, fontSize: 12),
              ),
            ],
          ),

          // Progress bar
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LinearProgressIndicator(
                value: chest.fillPercentage,
                backgroundColor: AppColors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(
                  chest.isFull ? AppColors.accent2 : AppColors.secondary,
                ),
                minHeight: 8,
              ),
            ),
          ),

          // Target amount
          Column(
            children: [
              Text(
                chest.targetAmount.toString(),
                style: TextStyle(
                  color: AppColors.secondary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Objectif',
                style: TextStyle(color: AppColors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMathDisplay() {
    return Obx(() {
      final showEquation = controller.showEquation.value;
      final showTreasureMap = controller.showTreasureMap.value;

      if (showEquation) {
        return _buildEquationDisplay();
      } else if (showTreasureMap) {
        return _buildTreasureMapDisplay();
      } else {
        return const SizedBox.shrink();
      }
    });
  }

  Widget _buildEquationDisplay() {
    return Obx(() {
      final equation = controller.currentEquation.value;

      return GestureDetector(
        onTap: () => controller.speakEquation(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primaryDeep],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🧮', style: TextStyle(fontSize: 24)),
              const SizedBox(width: 12),
              Text(
                equation,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.volume_up, color: Colors.white, size: 24),
            ],
          ),
        ),
      ).animate().pulse(duration: 2000.ms);
    });
  }

  Widget _buildTreasureMapDisplay() {
    return Obx(() {
      final mapProgress = controller.getTreasureMapProgress();
      final discoveredBonds = controller.getDiscoveredBonds();

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF4E4BC), // Parchment color
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFD2B48C), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text('🗺️', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Text(
                  'Carte au Trésor',
                  style: TextStyle(
                    color: const Color(0xFF8B4513),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '${(mapProgress * 100).toInt()}%',
                  style: TextStyle(
                    color: const Color(0xFF8B4513),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            LinearProgressIndicator(
              value: mapProgress,
              backgroundColor: const Color(0xFFD2B48C),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF8B4513),
              ),
              minHeight: 8,
            ),

            const SizedBox(height: 12),

            if (discoveredBonds.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    discoveredBonds.map((bond) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent2.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.accent2,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          '${bond.firstNumber} + ${bond.secondNumber} = ${bond.target}',
                          style: TextStyle(
                            color: AppColors.accent2,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }).toList(),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildTreasureItems() {
    return Obx(() {
      final availableItems = controller.availableItems;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.accent3.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.accent3.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text('💰', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(
                  'Trésor disponible: ${availableItems.length}',
                  style: TextStyle(
                    color: AppColors.accent3,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Expanded(
              child:
                  availableItems.isEmpty
                      ? Center(
                        child: Text(
                          'Tous les trésors ont été utilisés!',
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                      : GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: availableItems.length > 12 ? 6 : 5,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: availableItems.length,
                        itemBuilder: (context, index) {
                          return _buildDraggableTreasure(
                            availableItems[index],
                            index,
                          );
                        },
                      ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDraggableTreasure(TreasureItem item, int index) {
    return Draggable<TreasureItem>(
      data: item,
      onDragStarted: () => controller.onItemDragStart(item),
      feedback: Material(
        color: Colors.transparent,
        child: _buildTreasureWidget(item, isDragging: true),
      ),
      childWhenDragging: _buildTreasureWidget(item, isGhost: true),
      child: _buildTreasureWidget(item),
    ).animate().slideY(
      begin: 0.5,
      duration: 400.ms,
      delay: (index * 50).ms,
      curve: Curves.easeOutBack,
    );
  }

  Widget _buildTreasureWidget(
    TreasureItem item, {
    bool isDragging = false,
    bool isGhost = false,
  }) {
    return GestureDetector(
      onTap: () => controller.speakItemDescription(item),
      child: Container(
        decoration: BoxDecoration(
          gradient:
              isGhost
                  ? LinearGradient(
                    colors: [
                      AppColors.grey.withValues(alpha: 0.3),
                      AppColors.lightGrey.withValues(alpha: 0.3),
                    ],
                  )
                  : LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.secondary, AppColors.orangeAccentDark],
                  ),
          borderRadius: BorderRadius.circular(12),
          boxShadow:
              isGhost
                  ? []
                  : [
                    BoxShadow(
                      color: AppColors.orangeAccentDark.withValues(alpha: 0.3),
                      blurRadius: isDragging ? 12 : 6,
                      offset: Offset(0, isDragging ? 6 : 3),
                    ),
                  ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(item.emoji, style: TextStyle(fontSize: isDragging ? 28 : 24)),
            const SizedBox(height: 2),
            Text(
              item.frenchName,
              style: TextStyle(
                color: isGhost ? AppColors.grey : Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
      final progress = controller.getCurrentLevelProgress();

      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            // Progress bar
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
              minHeight: 6,
            ).animate().slideX(duration: 600.ms),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Level progress
                Row(
                  children: [
                    Icon(Icons.savings, color: AppColors.secondary, size: 20),
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
                Text('💰✨', style: TextStyle(fontSize: 60)),
                const SizedBox(height: 16),
                Text(
                  'Trésor trouvé!',
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tu maîtrises les combinaisons de nombres!',
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
                Text('🎉🏴‍☠️🎉', style: TextStyle(fontSize: 60)),
                const SizedBox(height: 16),
                Text(
                  'Capitaine!',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tu es maintenant un maître des combinaisons de nombres!',
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                PrimaryAnimatedButton(
                  label: 'Nouvelle aventure',
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
