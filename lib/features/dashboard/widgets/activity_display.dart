import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/utils/date_utils.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/chips/subject_chip.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';

class ActivityDisplay extends StatelessWidget {
  const ActivityDisplay({
    super.key,
    required this.variant,
    required this.status,
    required this.title,
    required this.stat,
    required this.activityTime,
  });

  final BadgeVariant variant;
  final ActivityStatus status;
  final String title;
  final String stat;
  final DateTime activityTime;

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
          child: Row(
            spacing: 5,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ResponsiveImageAsset(
                assetPath: switch (status) {
                  ActivityStatus.completed => IconAssets.check,
                  ActivityStatus.started => IconAssets.play,
                },
                width: 14,
              ),
              Text(
                switch (status) {
                  ActivityStatus.completed => 'Complétée',
                  ActivityStatus.started => 'Commencée',
                },
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.apply(color: AppColors.white),
              ),
            ],
          ),
        ),
        Container(
          width: DeviceUtils.getScreenWidth(context),
          height: 120,
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SubjectChip(
                    backgroundColor: _getColor(variant),
                    text: DateUtilsHelper.formatDate(
                      activityTime,
                      pattern: 'dd MMM, hh:mm',
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    stat,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text('Anglais'),
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
