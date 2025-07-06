import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';
import 'package:le_petit_davinci/features/french/view/lessons.dart';

class IntroductionFrenchLessons extends StatelessWidget {
  const IntroductionFrenchLessons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ResponsiveImageAsset(assetPath: SvgAssets.gamesBackground),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomNavBar(variant: BadgeVariant.french),
                const Gap(15),

                ResponsiveImageAsset(
                  assetPath: SvgAssets.beargames,
                  width: DeviceUtils.getScreenWidth(context) * 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    "🌼 Bienvenue dans le coin des leçons! Ici, on apprendra ensemble le français.",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ),
                CustomButton(
                  label: 'Commencer',
                  width: 200,
                  onPressed:
                      () => Get.to(
                        () => const FrenchLessons(),
                        transition: Transition.rightToLeft,
                        duration: const Duration(milliseconds: 500),
                      ),
                ),
                const Gap(10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
