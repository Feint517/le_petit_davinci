// lib/features/Mathematic/view/candy_shop_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/animated_button.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/candy_shop_controller.dart';
import 'package:le_petit_davinci/features/Mathematic/models/candy_shop_model.dart';

class CandyShopScreen extends StatefulWidget {
  const CandyShopScreen({super.key});

  @override
  State<CandyShopScreen> createState() => _CandyShopScreenState();
}

class _CandyShopScreenState extends State<CandyShopScreen> {
  late CandyShopController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(CandyShopController());
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
                        // Candy shop display
                        Expanded(flex: 2, child: _buildCandyShop()),

                        const SizedBox(height: 16),

                        // Purchase bag
                        Expanded(flex: 1, child: _buildPurchaseBag()),

                        const SizedBox(height: 16),

                        // Wallet with coins
                        Expanded(flex: 1, child: _buildWallet()),

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
      final currentLevel = controller.currentLevel.value;
      final levelDescription = controller.getCurrentLevelDescription();

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(
              'Magasin des Bonbons',
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
                color: AppColors.accent3, // Pink for candy theme
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent3.withValues(alpha: 0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'Niveau $currentLevel',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Level description
            Text(
              levelDescription,
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

  Widget _buildCandyShop() {
    return Obx(() {
      final availableCandies = controller.getAvailableCandies();

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(16),
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
                Text('🍬', style: TextStyle(fontSize: 24)),
                const SizedBox(width: 8),
                Text(
                  'Choisis tes bonbons:',
                  style: TextStyle(
                    color: AppColors.darkGrey,
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
                  crossAxisCount: _getCrossAxisCount(availableCandies.length),
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: availableCandies.length,
                itemBuilder: (context, index) {
                  return _buildCandyDisplay(availableCandies[index], index);
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildCandyDisplay(Candy candy, int index) {
    return DragTarget<String>(
      onAcceptWithDetails: (details) {
        if (details.data == 'coin') {
          controller.purchaseCandy(candy);
        }
      },
      onWillAcceptWithDetails: (details) {
        return details.data == 'coin' && controller.canPurchaseCandy();
      },
      builder: (context, candidateData, rejectedData) {
        return GestureDetector(
          onTap: () => controller.speakCandy(candy),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            decoration: BoxDecoration(
              color:
                  candidateData.isNotEmpty
                      ? AppColors.accent3.withValues(alpha: 0.2)
                      : AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color:
                    candidateData.isNotEmpty
                        ? AppColors.accent3
                        : AppColors.borderPrimary,
                width: candidateData.isNotEmpty ? 3 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(candy.emoji, style: const TextStyle(fontSize: 32)),
                const SizedBox(height: 4),
                Text(
                  candy.frenchName,
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accent3.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '1 🪙',
                    style: TextStyle(
                      color: AppColors.accent3,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).animate().slideY(
      begin: 0.5,
      duration: 400.ms,
      delay: (index * 100).ms,
      curve: Curves.easeOutBack,
    );
  }

  Widget _buildPurchaseBag() {
    return Obx(() {
      final purchasedCandies = controller.purchasedCandies;

      return Container(
        width: double.infinity,
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
                Text('🛍️', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(
                  'Ton sac: ${purchasedCandies.length} bonbons',
                  style: TextStyle(
                    color: AppColors.accent2,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            Expanded(
              child:
                  purchasedCandies.isEmpty
                      ? Center(
                        child: Text(
                          'Achète des bonbons avec tes pièces!',
                          style: TextStyle(color: AppColors.grey, fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                      )
                      : Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children:
                            purchasedCandies.asMap().entries.map((entry) {
                              final index = entry.key;
                              final candy = entry.value;
                              return Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.1,
                                      ),
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  candy.emoji,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ).animate().scale(
                                duration: 400.ms,
                                delay: (index * 50).ms,
                                curve: Curves.elasticOut,
                              );
                            }).toList(),
                      ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildWallet() {
    return Obx(() {
      final availableCoins = controller.availableCoins.value;
      final isDragging = controller.isDraggingCoin.value;

      return Container(
        width: double.infinity,
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
            Row(
              children: [
                Text('👛', style: TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Text(
                  'Porte-monnaie: $availableCoins pièces',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Expanded(
              child:
                  availableCoins == 0
                      ? Center(
                        child: Text(
                          'Plus de pièces!',
                          style: TextStyle(
                            color: AppColors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                      : Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: List.generate(availableCoins, (index) {
                          return _buildDraggableCoin(index);
                        }),
                      ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildDraggableCoin(int index) {
    return Draggable<String>(
      data: 'coin',
      onDragStarted: () => controller.onCoinDragStart(),
      feedback: Material(
        color: Colors.transparent,
        child: _buildCoinWidget(isDragging: true),
      ),
      childWhenDragging: _buildCoinWidget(isGhost: true),
      child: _buildCoinWidget(),
    ).animate().scale(
      duration: 300.ms,
      delay: (index * 50).ms,
      curve: Curves.easeOutBack,
    );
  }

  Widget _buildCoinWidget({bool isDragging = false, bool isGhost = false}) {
    return GestureDetector(
      onTap: () => controller.speakCoinsRemaining(),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                isGhost
                    ? [
                      AppColors.grey.withValues(alpha: 0.3),
                      AppColors.lightGrey.withValues(alpha: 0.3),
                    ]
                    : isDragging
                    ? [
                      AppColors.secondary.withValues(alpha: 0.9),
                      AppColors.orangeAccentDark.withValues(alpha: 0.9),
                    ]
                    : [AppColors.secondary, AppColors.orangeAccentDark],
          ),
          shape: BoxShape.circle,
          boxShadow:
              isGhost
                  ? []
                  : [
                    BoxShadow(
                      color: AppColors.orangeAccentDark.withValues(alpha: 0.3),
                      blurRadius: isDragging ? 8 : 4,
                      offset: Offset(0, isDragging ? 4 : 2),
                    ),
                  ],
        ),
        child: Center(
          child: Text('🪙', style: TextStyle(fontSize: isDragging ? 20 : 16)),
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
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent3),
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
                      Icons.shopping_bag,
                      color: AppColors.accent3,
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
                      onPressed: () => controller.replayInstructions(),
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
                Text('🍬✨', style: TextStyle(fontSize: 60)),
                const SizedBox(height: 16),
                Text(
                  'Niveau terminé!',
                  style: TextStyle(
                    color: AppColors.accent3,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Tu as acheté tous les bonbons!',
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
                Text('🎉🍭🎉', style: TextStyle(fontSize: 60)),
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
                  'Tu es un excellent acheteur de bonbons!',
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
    if (itemCount <= 8) return 4;
    return 3;
  }
}
