import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/features/exercises/controllers/victory_controller.dart';
import 'package:le_petit_davinci/features/exercises/widgets/stars_section.dart';

class VictoryScreen extends GetView<VictoryController> {
  const VictoryScreen({super.key, required this.starsCount});

  final int starsCount;

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
              child: ResponsiveImageAsset(
                assetPath: SvgAssets.gamesBackground,
                width: DeviceUtils.getScreenWidth(),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              child: SizedBox.expand(
                child: Column(
                  spacing: 20,
                  children: [
                    const Gap(AppSizes.spaceBtwSections * 2),
                    Text(
                      'Level Completed!',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const ResponsiveImageAsset(
                      assetPath: SvgAssets.bear1,
                      width: 200,
                    ),
                    const Gap(AppSizes.spaceBtwSections),
                    StarsSection(starsCount: starsCount),
                    const Spacer(),
                    CustomButton(
                      label: 'Continue',
                      onPressed: () => controller.navigateToMapScreen(),
                    ),
                    Gap(DeviceUtils.getBottomNavigationBarHeight()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
