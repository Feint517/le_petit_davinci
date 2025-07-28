import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/lessons/controllers/lesson_controller.dart';

class LessonProgressBar extends GetView<LessonController> {
  const LessonProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(
                () => Text(
                  controller.currentLesson.value?.title ?? '',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                    fontFamily: 'DynaPuff_SemiCondensed',
                  ),
                ),
              ),
              Obx(
                () => Text(
                  '${(controller.lessonProgress.value * 100).round()}%',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Obx(
            () => LinearProgressIndicator(
              value: controller.lessonProgress.value,
              backgroundColor: AppColors.borderPrimary,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 4.h,
            ),
          ),
        ],
      ),
    );
  }
}
