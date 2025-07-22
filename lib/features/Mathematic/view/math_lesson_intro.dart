import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';

class MathLessonIntro extends StatelessWidget {
  const MathLessonIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: ProfileHeader(type: ProfileHeaderType.compact),
      body: Placeholder(),
    );
  }
}
