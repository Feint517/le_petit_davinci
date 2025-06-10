import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';

class LessonInfo extends StatelessWidget {
  const LessonInfo({
    super.key,
    required this.lessonName,
    required this.lessonDescription,
  });

  final String lessonName;
  final String lessonDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(lessonName),
        Gap(AppSizes.spaceBtwItems / 2),
        Text(lessonDescription),
      ],
    );
  }
}