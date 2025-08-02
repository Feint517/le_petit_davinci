import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/lessons/controllers/lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons/models/lesson_model.dart';
import 'package:le_petit_davinci/features/video_player/views/video_player.dart';

class LessonVideoWidget extends GetView<LessonController> {
  const LessonVideoWidget({super.key, required this.lesson});

  final LessonModel lesson;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Video player section
          Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Container(
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: 0.1),
                    AppColors.secondary.withValues(alpha: 0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: AppColors.primary.withValues(alpha: 0.1),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () => _openVideoPlayer(),
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: 0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.play_arrow,
                            size: 32.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //* Video completion indicator
                  Obx(
                    () =>
                        controller.isVideoCompleted.value
                            ? Positioned(
                              top: 12.h,
                              right: 12.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check,
                                      color: AppColors.white,
                                      size: 16.sp,
                                    ),
                                    Gap(4.w),
                                    Text(
                                      lesson.language == LessonLanguage.french
                                          ? 'Terminé'
                                          : 'Complete',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),

          Gap(24.h),

          // Completion status or instructions
          Obx(
            () =>
                controller.isVideoCompleted.value
                    ? Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: Colors.green.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 32.sp,
                          ),
                          Gap(12.h),
                          Text(
                            lesson.language == LessonLanguage.french
                                ? 'Excellente vidéo!'
                                : 'Great Video!',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontFamily: 'DynaPuff_SemiCondensed',
                            ),
                          ),
                          Gap(8.h),
                          Text(
                            lesson.language == LessonLanguage.french
                                ? 'Maintenant, passons aux activités amusantes!'
                                : 'Now let\'s move on to the fun activities!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                    : Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.play_circle_outline,
                            color: AppColors.primary,
                            size: 32.sp,
                          ),
                          Gap(12.h),
                          Text(
                            lesson.language == LessonLanguage.french
                                ? 'Regarder la vidéo'
                                : 'Watch the Video',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              fontFamily: 'DynaPuff_SemiCondensed',
                            ),
                          ),
                          Gap(8.h),
                          Text(
                            lesson.language == LessonLanguage.french
                                ? 'Regarde attentivement la vidéo pour débloquer les activités!'
                                : 'Watch the video carefully to unlock the activities!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
          ),
        ],
      ),
    );
  }

  void _openVideoPlayer() {
    Get.to(() => VideoPlayerScreen(videoId: lesson.videoId))?.then((_) {
      // When returning from video player, mark as completed
      controller.markVideoAsCompleted();
    });
  }
}
