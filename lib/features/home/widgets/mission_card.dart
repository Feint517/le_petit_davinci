import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/buttons/buttons.dart';

class MissionCard extends StatelessWidget {
  const MissionCard({
    super.key,
    required this.missionDescription,
    this.backgroundColor = AppColors.pinkAccent,
    this.onAcceptMission,
  });

  final String missionDescription;
  final Color backgroundColor;
  final VoidCallback? onAcceptMission;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.h, //? Fixed height to prevent Stack sizing issues
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: CustomShadowStyle.customCircleShadows(
          color: backgroundColor,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          //* decorative image
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              SvgAssets.abcHome,
              height: 70.h,
              width: 80.w,
              fit: BoxFit.contain,
              alignment: Alignment.bottomRight,
            ),
          ),

          //* Content section
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.all(16.w), // Apply padding only to content
              child: Padding(
                padding: EdgeInsets.only(
                  right: 64.w,
                ), // Additional space for decorative image
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //* Small title
                        Text(
                          'Mission du jour',
                          style: TextStyle(
                            color: AppColors.white.withValues(alpha: 0.8),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DynaPuff_SemiCondensed',
                          ),
                        ),

                        Gap(4.h),

                        // Main mission text
                        Text(
                          missionDescription,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DynaPuff_SemiCondensed',
                          ),
                        ),
                      ],
                    ),

                    // Action button - smaller and left-aligned
                    SizedBox(
                      width: 160.w, // Limit button width to about half the card
                      child: PillButton(
                        label: 'Accepter la mission',
                        onPressed: onAcceptMission,
                        variant: ButtonVariant.secondary, // Orange variant
                        size: ButtonSize.sm, // Smaller size
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
