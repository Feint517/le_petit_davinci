import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/core/widgets/misc/mascot_widget_new.dart';
import 'package:le_petit_davinci/features/authentication/controllers/intro_controller.dart';

class QuestionsIntroScreen extends GetView<IntroController> {
  const QuestionsIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(IntroController());
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          SizedBox.expand(
            child: const ResponsiveImageAsset(
              assetPath: ImageAssets.questionBackground,
            ),
          ),
          Positioned(
            top: DeviceUtils.getAppBarHeight(),
            child: ResponsiveImageAsset(
              assetPath: SvgAssets.logoWhite,
              width: DeviceUtils.getScreenWidth() * 0.5,
            ),
          ),
          Positioned(
            bottom: DeviceUtils.getScreenHeight() * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => MascotWidgetNew(
                    speechText: controller.speechText.value,
                    maxBubbleWidth: 100.w,
                  ),
                ),
                const Gap(AppSizes.spaceBtwItems),
                CustomButton(
                  label: 'Continue',
                  variant: ButtonVariant.secondary,
                  onPressed: () => controller.nextMessage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
