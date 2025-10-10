import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/features/levels/models/activities/multiple_choice_activity.dart';
import 'package:le_petit_davinci/features/levels/widgets/activity_intro_wrapper.dart';

class MultipleChoiceView extends StatelessWidget {
  const MultipleChoiceView({super.key, required this.activity});

  final MultipleChoiceActivity activity;

  @override
  Widget build(BuildContext context) {
    return ActivityIntroWrapper(
      activity: _buildMainContent(),
      mascotMixin: activity,
    );
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question/Instruction Section
        if (activity.question != null || activity.instruction.isNotEmpty) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppSizes.md),
            margin: const EdgeInsets.only(bottom: AppSizes.lg),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSizes.md),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (activity.question != null) ...[
                  Text(
                    'Question:',
                    style: Get.textTheme.labelMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    activity.question!,
                    style: Get.textTheme.bodyLarge?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
                if (activity.instruction.isNotEmpty) ...[
                  if (activity.question != null) const SizedBox(height: AppSizes.sm),
                  Text(
                    'Instruction:',
                    style: Get.textTheme.labelMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    activity.instruction,
                    style: Get.textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],

        // Options Grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.sm),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: AppSizes.sm,
              mainAxisSpacing: AppSizes.sm,
            ),
            itemCount: activity.options.length,
            itemBuilder: (context, index) {
              return _buildOptionCard(index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOptionCard(int index) {
    final option = activity.options[index];
    
    return Obx(() {
      final isSelected = activity.selectedIndices.contains(index);
      
      return GestureDetector(
        onTap: () => activity.toggleSelection(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected 
                ? AppColors.primary.withValues(alpha: 0.1)
                : AppColors.white,
            borderRadius: BorderRadius.circular(AppSizes.md),
            border: Border.all(
              color: isSelected 
                  ? AppColors.primary
                  : AppColors.lightGrey,
              width: isSelected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image Section
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(AppSizes.sm),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.sm),
                    color: AppColors.lightGrey.withValues(alpha: 0.3),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.sm),
                    child: option.isNetworkImage
                        ? Image.network(
                            option.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildErrorWidget();
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return _buildLoadingWidget();
                            },
                          )
                        : Image.asset(
                            option.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildErrorWidget();
                            },
                          ),
                  ),
                ),
              ),
              
              // Label Section
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.sm,
                    vertical: AppSizes.xs,
                  ),
                  child: Center(
                    child: Text(
                      option.label,
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: isSelected 
                            ? AppColors.primary
                            : AppColors.black,
                        fontWeight: isSelected 
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              
              // Selection Indicator
              if (isSelected)
                Container(
                  width: double.infinity,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(AppSizes.md),
                      bottomRight: Radius.circular(AppSizes.md),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildErrorWidget() {
    return Container(
      color: AppColors.lightGrey.withValues(alpha: 0.5),
      child: const Center(
        child: Icon(
          Icons.image_not_supported,
          color: AppColors.textSecondary,
          size: 32,
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      color: AppColors.lightGrey.withValues(alpha: 0.5),
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }
}
