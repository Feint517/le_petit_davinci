import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/features/lessons/controllers/lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons/models/lesson_activity_model.dart';
import 'package:le_petit_davinci/features/lessons/models/lesson_model.dart';

class LessonActivitiesWidget extends GetView<LessonController> {
  const LessonActivitiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final activity = controller.getCurrentActivity();
      if (activity == null) {
        return Center(
          child: Text(
            controller.currentLesson.value?.language == LessonLanguage.french
                ? 'Aucune activité disponible'
                : 'No activities available',
            style: TextStyle(fontSize: 16.sp, color: AppColors.textSecondary),
          ),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(AppSizes.spaceBtwSections),
          ActivityIntroduction(activity: activity),

          Gap(24.h),

          // Activity content based on type
          _buildActivityContent(activity),

          Gap(24.h),

          // Activity completion status
          if (controller.isActivityCompleted.value)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: Column(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 32.sp),
                  Gap(12.h),
                  Text(
                    controller.currentLesson.value?.language ==
                            LessonLanguage.french
                        ? 'Activité terminée!'
                        : 'Activity Complete!',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                      fontFamily: 'DynaPuff_SemiCondensed',
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    '${controller.currentLesson.value?.language == LessonLanguage.french ? "Score" : "Score"}: ${(controller.currentActivityScore.value * 100).round()}%',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    });
  }

  Widget _buildActivityContent(LessonActivity activity) {
    switch (activity.type) {
      case ActivityType.selectItems:
        return _buildSelectItemsActivity(activity as SelectItemsActivity);
      case ActivityType.drawLetters:
        return _buildDrawingActivity(activity as DrawLettersActivity);
      case ActivityType.coloringTemplate:
        return _buildColoringActivity(activity as ColoringTemplateActivity);
      default:
        return _buildComingSoonActivity(activity);
    }
  }

  Widget _buildSelectItemsActivity(SelectItemsActivity activity) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity.selectionPrompt,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Gap(16.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                childAspectRatio: 1.2,
              ),
              itemCount: activity.items.length,
              itemBuilder: (context, index) {
                final item = activity.items[index];
                return _buildSelectableItem(item, index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectableItem(SelectableItem item, int index) {
    return Obx(() {
      final selectedIndices = controller.selectedItemIndices;
      final isSelected = selectedIndices.contains(index);

      return GestureDetector(
        onTap: () => controller.toggleItemSelection(index),
        child: Container(
          decoration: BoxDecoration(
            color:
                isSelected
                    ? AppColors.primary.withValues(alpha: 0.1)
                    : AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.borderPrimary,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (item.imagePath.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: Image.asset(
                    item.imagePath,
                    width: 60.w,
                    height: 60.w,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          color: AppColors.borderPrimary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.image,
                          color: AppColors.textSecondary,
                          size: 24.sp,
                        ),
                      );
                    },
                  ),
                ),
              Gap(8.h),
              Text(
                item.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
              if (isSelected)
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Icon(
                    Icons.check_circle,
                    color: AppColors.primary,
                    size: 16.sp,
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildDrawingActivity(DrawLettersActivity activity) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Text(
              controller.currentLesson.value?.language == LessonLanguage.french
                  ? 'Dessine les lettres que tu as apprises!'
                  : 'Draw the letters you learned!',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Gap(16.h),
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderPrimary),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Center(child: Text('Drawing Canvas Coming Soon')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColoringActivity(ColoringTemplateActivity activity) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Text(
              activity.coloringPrompt,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Gap(16.h),
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderPrimary),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: const Center(child: Text('Coloring Canvas Coming Soon')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComingSoonActivity(LessonActivity activity) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.all(40.w),
        child: Column(
          children: [
            Icon(
              Icons.build_circle_outlined,
              size: 48.sp,
              color: AppColors.textSecondary,
            ),
            Gap(16.h),
            Text(
              controller.currentLesson.value?.language == LessonLanguage.french
                  ? 'Cette activité arrive bientôt!'
                  : 'This activity is coming soon!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            Gap(12.h),
            ElevatedButton(
              onPressed: () {
                // Mark as completed with a default score
                controller.completeCurrentActivity(score: 0.8);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                controller.currentLesson.value?.language ==
                        LessonLanguage.french
                    ? 'Marquer comme terminé'
                    : 'Mark as Complete',
                style: TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityIntroduction extends GetView<LessonController> {
  const ActivityIntroduction({super.key, required this.activity});

  final LessonActivity? activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: CustomShadowStyle.customCircleShadows(
          color: AppColors.white,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                switch (activity?.type) {
                  ActivityType.selectItems => Icons.touch_app,
                  ActivityType.drawLetters => Icons.draw,
                  ActivityType.matchPairs => Icons.link,
                  ActivityType.sequenceOrder => Icons.reorder,
                  ActivityType.coloringTemplate => Icons.palette,
                  null => Icons.help_outline,
                },
                color: AppColors.primary,
                size: 24.sp,
              ),
              Gap(AppSizes.md.h),
              Text(
                activity?.title ?? '',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          Gap(8.h),
          Text(
            activity?.instruction ?? '',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
