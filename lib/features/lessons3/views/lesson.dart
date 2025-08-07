import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/lessons3/controllers/lessons_controller.dart';
import 'package:le_petit_davinci/features/lessons3/models/activity_model.dart';
import 'package:le_petit_davinci/features/lessons3/views/introduction_view.dart';

class LessonScreen3 extends GetView<LessonsController3> {
  const LessonScreen3({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    Get.put(LessonsController3(lessonData: lesson));
    return Scaffold(
      appBar: ProfileHeader(type: ProfileHeaderType.compact),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: Obx(() {
          if (!controller.isLessonStarted.value) {
            return IntroductionView(
              lesson: controller.lessonData,
              onStart: controller.beginActivities,
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.lessonData.activities.length,
                    itemBuilder: (context, index) {
                      final activity = controller.lessonData.activities[index];
                      return activity.build(context);
                    },
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
