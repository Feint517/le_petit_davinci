import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/services/sfx_service.dart';

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
    // return Container(
    //   height: 120.h, //? Fixed height to prevent Stack sizing issues
    //   decoration: BoxDecoration(
    //     color: backgroundColor,
    //     borderRadius: BorderRadius.circular(16.r),
    //     boxShadow: CustomShadowStyle.customCircleShadows(
    //       color: backgroundColor,
    //     ),
    //   ),
    //   clipBehavior: Clip.antiAlias,
    //   child: Stack(
    //     children: [
    //       //* decorative image
    //       const Positioned(
    //         bottom: 0,
    //         right: 0,
    //         child: ResponsiveImageAsset(
    //           assetPath: SvgAssets.abcHome,
    //           width: 110,
    //         ),
    //       ),

    //       //* Content section
    //       Positioned.fill(
    //         child: Padding(
    //           padding: EdgeInsets.all(16.w),
    //           child: Padding(
    //             padding: EdgeInsets.only(
    //               right: 64.w,
    //             ), // Additional space for decorative image
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     //* Small title
    //                     Text(
    //                       'Mission du jour',
    //                       style: Theme.of(context).textTheme.labelLarge!.apply(
    //                         color: AppColors.white.withValues(alpha: 0.8),
    //                       ),
    //                     ),

    //                     Gap(AppSizes.xs.h),

    //                     // Main mission text
    //                     Text(
    //                       missionDescription,
    //                       style: Theme.of(
    //                         context,
    //                       ).textTheme.titleSmall!.apply(color: AppColors.white),
    //                     ),
    //                   ],
    //                 ),

    //                 CustomButton(
    //                   variant: ButtonVariant.secondary,
    //                   label: 'Accepter la mission',
    //                   width: 160,
    //                   size: ButtonSize.sm,
    //                   onPressed: () {},
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return Container(
      height: 120.h, //? Fixed height to prevent Stack sizing issues
      padding: EdgeInsets.only(top: AppSizes.md, left: AppSizes.md),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: CustomShadowStyle.customCircleShadows(
          color: backgroundColor,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mission du jour',
                style: Theme.of(context).textTheme.labelLarge!.apply(
                  color: AppColors.white.withValues(alpha: 0.8),
                ),
              ),
              Gap(AppSizes.xs.h),
              Text(
                missionDescription,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall!.apply(color: AppColors.white),
              ),
              CustomButton(
                variant: ButtonVariant.secondary,
                label: 'Accepter la mission',
                width: 160,
                size: ButtonSize.sm,
                onPressed: () {
                  AppSfx.click();
                  if (onAcceptMission != null) onAcceptMission!();
                },
              ),
              Spacer(),
            ],
          ),
          ResponsiveImageAsset(assetPath: SvgAssets.abcHome, width: 110),
        ],
      ),
    );
  }
}
