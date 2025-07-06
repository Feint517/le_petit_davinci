import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';

class InfoDisplaySection extends StatelessWidget {
  const InfoDisplaySection({super.key, required this.stars});

  final int stars;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getScreenWidth(context),
      height: 250,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                stars.toString(),
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 70,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const Gap(AppSizes.spaceBtwItems),
              const ResponsiveImageAsset(
                assetPath: SvgAssets.happyStar,
                width: 50,
              ),
            ],
          ),
          const Gap(AppSizes.spaceBtwItems),
          Text(
            'Tu as gagné ${stars.toString()} étoiles cette semaine !',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
