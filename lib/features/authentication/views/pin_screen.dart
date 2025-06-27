import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/features/authentication/controllers/pin_entry_controller.dart';
import 'package:le_petit_davinci/features/authentication/widgets/pin_box.dart';

class PinEntryScreen extends GetView<PinEntryController> {
  const PinEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 0,
              child: const ResponsiveSvgAsset(
                assetPath: SvgAssets.pinBackground,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ResponsiveSvgAsset(
                  assetPath: SvgAssets.logoBlue,
                  width: DeviceUtils.getScreenWidth(context) * 0.5,
                ),

                const Gap(AppSizes.defaultSpace * 1.4),

                const PinBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
