import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/features/home/models/reward_data.dart';

class TitlesCard extends StatelessWidget {
  const TitlesCard({
    super.key,
    required this.subjectTitles,
    required this.progressValue,
    this.backgroundColor = AppColors.greenPrimary,
  });

  final List<SubjectTitleData> subjectTitles;
  final double progressValue;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: CustomShadowStyle.customCircleShadows(color:backgroundColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          //* Decorative book image in bottom right
          Positioned(
            bottom: 0,
            right: 0,
            child: ResponsiveSvgAsset(assetPath: SvgAssets.book, width: 110.w),
          ),

          //* Content area
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'Mes titres par matière',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DynaPuff_SemiCondensed',
                  ),
                ),

                Gap(16.h),

                // Progress bar
                _buildProgressBar(),

                Gap(12.h),

                // Achieved titles
                _buildTitlesWrap(),

                Gap(8.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progression générale',
          style: TextStyle(
            color: AppColors.white.withValues(alpha: 0.9),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'DynaPuff_SemiCondensed',
          ),
        ),

        Gap(8.h),

        Container(
          height: 8.h,
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: FractionallySizedBox(
            widthFactor: progressValue,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),

        Gap(4.h),

        Text(
          '${(progressValue * 100).toInt()}% complété',
          style: TextStyle(
            color: AppColors.white.withValues(alpha: 0.8),
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            fontFamily: 'DynaPuff_SemiCondensed',
          ),
        ),
      ],
    );
  }

  Widget _buildTitlesWrap() {
    final achievedTitles =
        subjectTitles.where((title) => title.isAchieved).toList();

    if (achievedTitles.isEmpty) {
      return Text(
        'Aucun titre obtenu pour le moment',
        style: TextStyle(
          color: AppColors.white.withValues(alpha: 0.8),
          fontSize: 12.sp,
          fontStyle: FontStyle.italic,
          fontFamily: 'DynaPuff_SemiCondensed',
        ),
      );
    }

    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      children:
          achievedTitles
              .map((title) => _buildTitleChip(title.titleName))
              .toList(),
    );
  }

  Widget _buildTitleChip(String titleName) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: Text(
        titleName,
        style: TextStyle(
          color: AppColors.white,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'DynaPuff_SemiCondensed',
        ),
      ),
    );
  }
}
