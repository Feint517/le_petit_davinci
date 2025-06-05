import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';

class AchievementBanner extends StatelessWidget {
  final String title;
  final int starCount;
  final VoidCallback? onRewardsPressed;

  const AchievementBanner({
    super.key,
    required this.title,
    this.starCount = 5,
    this.onRewardsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        top: 8.h,
        bottom: 0,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left Section - Achievement Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    color: AppColors.greenPrimary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'DynaPuff_SemiCondensed',
                  ),
                ),
                
                Gap(4.h),
                
                // Star Rating
                Row(
                  children: List.generate(
                    starCount,
                    (index) => Padding(
                      padding: EdgeInsets.only(right: 2.w),
                      child: Icon(
                        Icons.star,
                        color: AppColors.orangeAccent,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Right Section - Rewards Button
          _buildRewardsButton(),
        ],
      ),
    );
  }

  Widget _buildRewardsButton() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Button container (placed first so gift icon appears on top)
        InkWell(
          onTap: onRewardsPressed ?? () {},
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            padding: EdgeInsets.only(
              left: 28.w,
              right: 12.w,
              top: 8.h,
              bottom: 8.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.greenPrimary,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Text
                Text(
                  'Mes récompenses',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'DynaPuff_SemiCondensed',
                  ),
                ),
                
                Gap(4.w),
                
                // Arrow Icon
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.white,
                  size: 12.sp,
                ),
              ],
            ),
          ),
        ),
        
        // Gift icon positioned on top
        Positioned(
          left: -6.w,
          top: -8.h,
          child: SvgPicture.asset(
            SvgAssets.gift,
            height: 32.h,
            width: 32.w,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
