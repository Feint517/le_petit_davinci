import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/assets_manager.dart';
import '../../../../core/constants/colors.dart';
import '../../models/reward_data.dart';

class BadgesCard extends StatelessWidget {
  final List<BadgeData> earnedBadges;

  const BadgesCard({
    super.key,
    required this.earnedBadges,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.purpleAccent,
        borderRadius: BorderRadius.circular(20.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Decorative badge image in bottom right
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              SvgAssets.badgeR,
              height: 80.h,
              width: 80.w,
              fit: BoxFit.contain,
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

  Widget _buildBadgeSlot({
    BadgeData? badge,
    required bool isLocked,
  }) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: isLocked 
            ? AppColors.white.withOpacity(0.3)
            : AppColors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.white.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: badge != null && badge.isEarned
          ? Padding(
              padding: EdgeInsets.all(6.w),
              child: SvgPicture.asset(
                badge.assetPath,
                fit: BoxFit.contain,
              ),
            )
          : Icon(
              isLocked ? Icons.lock : Icons.star_border,
              color: isLocked 
                  ? AppColors.white.withOpacity(0.6)
                  : AppColors.purpleAccent,
              size: 20.sp,
            ),
    );
  }
}