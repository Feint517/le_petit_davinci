import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/features/lessons2/models/lesson_model.dart';

class LessonCompletionWidget extends StatelessWidget {
  const LessonCompletionWidget({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    // Replace with your actual completion widget
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Congratulations!",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Gap(AppSizes.md),
        Text("You have completed ${lesson.title}."),
      ],
    );
  }
}
