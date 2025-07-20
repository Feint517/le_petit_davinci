import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/features/home/models/reward_data.dart';

class BadgesCard extends StatelessWidget {
  const BadgesCard({
    super.key,
    this.backgroundColor = AppColors.purpleAccent,
    required this.earnedBadges,
  });

  final Color backgroundColor;
  final List<BadgeData> earnedBadges;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: CustomShadowStyle.customCircleShadows(
          color: backgroundColor,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Decorative badge image in bottom right
          Positioned(
            bottom: 0,
            right: 0,
            child: ResponsiveImageAsset(
              assetPath: SvgAssets.badgeR,
              width: 70.w,
            ),
          ),

          // Content area
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'Mes badges',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DynaPuff_SemiCondensed',
                  ),
                ),

                Gap(16.h),

                // Badges grid
                _buildBadgesGrid(),

                Gap(8.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgesGrid() {
    // Create a fixed number of badge slots (6 total)
    const int totalSlots = 6;

    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: List.generate(totalSlots, (index) {
        final hasEarnedBadge = index < earnedBadges.length;
        final badge = hasEarnedBadge ? earnedBadges[index] : null;

        return _buildBadgeSlot(
          badge: badge,
          isLocked: !hasEarnedBadge || !(badge?.isEarned ?? false),
        );
      }),
    );
  }

  Widget _buildBadgeSlot({BadgeData? badge, required bool isLocked}) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color:
            isLocked
                ? AppColors.white.withValues(alpha: 0.3)
                : AppColors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child:
          badge != null && badge.isEarned
              ? Padding(
                padding: EdgeInsets.all(6.w),
                child: ResponsiveImageAsset(assetPath: badge.assetPath),
              )
              : Icon(
                isLocked ? Icons.lock : Icons.star_border,
                color:
                    isLocked
                        ? AppColors.white.withValues(alpha: 0.6)
                        : AppColors.purpleAccent,
                size: 20.sp,
              ),
    );
  }
}
