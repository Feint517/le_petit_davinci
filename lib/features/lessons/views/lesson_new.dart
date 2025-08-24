import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/lessons/controllers/lesson_controller_new.dart';

class LessonScreen extends GetView<LessonsController> {
  // The view is now simpler and doesn't need to hold data.
  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The Get.put() is now handled by the navigation binding.
    return Scaffold(
      appBar: ProfileHeader(type: ProfileHeaderType.compact),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: Column(
          children: [
            // A progress bar that shows progress through the activities.
            // Obx(
            //   () => LessonProgressBar(
            //     // The progress is based on the number of activities, not total pages.
            //     totalSteps: controller.lessonData.activities.length,
            //     // The current step is the page index minus the intro page.
            //     currentStep: controller.currentPage.value - 1,
            //   ),
            // ),
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