import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/features/authentication/views/user_selection_screen.dart';
import 'package:le_petit_davinci/features/authentication/widgets/header_vector.dart';
import 'package:le_petit_davinci/features/authentication/widgets/pin_box.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        top: false,
        child: Stack(
          children: [
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ResponsiveSvgAsset(assetPath: SvgAssets.errorBackground),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Positioned(
                  top: 0,
                  child: HeaderVector(color: HeaderVectorColor.green),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.defaultSpace,
                  ),
                  child: Column(
                    children: [
                      const Gap(AppSizes.defaultSpace * 1.5),
                      Text(
                        StringsManager.noProfileError,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineLarge!.apply(
                          color: AppColors.secondary,
                        ),
                      ),

                      const Gap(AppSizes.defaultSpace),

                      CustomButton(
                        label: StringsManager.back,
                        onPressed:
                            () => Get.offAll(() => const UserSelectionScreen()),
                      ),

                      const Gap(AppSizes.spaceBtwItems),

                      CustomButton(
                        variant: ButtonVariant.secondary,
                        label: StringsManager.createChildProfile,
                        onPressed: () => _showBottomSheet(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const PinBox(isExpanded: true),
    );
  }
}
