import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';

class StarsCard extends StatelessWidget {
  const StarsCard({
    super.key,
    required this.totalStars,
    required this.starsThisWeek,
    this.backgroundColor = AppColors.orangeAccent,
  });

  final int totalStars;
  final int starsThisWeek;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Color.alphaBlend(
              Colors.black.withValues(alpha: 0.3),
              backgroundColor,
            ),
            spreadRadius: 2,
            blurRadius: 0,
            offset: const Offset(4, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          //* Decorative star image in bottom right
          Positioned(
            bottom: 0,
            right: 0,
            child: ResponsiveSvgAsset(assetPath: SvgAssets.starR, width: 100.w),
          ),

          //* Content area
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
