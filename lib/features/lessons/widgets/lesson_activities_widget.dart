import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/lessons/controllers/lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons/models/lesson_activity_model.dart';
import 'package:le_petit_davinci/features/lessons/models/lesson_model.dart';
import 'package:le_petit_davinci/features/lessons/models/lesson_template_model.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/features/studio/views/drawing_canvas_screen.dart';

class LessonActivitiesWidget extends GetView<LessonController> {
  const LessonActivitiesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final activity = controller.getCurrentActivity();
      if (activity == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            _buildActivityHeader(activity),
            Gap(24.h),
            _buildActivityContent(activity),
            Gap(32.h),
            _buildActivityControls(),
          ],
        ),
      );
    });
  }

  Widget _buildActivityHeader(LessonActivity activity) {
    return Column(
      children: [
        Text(
          activity.title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            fontFamily: 'DynaPuff_SemiCondensed',
          ),
          textAlign: TextAlign.center,
        ),
        Gap(8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            '${activity.estimatedDurationMinutes} minutes',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
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
          children: [
            Text(
              activity.selectionPrompt,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(24.h),
            Wrap(
              spacing: 16.w,
              runSpacing: 16.h,
              alignment: WrapAlignment.center,
              children:
                  activity.items.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    return _buildSelectableItem(item, index);
                  }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectableItem(SelectableItem item, int index) {
    return Obx(() {
      final isSelected = controller.selectedItemIndices.contains(index);

      return GestureDetector(
        onTap: () => controller.toggleItemSelection(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 100.w,
          height: 120.h,
          padding: EdgeInsets.all(8.w),
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

            // Letter selection grid
            if (activity.letters.isNotEmpty)
              Wrap(
                spacing: 12.w,
                runSpacing: 12.h,
                children:
                    activity.letters.map((letterTask) {
                      return _buildLetterCard(letterTask, activity);
                    }).toList(),
              ),

            Gap(24.h),

            // Start drawing button
            ElevatedButton.icon(
              onPressed: () => _startLetterDrawing(activity),
              icon: Icon(Icons.brush, size: 20.sp),
              label: Text(
                controller.currentLesson.value?.language ==
                        LessonLanguage.french
                    ? 'Commencer à dessiner'
                    : 'Start Drawing',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLetterCard(
    LetterDrawingTask letter,
    DrawLettersActivity activity,
  ) {
    return GestureDetector(
      onTap: () => _startSpecificLetterDrawing(letter, activity),
      child: Container(
        width: 80.w,
        height: 80.w,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.primary, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              letter.letter,
              style: TextStyle(
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            Text(
              letter.pronunciation,
              style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  void _startLetterDrawing(DrawLettersActivity activity) {
    // Start with the first letter
    if (activity.letters.isNotEmpty) {
      _startSpecificLetterDrawing(activity.letters.first, activity);
    }
  }

  void _startSpecificLetterDrawing(
    LetterDrawingTask letter,
    DrawLettersActivity activity,
  ) {
    final template = LessonTemplateHelper.createLetterTemplate(
      letter: letter.letter,
      instruction: '${activity.instruction} - ${letter.letter}',
      language:
          controller.currentLesson.value?.language == LessonLanguage.french
              ? 'french'
              : 'english',
    );
    Get.put(StudioController());

    Get.to(
      () => DrawingCanvasScreen(
        template: template,
        isLessonMode: true,
        onComplete: (artworkId) {
          controller.completeCurrentActivity(
            score: 0.9,
            metadata: {'artworkId': artworkId, 'letter': letter.letter},
          );
        },
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

            // Preview of the template
            Container(
              height: 200.h,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.borderPrimary),
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.white,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  activity.templateImagePath,
                  fit: BoxFit.contain,
                  opacity: const AlwaysStoppedAnimation(0.5),
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported,
                            size: 48.sp,
                            color: AppColors.textSecondary,
                          ),
                          Gap(8.h),
                          Text(
                            'Image non disponible',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            Gap(24.h),

            // Start coloring button
            ElevatedButton.icon(
              onPressed: () => _startColoringActivity(activity),
              icon: Icon(Icons.palette, size: 20.sp),
              label: Text(
                controller.currentLesson.value?.language ==
                        LessonLanguage.french
                    ? 'Commencer à colorier'
                    : 'Start Coloring',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.secondary,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startColoringActivity(ColoringTemplateActivity activity) {
    final template = LessonTemplateHelper.createColoringTemplate(
      id: activity.id,
      title: activity.title,
      templatePath: activity.templateImagePath,
      instruction: activity.coloringPrompt,
      suggestedColors: activity.suggestedColors,
    );
    Get.put(StudioController());

    Get.to(
      () => DrawingCanvasScreen(
        template: template,
        isLessonMode: true,
        onComplete: (artworkId) {
          controller.completeCurrentActivity(
            score: 0.9,
            metadata: {'artworkId': artworkId, 'activityId': activity.id},
          );
        },
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
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityControls() {
    final activity = controller.getCurrentActivity();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Skip button (if allowed)
        TextButton(
          onPressed: () => controller.skipToActivities(),
          child: Text(
            controller.currentLesson.value?.language == LessonLanguage.french
                ? 'Passer'
                : 'Skip',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
          ),
        ),

        // Submit/Complete button
        Obx(
          () => ElevatedButton(
            onPressed:
                controller.isActivityCompleted.value
                    ? null
                    : () {
                      if (activity?.type == ActivityType.selectItems) {
                        controller.submitCurrentSelections();
                      }
                      // Drawing activities are completed via callback
                    },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              controller.isActivityCompleted.value
                  ? (controller.currentLesson.value?.language ==
                          LessonLanguage.french
                      ? 'Terminé!'
                      : 'Completed!')
                  : (controller.currentLesson.value?.language ==
                          LessonLanguage.french
                      ? 'Valider'
                      : 'Submit'),
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
