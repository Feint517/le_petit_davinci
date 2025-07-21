// lib/features/Mathematic/view/tidy_room_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/animated_button.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/tidy_room_controller.dart';
import 'package:le_petit_davinci/features/Mathematic/models/tidy_room_model.dart';
import 'dart:math' as math;

class TidyRoomScreen extends StatefulWidget {
  const TidyRoomScreen({super.key});

  @override
  State<TidyRoomScreen> createState() => _TidyRoomScreenState();
}

class _TidyRoomScreenState extends State<TidyRoomScreen> {
  late TidyRoomController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(TidyRoomController());
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
                        // Messy room with scattered toys
                        Expanded(flex: 3, child: _buildMessyRoom()),

                        const SizedBox(height: 16),

                        // Sorting boxes
                        Expanded(flex: 2, child: _buildSortingBoxes()),

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
              'Ranger la Chambre',
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
                color: AppColors.accent, // Purple for organization theme
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.3),
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

  Widget _buildMessyRoom() {
    return Obx(() {
      final availableToys = controller.availableToys;
      final cleanliness = controller.getRoomCleanliness();

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.lerp(
            AppColors.warning.withValues(alpha: 0.1), // Messy = light red
            AppColors.accent2.withValues(alpha: 0.1), // Clean = light green
            cleanliness,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                Color.lerp(
                  AppColors.warning.withValues(alpha: 0.3),
                  AppColors.accent2.withValues(alpha: 0.3),
                  cleanliness,
                )!,
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
        child: Column(
          children: [
            // Room header with cleanliness indicator
            Row(
              children: [
                Icon(
                  cleanliness > 0.8
                      ? Icons.celebration
                      : cleanliness > 0.5
                      ? Icons.cleaning_services
                      : Icons.warning,
                  color: Color.lerp(
                    AppColors.warning,
                    AppColors.accent2,
                    cleanliness,
                  ),
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  cleanliness > 0.8
                      ? 'Chambre bien rangée!'
                      : cleanliness > 0.5
                      ? 'En cours de rangement...'
                      : 'Chambre en désordre',
                  style: TextStyle(
                    color: Color.lerp(
                      AppColors.warning,
                      AppColors.accent2,
                      cleanliness,
                    ),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                // Cleanliness percentage
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Color.lerp(
                      AppColors.warning,
                      AppColors.accent2,
                      cleanliness,
                    )!.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${(cleanliness * 100).toInt()}%',
                    style: TextStyle(
                      color: Color.lerp(
                        AppColors.warning,
                        AppColors.accent2,
                        cleanliness,
                      ),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Scattered toys area
            Expanded(
              child:
                  availableToys.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '✨🛏️✨',
                              style: TextStyle(fontSize: 48),
                            ).animate().scale(
                              duration: 800.ms,
                              curve: Curves.elasticOut,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Chambre parfaitement rangée!',
                              style: TextStyle(
                                color: AppColors.accent2,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                      : LayoutBuilder(
                        builder: (context, constraints) {
                          return Stack(
                            children:
                                availableToys.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final toy = entry.value;
                                  return _buildScatteredToy(
                                    toy,
                                    index,
                                    constraints,
                                  );
                                }).toList(),
                          );
                        },
                      ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildScatteredToy(Toy toy, int index, BoxConstraints constraints) {
    // Create pseudo-random but consistent positions for toys
    final random = math.Random(toy.id.hashCode);
    final maxWidth = constraints.maxWidth - 60;
    final maxHeight = constraints.maxHeight - 60;

    final left = random.nextDouble() * maxWidth;
    final top = random.nextDouble() * maxHeight;
    final rotation = (random.nextDouble() - 0.5) * 0.4; // Small rotation

    return Positioned(
      left: left,
      top: top,
      child: _buildDraggableToy(toy, index, rotation),
    );
  }

  Widget _buildDraggableToy(Toy toy, int index, double rotation) {
    return Draggable<Toy>(
      data: toy,
      onDragStarted: () => controller.onToyDragStart(toy),
      feedback: Material(
        color: Colors.transparent,
        child: Transform.rotate(
          angle: rotation,
          child: _buildToyWidget(toy, isDragging: true),
        ),
      ),
      childWhenDragging: _buildToyWidget(toy, isGhost: true),
      child: GestureDetector(
        onTap: () => controller.speakToyDescription(toy),
        child: Transform.rotate(angle: rotation, child: _buildToyWidget(toy)),
      ),
    ).animate().slideY(
      begin: -0.5,
      duration: 600.ms,
      delay: (index * 100).ms,
      curve: Curves.bounceOut,
    );
  }

  Widget _buildToyWidget(
    Toy toy, {
    bool isDragging = false,
    bool isGhost = false,
  }) {
    return Container(
      width: 50,
      height: 50,
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
      child: Center(
        child: Text(
          toy.emoji,
          style: TextStyle(fontSize: isDragging ? 28 : 24),
        ),
      ),
    );
  }

  Widget _buildSortingBoxes() {
    return Obx(() {
      final sortingBoxes = controller.sortingBoxes;

      return Column(
        children: [
          Text(
            'Boîtes de rangement:',
            style: TextStyle(
              color: AppColors.darkGrey,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: sortingBoxes.length > 2 ? 3 : 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: sortingBoxes.length,
              itemBuilder: (context, index) {
                return _buildSortingBox(sortingBoxes[index], index);
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildSortingBox(SortingBox box, int index) {
    return DragTarget<Toy>(
      onAcceptWithDetails: (details) {
        controller.sortToyIntoBox(details.data, box);
      },
      onWillAcceptWithDetails: (details) {
        return controller.canDropToyInBox(details.data, box);
      },
      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;
        final willAccept =
            candidateData.isNotEmpty &&
            controller.canDropToyInBox(candidateData.first!, box);
        final toysInBox = controller.getToysInBox(box.id);

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color:
                isHovering
                    ? willAccept
                        ? AppColors.accent2.withValues(alpha: 0.2)
                        : AppColors.warning.withValues(alpha: 0.2)
                    : AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  isHovering
                      ? willAccept
                          ? AppColors.accent2
                          : AppColors.warning
                      : AppColors.accent,
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
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                // Box emoji and label
                Row(
                  children: [
                    Text(box.emoji, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        box.frenchLabel,
                        style: TextStyle(
                          color: AppColors.accent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                // Toys in box
                Expanded(
                  child:
                      toysInBox.isEmpty
                          ? Center(
                            child: Text(
                              'Vide',
                              style: TextStyle(
                                color: AppColors.grey,
                                fontSize: 10,
                              ),
                            ),
                          )
                          : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 1.0,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                ),
                            itemCount: toysInBox.length,
                            itemBuilder: (context, toyIndex) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: AppColors.lightGrey,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    toysInBox[toyIndex].emoji,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              );
                            },
                          ),
                ),

                // Toy count
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${toysInBox.length}',
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ).animate().slideX(
          begin: index.isEven ? -0.5 : 0.5,
          duration: 400.ms,
          delay: (index * 100).ms,
          curve: Curves.easeOutBack,
        );
      },
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
                    Icon(
                      Icons.home_outlined,
                      color: AppColors.accent,
                      size: 20,
                    ),
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
                Text('🏠✨', style: TextStyle(fontSize: 60)),
                const SizedBox(height: 16),
                Text(
                  'Niveau terminé!',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'La chambre est maintenant bien rangée!',
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
                Text('🎉🧹🎉', style: TextStyle(fontSize: 60)),
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
                  'Tu es maintenant un expert du rangement!',
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
