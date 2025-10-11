import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';
import 'package:le_petit_davinci/features/levels/widgets/exit_level_modal.dart';

class LevelProgressBar extends StatelessWidget implements PreferredSizeWidget {
  const LevelProgressBar({super.key});

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LevelController>();
    return Obx(() {
      final totalSteps = controller.totalItems;
      final currentStep = controller.currentIndex.value + 1;
      //? The progress is the number of completed steps divided by the total.
      final double progress = totalSteps > 0 ? currentStep / totalSteps : 0;

      return Row(
        children: [
          // Cancel button
          GestureDetector(
            onTap: () => _showExitConfirmation(context, controller),
            child: const Icon(Icons.close, color: Colors.black, size: 20),
          ),
          const Gap(AppSizes.md),
          // Progress section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Progress text
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress',
                      style: Get.textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '$currentStep / $totalSteps',
                      style: Get.textTheme.bodySmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Gap(AppSizes.xs),
                // Enhanced progress bar
                _buildEnhancedProgressBar(progress),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget _buildEnhancedProgressBar(double progress) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: progress),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      builder: (context, animatedValue, child) {
        return Container(
          height: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.grey.withValues(alpha: 0.2),
          ),
          child: Stack(
            children: [
              // Background
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: AppColors.grey.withValues(alpha: 0.2),
                ),
              ),
              // Progress fill with gradient
              FractionallySizedBox(
                widthFactor: animatedValue,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, Color(0xFF1AB1FF)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
              // Shimmer effect
              if (animatedValue > 0)
                FractionallySizedBox(
                  widthFactor: animatedValue,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.0),
                          Colors.white.withValues(alpha: 0.3),
                          Colors.white.withValues(alpha: 0.0),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _showExitConfirmation(BuildContext context, LevelController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => ExitLevelModal(
            onCancel: () => Navigator.of(context).pop(),
            onExit: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
          ),
    );
  }
}
