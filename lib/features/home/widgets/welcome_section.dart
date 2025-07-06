import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/core/widgets/misc/mascot_widget_old.dart';
import 'package:le_petit_davinci/features/home/widgets/achievement_banner.dart';
import 'package:le_petit_davinci/features/home/widgets/mission_card.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AchievementBanner(starCount: 4),
        Gap(AppSizes.spaceBtwItems.h),
        Stack(
          alignment: Alignment.topCenter,
          children: [
            //* Background homeScreen image
            const ResponsiveImageAsset(assetPath: SvgAssets.homeScreenImage),

            //* Mascot widget positioned in center-right, slightly top
            Align(
              alignment: Alignment(0.8, -0.8),
              child: MascotWidget(
                speechText: StringsManager.homeScreenMessage,
                mascotSize: 150.h,
                textSize: 18.sp,
                bubblePosition: BubblePosition.center,
              ),
            ),

            //* Mission Card positioned slightly below center
            Align(
              widthFactor: 4,
              heightFactor: 2.1,
              alignment: Alignment(0, 4),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: const MissionCard(
                  missionDescription: 'Trouve 5 mots qui riment !',
                ),
              ),
            ),
          ],
        ),
        Gap(36.h),
      ],
    );
  }
}
