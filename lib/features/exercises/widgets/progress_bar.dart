import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.progress,
    this.backgroundColor = AppColors.grey,
    this.progressColor = AppColors.primary,
  });

  final double progress;
  final Color backgroundColor;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Container(
        height: 16,
        color: backgroundColor,
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: progress.clamp(0.0, 1.0)),
          duration: const Duration(milliseconds: 400),
          builder: (context, value, child) {
            return Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: value,
                child: Container(color: progressColor),
              ),
            );
          },
        ),
      ),
    );
  }
}
