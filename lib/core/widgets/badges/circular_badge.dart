import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';

class CircularBadge extends StatelessWidget {
  const CircularBadge({
    super.key,
    required this.variant,
    this.onTap,
    this.dimension = 70,
    this.unlocked = true,
    this.shadow = true,
  });

  final BadgeVariant variant;
  final VoidCallback? onTap;
  final double dimension;
  final bool unlocked;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unlocked ? onTap : null,
      child: Container(
        width: dimension,
        height: dimension,
        decoration: BoxDecoration(
          color:
              unlocked
                  ? switch (variant) {
                    BadgeVariant.french => AppColors.primary,
                    BadgeVariant.math => AppColors.secondary,
                    BadgeVariant.english => AppColors.accent,
                    BadgeVariant.dailyLife => AppColors.accent3,
                  }
                  : Colors.grey,
          shape: BoxShape.circle,
          boxShadow:
              shadow
                  ? unlocked
                      ? CustomShadowStyle.customCircleShadows(
                        color: switch (variant) {
                          BadgeVariant.french => AppColors.primary,
                          BadgeVariant.math => AppColors.secondary,
                          BadgeVariant.english => AppColors.accent,
                          BadgeVariant.dailyLife => AppColors.accent3,
                        },
                      )
                      : CustomShadowStyle.customDisabledCircleShadows()
                  : null,
        ),
        child:
            unlocked
                ? Center(
                  child: ResponsiveSvgAsset(
                    assetPath: switch (variant) {
                      BadgeVariant.french => SvgAssets.micBlue,
                      BadgeVariant.math => SvgAssets.micYellow,
                      BadgeVariant.english => SvgAssets.micPurple,
                      BadgeVariant.dailyLife => SvgAssets.micPink,
                    },
                    width: dimension * 0.7,
                  ),
                )
                : Stack(
                  children: [
                    Center(
                      child: ResponsiveSvgAsset(
                        assetPath: switch (variant) {
                          BadgeVariant.french => SvgAssets.micBlue,
                          BadgeVariant.math => SvgAssets.micYellow,
                          BadgeVariant.english => SvgAssets.micPurple,
                          BadgeVariant.dailyLife => SvgAssets.micPink,
                        },
                        width: dimension * 0.7,
                        filtered: true,
                      ),
                    ),

                    Center(
                      child: ResponsiveSvgAsset(
                        assetPath: IconAssets.lock,
                        width: dimension * 0.3,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
