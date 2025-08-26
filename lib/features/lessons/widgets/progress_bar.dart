import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';

class LessonProgressBar extends StatelessWidget implements PreferredSizeWidget {
  const LessonProgressBar({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  final int totalSteps;
  final int currentStep;

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());

  @override
  Widget build(BuildContext context) {
    //? The progress is the number of completed steps divided by the total.
    final double progress = totalSteps > 0 ? currentStep / totalSteps : 0;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: progress),
      duration: const Duration(milliseconds: 300),
      builder: (context, animatedValue, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: animatedValue,
            minHeight: 10,
            backgroundColor: AppColors.grey.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        );
      },
    );
  }
}