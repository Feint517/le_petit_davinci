import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/constants/assets_manager.dart';
import '../../../../core/constants/colors.dart';
import '../../models/reward_data.dart';

class TitlesCard extends StatelessWidget {
  final List<SubjectTitleData> subjectTitles;
  final double progressValue;

  const TitlesCard({
    super.key,
    required this.subjectTitles,
    required this.progressValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.greenPrimary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Decorative book image in bottom right
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              SvgAssets.book,
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
            color: AppColors.white.withOpacity(0.9),
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'DynaPuff_SemiCondensed',
          ),
        ),
        
        Gap(8.h),
        
        Container(
          height: 8.h,
          decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.3),
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
            color: AppColors.white.withOpacity(0.8),
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
            fontFamily: 'DynaPuff_SemiCondensed',
          ),
        ),
      ],
    );
  }

  Widget _buildTitlesWrap() {
    final achievedTitles = subjectTitles.where((title) => title.isAchieved).toList();
    
    if (achievedTitles.isEmpty) {
      return Text(
        'Aucun titre obtenu pour le moment',
        style: TextStyle(
          color: AppColors.white.withOpacity(0.8),
          fontSize: 12.sp,
          fontStyle: FontStyle.italic,
          fontFamily: 'DynaPuff_SemiCondensed',
        ),
      );
    }
    
    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      children: achievedTitles.map((title) => _buildTitleChip(title.titleName)).toList(),
    );
  }

  Widget _buildTitleChip(String titleName) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.white.withOpacity(0.4),
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