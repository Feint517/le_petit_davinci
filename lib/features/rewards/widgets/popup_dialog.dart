import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/badges/circular_badge.dart';
import 'package:le_petit_davinci/core/widgets/chips/subject_chip.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';

class PopupDialog extends StatelessWidget {
  const PopupDialog({
    super.key,
    required this.title,
    required this.description,
    required this.variant,
  });

  final String title;
  final String description;
  final BadgeVariant variant;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getScreenWidth(context) * 0.9,
      height: DeviceUtils.getScreenHeight() * 0.5,

      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(AppSizes.defaultSpace),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SubjectChip(
                  backgroundColor: switch (variant) {
                    BadgeVariant.french => AppColors.primary,
                    BadgeVariant.math => AppColors.secondary,
                    BadgeVariant.english => AppColors.accent,
                    BadgeVariant.dailyLife => AppColors.accent3,
                  },
                  text: switch (variant) {
                    BadgeVariant.french => 'En Français',
                    BadgeVariant.math => 'En Mathematiques',
                    BadgeVariant.english => 'En Anglais',
                    BadgeVariant.dailyLife => 'En Vie Quotidienne',
                  },
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: ResponsiveSvgAsset(
                    assetPath: SvgAssets.cross,
                    width: 35,
                  ),
                ),
              ],
            ),
          ),
          CircularBadge(dimension: 100, variant: variant, shadow: false),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300),
          ),
          const Gap(AppSizes.defaultSpace * 2),
          const Spacer(),
          ResponsiveSvgAsset(
            assetPath: SvgAssets.happyMasscots,
            width: DeviceUtils.getScreenWidth(context) * 0.81,
          ),
        ],
      ),
    );
  }
}