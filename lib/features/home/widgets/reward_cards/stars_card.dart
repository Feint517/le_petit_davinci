import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/assets_manager.dart';
import '../../../../core/constants/colors.dart';

class StarsCard extends StatelessWidget {
  final int totalStars;
  final int starsThisWeek;

  const StarsCard({
    super.key,
    required this.totalStars,
    required this.starsThisWeek,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.orangeAccent,
        borderRadius: BorderRadius.circular(20.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Decorative star image in bottom right
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              SvgAssets.starR,
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
                  'Mes étoiles',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DynaPuff_SemiCondensed',
                  ),
                ),

                Gap(16.h),

                // Star stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Total stars
                    _buildStatColumn(
                      icon: Icons.star,
                      value: totalStars.toString(),
                      label: 'Total des étoiles',
                    ),

                    // Stars this week
                    _buildStatColumn(
                      icon: Icons.star,
                      value: starsThisWeek.toString(),
                      label: 'Étoiles gagnées\ncette semaine',
                    ),
                  ],
                ),

                Gap(8.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and value row
          Row(
            children: [
              Icon(icon, color: AppColors.white, size: 16.sp),
              Gap(4.w),
              Text(
                value,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DynaPuff_SemiCondensed',
                ),
              ),
            ],
          ),

          Gap(4.h),

          // Label
          Text(
            label,
            style: TextStyle(
              color: AppColors.white.withValues(alpha: 0.9),
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'DynaPuff_SemiCondensed',
            ),
          ),
        ],
      ),
    );
  }
}
