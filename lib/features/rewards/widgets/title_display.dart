import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

class TitleDisplay extends StatelessWidget {
  const TitleDisplay({
    super.key,
    required this.variant,
    required this.title,
    required this.message,
    required this.currentLevel,
    required this.totalLevels,
  });

  final BadgeVariant variant;
  final String title;
  final String message;
  final int currentLevel;
  final int totalLevels;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 130,
          height: 30,
          decoration: BoxDecoration(
            color: _getColor(variant),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
          ),
          child: Center(
            child: Text(
              switch (variant) {
                BadgeVariant.french => 'Français',
                BadgeVariant.math => 'Math',
                BadgeVariant.english => 'Anglais',
                BadgeVariant.dailyLife => 'Vie Quotidienne',
                BadgeVariant.games => 'Jeux',
              },
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.apply(color: AppColors.white),
            ),
          ),
        ),
        Container(
          width: DeviceUtils.getScreenWidth(context),
          height: 150,
          padding: EdgeInsets.all(AppSizes.defaultSpace),
          decoration: BoxDecoration(
            color: AppColors.white,
            border: BoxBorder.all(color: _getColor(variant)),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            boxShadow: CustomShadowStyle.customCircleShadows(
              color: _getColor(variant),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
              Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.w400),
              ),
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
          ),
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
