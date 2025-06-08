import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/colors.dart';

class SubjectCard extends StatelessWidget {
  final String label;
  final String imageAssetPath;
  final Color cardColor;
  final VoidCallback? onTap;

  const SubjectCard({
    super.key,
    required this.label,
    required this.imageAssetPath,
    required this.cardColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.85, // Slightly taller than wide
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Decorative bottom-right image
              Positioned(
                bottom: 0,
                right: 0,
                child: SvgPicture.asset(
                  imageAssetPath,
                  height: 80.h,
                  width: 80.w,
                  fit: BoxFit.contain,
                  alignment: Alignment.bottomRight,
                ),
              ),

              // Content area
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top-left circular icon button
                    Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.north_east,
                        color: cardColor,
                        size: 18.sp,
                      ),
                    ),

                    Gap(12.h),

                    // Subject label
                    Text(
                      label,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w100,
                        fontFamily: 'DynaPuff_SemiCondensed',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
