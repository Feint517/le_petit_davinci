import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/features/lessons2/controllers/lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons2/models/lesson_model.dart';

class LessonActivitiesWidget extends GetView<LessonController2> {
  const LessonActivitiesWidget({super.key, required this.activities});

  final List<LessonActivity> activities;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Activities Phase",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Gap(AppSizes.md),
        Text("Activity ${activities.length} will be shown here."),
      ],
    );
  }
}