import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressionRow extends StatelessWidget {
  const ProgressionRow({
    super.key,
    required this.text,
    required this.variant,
    required this.currentLevel,
    required this.totalLevels,
  });

  final String text;
  final BadgeVariant variant;
  final int currentLevel, totalLevels;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            LinearPercentIndicator(
              width: 180,
              percent: currentLevel / totalLevels,
              backgroundColor: AppColors.grey,
              progressColor: _getColor(variant),
              barRadius: Radius.circular(10),
              padding: EdgeInsets.all(0),
            ),
            Text('Niveau $currentLevel/$totalLevels'),
          ],
        ),
      ],
    );
  }

  Color _getColor(BadgeVariant badgeVariant) {
    switch (badgeVariant) {
      case BadgeVariant.french:
        return AppColors.primary;
      case BadgeVariant.math:
        return AppColors.secondary;
      case BadgeVariant.english:
        return AppColors.accent;
      case BadgeVariant.dailyLife:
        return AppColors.accent3;
      case BadgeVariant.games:
        return AppColors.secondary;
    }
  }
}
