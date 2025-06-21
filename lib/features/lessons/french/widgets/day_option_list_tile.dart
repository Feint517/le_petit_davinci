import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/lessons/french/controllers/construction_introduction_lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons/french/views/construction_lesson.dart';

class DayOption extends GetView<ConstructionIntroductionLessonController> {
  const DayOption(this.option, this.day, {super.key});

  final String option;
  final int day;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.changeSelectedDay(day);
        Navigator.pop(context);
        Get.to(
          () => ConstructionLesson(day: controller.selectedDay.value),
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 500),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColors.primary, width: 1),
        ),
        child: Row(
          children: [
            //* Day number circle
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  day.toString(),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.apply(color: AppColors.white),
                ),
              ),
            ),
            const Gap(12),
            //* Lesson label
            Expanded(
              child: Text(
                option,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            //* Arrow icon
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
