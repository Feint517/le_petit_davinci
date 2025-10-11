import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/features/levels/models/activities/activities.dart';
import 'package:le_petit_davinci/features/levels/models/memory_card_models.dart';

// OLD IMPLEMENTATION - COMMENTED OUT FOR REVERSION
//
class MemoryCardActivityView extends StatelessWidget {
  const MemoryCardActivityView({super.key, required this.activity});

  final MemoryCardActivity activity;

  @override
  Widget build(BuildContext context) {
    return _buildMainContent();
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        _buildStatsRow(),
        const Gap(AppSizes.md),
        Text(
          activity.instruction,
          style: Get.textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const Gap(AppSizes.md),
        Expanded(child: _buildGameArea()),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCornerStat('Moves', '${activity.gameState.value?.moves ?? 0}'),
        _buildCornerStat(
          'Time',
          _formatTime(activity.gameState.value?.timeElapsed ?? 0),
        ),
      ],
    );
  }

  Widget _buildCornerStat(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.sm,
        vertical: AppSizes.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppSizes.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: Get.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: Get.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameArea() {
    return Obx(() {
      final state = activity.gameState.value;

      if (state?.isGameComplete == true) {
        return _buildGameComplete();
      }

      return _buildCardGrid(state!);
    });
  }

  Widget _buildCardGrid(MemoryGameState state) {
    // Calculate grid dimensions based on number of cards
    final cardCount = state.allCards.length;
    int columns = 4;
    if (cardCount <= 8) {
      columns = 4;
    } else if (cardCount <= 12) {
      columns = 4;
    } else {
      columns = 6;
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: AppSizes.sm,
        mainAxisSpacing: AppSizes.sm,
        childAspectRatio: 0.8,
      ),
      itemCount: state.allCards.length,
      itemBuilder: (context, index) {
        final card = state.allCards[index];
        return _buildMemoryCard(card, state);
      },
    );
  }

  Widget _buildMemoryCard(MemoryCard card, MemoryGameState state) {
    final isFlipped = state.flippedCards.contains(card);
    final isMatched = _isCardMatched(card, state);

    return GestureDetector(
      onTap: () => activity.selectCard(card),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.sm),
          color:
              isMatched
                  ? Colors.green.withValues(alpha: 0.3)
                  : AppColors.primary.withValues(alpha: 0.1),
          border: Border.all(
            color:
                isMatched
                    ? Colors.green
                    : AppColors.primary.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child:
              isFlipped || isMatched ? _buildCardBack(card) : _buildCardFront(),
        ),
      ),
    );
  }

  Widget _buildCardFront() {
    return Container(
      key: const ValueKey('front'),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.sm),
        color: AppColors.primary,
      ),
      child: const Center(
        child: Icon(Icons.help_outline, color: Colors.white, size: 32),
      ),
    );
  }

  Widget _buildCardBack(MemoryCard card) {
    return Container(
      key: ValueKey('back_${card.id}'),
      padding: const EdgeInsets.all(AppSizes.sm),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (card.type == CardType.image) ...[
            Expanded(
              child: ResponsiveImageAsset(
                assetPath: card.backContent,
                fit: BoxFit.contain,
              ),
            ),
            if (card.label != null) ...[
              const Gap(AppSizes.xs),
              Text(
                card.label!,
                style: Get.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ] else if (card.type == CardType.text) ...[
            Expanded(
              child: Center(
                child: Text(
                  card.backContent,
                  style: Get.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
          if (card.audioAsset != null) ...[
            const Gap(AppSizes.xs),
            IconButton(
              onPressed: () {
                // TODO: Play audio
              },
              icon: const Icon(Icons.volume_up),
              iconSize: 20,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildGameComplete() {
    final score = activity.getScore();
    final state = activity.gameState.value!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.celebration, size: 64, color: Colors.green),
          const Gap(AppSizes.md),
          Text(
            'Congratulations!',
            style: Get.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          const Gap(AppSizes.sm),
          Text(
            'You completed the memory game!',
            style: Get.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const Gap(AppSizes.md),
          Container(
            padding: const EdgeInsets.all(AppSizes.md),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSizes.sm),
            ),
            child: Column(
              children: [
                Text('Final Score: $score', style: Get.textTheme.titleLarge),
                Text('Moves: ${state.moves}', style: Get.textTheme.bodyLarge),
                Text(
                  'Time: ${_formatTime(state.timeElapsed)}',
                  style: Get.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const Gap(AppSizes.lg),
          // Navigation is now handled by the ActivityNavigationInterface
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// Check if a card is already matched
  bool _isCardMatched(MemoryCard card, MemoryGameState state) {
    for (final pair in state.matchedPairs) {
      if (pair.card1.id == card.id || pair.card2.id == card.id) {
        return true;
      }
    }
    return false;
  }
}
