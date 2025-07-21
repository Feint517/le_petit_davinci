// lib/features/Mathematic/view/number_puzzle_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/animated_button.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/number_puzzle_controller.dart';
import 'package:le_petit_davinci/features/Mathematic/models/number_puzzle_model.dart';

class NumberPuzzleScreen extends StatefulWidget {
  const NumberPuzzleScreen({super.key});

  @override
  State<NumberPuzzleScreen> createState() => _NumberPuzzleScreenState();
}

class _NumberPuzzleScreenState extends State<NumberPuzzleScreen> {
  late NumberPuzzleController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(NumberPuzzleController());
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
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Sequence puzzle area
                        Expanded(flex: 3, child: _buildSequencePuzzle()),

                        const SizedBox(height: 20),

                        // Draggable numbers
                        Expanded(flex: 2, child: _buildDraggableNumbers()),

                        // Controls
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
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(
              'Puzzle des Nombres',
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
                color: AppColors.accent2,
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
                'Niveau ${controller.currentLevel.value} - ${controller.getCurrentLevelDescription()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Sequence hint
            Text(
              controller.getCurrentSequenceHint(),
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

  Widget _buildSequencePuzzle() {
    return Obx(() {
      final sequence = controller.getCurrentSequence();
      if (sequence == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return Column(
        children: [
          // Garden decoration
          Text(
            '🌻',
            style: TextStyle(fontSize: 40),
          ).animate().fadeIn(duration: 800.ms),

          const SizedBox(height: 20),

          // Sequence containers (flower beds)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                sequence.sequence.length,
                (index) => _buildFlowerBed(index, sequence),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Progress indicator for current sequence
          LinearProgressIndicator(
            value: controller.getCurrentLevelProgress(),
            backgroundColor: AppColors.grey,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent2),
            minHeight: 6,
          ).animate().slideX(duration: 600.ms),
        ],
      );
    });
  }

  Widget _buildFlowerBed(int position, NumberSequence sequence) {
    return Obx(() {
      final number = controller.getNumberAtPosition(position);
      final canDrop = controller.canDrop(position);
      final nextEmptyPosition = controller.getNextEmptyPosition();
      final isHinted = nextEmptyPosition == position;

      return DragTarget<int>(
        onAcceptWithDetails: (details) {
          controller.onNumberDrop(position, details.data);
        },
        onWillAcceptWithDetails: (details) {
          return canDrop;
        },
        builder: (context, candidateData, rejectedData) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors:
                    candidateData.isNotEmpty
                        ? [
                          AppColors.accent2.withValues(alpha: 0.8),
                          AppColors.accent2,
                        ]
                        : canDrop
                        ? [AppColors.white, AppColors.lightGrey]
                        : [AppColors.softGrey, AppColors.grey],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color:
                    isHinted
                        ? AppColors.accent2
                        : candidateData.isNotEmpty
                        ? AppColors.accent2
                        : AppColors.borderPrimary,
                width: isHinted ? 3 : 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Flower decoration
                Text(canDrop ? '🌱' : '🌸', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 4),

                // Number or empty space
                if (number != null)
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        number.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.borderPrimary.withValues(alpha: 0.5),
                        style: BorderStyle.solid,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
              ],
            ),
          );
        },
      ).animate().slideY(
        begin: 1,
        duration: 400.ms,
        delay: (position * 100).ms,
        curve: Curves.easeOutBack,
      );
    });
  }

  Widget _buildDraggableNumbers() {
    return Obx(() {
      final availableNumbers = controller.availableNumbers;

      if (availableNumbers.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🎉', style: TextStyle(fontSize: 40)),
              const SizedBox(height: 8),
              Text(
                'Séquence terminée!',
                style: TextStyle(
                  color: AppColors.accent2,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }

      return Column(
        children: [
          Text(
            'Fais glisser les nombres:',
            style: TextStyle(
              color: AppColors.darkGrey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = _getCrossAxisCount(
                  availableNumbers.length,
                );
                final itemWidth =
                    (constraints.maxWidth - (crossAxisCount - 1) * 10) /
                    crossAxisCount;
                final childAspectRatio = itemWidth / 60; // Fixed height of 60

                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: childAspectRatio,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: availableNumbers.length,
                  itemBuilder: (context, index) {
                    return _buildDraggableNumber(
                      availableNumbers[index],
                      index,
                    );
                  },
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildDraggableNumber(int number, int index) {
    return Draggable<int>(
      data: number,
      onDragStarted: () => controller.onDragStart(number),
      feedback: Material(
        color: Colors.transparent,
        child: _buildNumberTile(number, isDragging: true),
      ),
      childWhenDragging: _buildNumberTile(number, isGhost: true),
      child: _buildNumberTile(number),
    ).animate().scale(
      duration: 300.ms,
      delay: (index * 50).ms,
      curve: Curves.easeOutBack,
    );
  }

  Widget _buildNumberTile(
    int number, {
    bool isDragging = false,
    bool isGhost = false,
  }) {
    return GestureDetector(
      onTap: () => controller.speakNumber(number),
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 50,
          minHeight: 50,
          maxWidth: 70,
          maxHeight: 70,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                isGhost
                    ? [
                      AppColors.grey.withValues(alpha: 0.5),
                      AppColors.lightGrey.withValues(alpha: 0.5),
                    ]
                    : isDragging
                    ? [
                      AppColors.accent.withValues(alpha: 0.9),
                      AppColors.accentDark.withValues(alpha: 0.9),
                    ]
                    : [AppColors.accent, AppColors.accentDark],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow:
              isGhost
                  ? []
                  : [
                    BoxShadow(
                      color: AppColors.accentDark.withValues(alpha: 0.3),
                      blurRadius: isDragging ? 12 : 6,
                      offset: Offset(0, isDragging ? 6 : 3),
                    ),
                  ],
        ),
        child: Center(
          child: Text(
            number.toString(),
            style: TextStyle(
              color: isGhost ? AppColors.grey : Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Level progress
            Row(
              children: [
                Icon(Icons.local_florist, color: AppColors.accent2, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Niveau ${controller.currentLevel.value}/${controller.maxLevel}',
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
                // Hint button
                SecondaryAnimatedButton(
                  label: '💡',
                  onPressed: () {
                    final nextPos = controller.getNextEmptyPosition();
                    if (nextPos != null) {
                      final sequence = controller.getCurrentSequence();
                      final correctNumber = sequence?.getCorrectNumberAt(
                        nextPos,
                      );
                      if (correctNumber != null) {
                        controller.speakNumber(correctNumber);
                      }
                    }
                  },
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
                Text('🌻', style: TextStyle(fontSize: 60)),
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
                  'Bien joué! Passons au niveau suivant.',
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
                Text('🎉🌺🎉', style: TextStyle(fontSize: 60)),
                const SizedBox(height: 16),
                Text(
                  'Félicitations!',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tu as terminé tous les puzzles de nombres!',
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

  int _getCrossAxisCount(int itemCount) {
    if (itemCount <= 3) return 3;
    if (itemCount <= 6) return 3;
    if (itemCount <= 12) return 4;
    return 5;
  }
}
