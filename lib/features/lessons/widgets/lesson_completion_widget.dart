import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/lessons/controllers/lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons/models/lesson_model.dart';

class LessonCompletionWidget extends GetView<LessonController> {
  final LessonModel lesson;

  const LessonCompletionWidget({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Gap(32.h),

          // Celebration icon
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.celebration, size: 64.sp, color: Colors.green),
          ),

          Gap(24.h),

          // Completion message
          Text(
            lesson.language == LessonLanguage.french
                ? 'Félicitations!'
                : 'Congratulations!',
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              fontFamily: 'DynaPuff_SemiCondensed',
            ),
          ),

          Gap(12.h),

          Text(
            lesson.language == LessonLanguage.french
                ? 'Tu as terminé cette leçon avec succès!'
                : 'You have successfully completed this lesson!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
              height: 1.4,
            ),
          ),

          Gap(32.h),

          // Lesson summary card
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.play_circle_fill,
                              color: Colors.green,
                              size: 32.sp,
                            ),
                            Gap(8.h),
                            Text(
                              lesson.language == LessonLanguage.french
                                  ? 'Vidéo'
                                  : 'Video',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Gap(4.h),
                            Text(
                              lesson.language == LessonLanguage.french
                                  ? 'Terminée'
                                  : 'Completed',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 60.h,
                        color: AppColors.borderPrimary,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Icon(
                              Icons.extension,
                              color: Colors.green,
                              size: 32.sp,
                            ),
                            Gap(8.h),
                            Text(
                              lesson.language == LessonLanguage.french
                                  ? 'Activités'
                                  : 'Activities',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Gap(4.h),
                            Obx(
                              () => Text(
                                '${controller.activityProgressList.where((p) => p.isCompleted).length}/${lesson.activities.length}',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  Gap(24.h),

                  // Final score
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.1),
                          AppColors.secondary.withValues(alpha: 0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        Text(
                          lesson.language == LessonLanguage.french
                              ? 'Score final'
                              : 'Final Score',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Gap(8.h),
                        Obx(
                          () => Text(
                            '${(controller.lessonProgress.value * 100).round()}%',
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              fontFamily: 'DynaPuff_SemiCondensed',
                            ),
                          ),
                        ),
                        Gap(8.h),
                        Obx(
                          () => Text(
                            _getScoreMessage(controller.lessonProgress.value),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: _getScoreColor(
                                controller.lessonProgress.value,
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
          ),

          Gap(32.h),

          // Time spent
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Icon(Icons.schedule, color: AppColors.primary, size: 24.sp),
                  Gap(16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lesson.language == LessonLanguage.french
                              ? 'Temps passé'
                              : 'Time Spent',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Gap(4.h),
                        Obx(
                          () => Text(
                            _getTimeSpentText(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Gap(32.h),

          // Achievements or encouragement
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 24.sp),
                    Gap(8.w),
                    Icon(Icons.star, color: Colors.amber, size: 32.sp),
                    Gap(8.w),
                    Icon(Icons.star, color: Colors.amber, size: 24.sp),
                  ],
                ),
                Gap(16.h),
                Text(
                  lesson.language == LessonLanguage.french
                      ? 'Tu es un super apprenant!'
                      : 'You are a super learner!',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber[700],
                    fontFamily: 'DynaPuff_SemiCondensed',
                  ),
                ),
                Gap(8.h),
                Text(
                  lesson.language == LessonLanguage.french
                      ? 'Continue comme ça et tu apprendras de nouvelles choses incroyables!'
                      : 'Keep it up and you\'ll learn amazing new things!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          Gap(48.h),
        ],
      ),
    );
  }

  String _getScoreMessage(double score) {
    if (score >= 0.9) {
      return lesson.language == LessonLanguage.french
          ? 'Performance exceptionnelle!'
          : 'Outstanding performance!';
    } else if (score >= 0.8) {
      return lesson.language == LessonLanguage.french
          ? 'Excellent travail!'
          : 'Excellent work!';
    } else if (score >= 0.7) {
      return lesson.language == LessonLanguage.french
          ? 'Bon travail!'
          : 'Good work!';
    } else {
      return lesson.language == LessonLanguage.french
          ? 'Continue à t\'améliorer!'
          : 'Keep improving!';
    }
  }

  Color _getScoreColor(double score) {
    if (score >= 0.8) {
      return Colors.green;
    } else if (score >= 0.6) {
      return Colors.orange;
    } else {
      return AppColors.textSecondary;
    }
  }

  String _getTimeSpentText() {
    final startTime = controller.lessonStartTime.value;
    if (startTime == null) {
      return lesson.language == LessonLanguage.french
          ? 'Non disponible'
          : 'Not available';
    }

    final duration = DateTime.now().difference(startTime);
    final minutes = duration.inMinutes;

    if (minutes < 1) {
      return lesson.language == LessonLanguage.french
          ? 'Moins d\'une minute'
          : 'Less than a minute';
    } else if (minutes == 1) {
      return lesson.language == LessonLanguage.french ? '1 minute' : '1 minute';
    } else {
      return lesson.language == LessonLanguage.french
          ? '$minutes minutes'
          : '$minutes minutes';
    }
  }
}
