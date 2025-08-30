import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/lessons/controllers/lesson_controller.dart';

class LessonScreen extends GetView<LessonsController> {
  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProfileHeader(type: ProfileHeaderType.activity),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: Column(
          children: [
            const Gap(AppSizes.spaceBtwSections),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                // The item count is just the number of activities.
                itemCount: controller.lessonData.activities.length,
                itemBuilder: (context, index) {
                  // No more special case for index 0.
                  final activity = controller.lessonData.activities[index];
                  return activity.build(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
