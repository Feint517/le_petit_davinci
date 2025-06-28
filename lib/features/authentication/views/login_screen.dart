import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button2.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button3.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button4.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/core/widgets/text_fields/custom_text_field.dart';
import 'package:le_petit_davinci/features/authentication/controllers/login_controller.dart';
import 'package:le_petit_davinci/features/authentication/views/error_screen.dart';
import 'package:le_petit_davinci/features/authentication/views/kids_selection_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ResponsiveSvgAsset(assetPath: SvgAssets.loginBackground),
            ),
            Column(
              children: [
                ResponsiveSvgAsset(
                  assetPath: SvgAssets.logoBlue,
                  width: DeviceUtils.getScreenWidth(context) * 0.5,
                ),

                const Gap(AppSizes.defaultSpace * 1.6),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //* Instruction text
                      Text(
                        StringsManager.loginText,
                        style: Theme.of(context).textTheme.headlineLarge!.apply(
                          color: AppColors.secondary,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            StringsManager.newHere,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextButton(
                            onPressed: () => Get.to(() => const ErrorScreen()),
                            child: Text(
                              StringsManager.createParentAccount,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .apply(color: AppColors.accent),
                            ),
                          ),
                        ],
                      ),

                      Gap(AppSizes.spaceBtwItems.h),

                      CustomTextField(
                        type: TextFieldType.email,
                        controller: controller.email,
                      ),
                      Gap(AppSizes.spaceBtwItems.h),
                      CustomTextField(
                        type: TextFieldType.password,
                        controller: controller.password,
                      ),
                      Gap(AppSizes.spaceBtwSections.h),

                      //* Login button
                      CustomButton(
                        label: StringsManager.connect,
                        // onPressed: () {
                        //   Get.to(
                        //     () => KidsSelectionScreen(),
                        //     transition: Transition.rightToLeft,
                        //     duration: const Duration(milliseconds: 500),
                        //   );
                        // },
                      ),

                      Gap(AppSizes.spaceBtwSections.h),

                      CustomButton2(
                        label: 'test',
                        variant: ButtonVariant.primary,
                        onPressed: () {},
                      ),

                      Gap(AppSizes.spaceBtwSections.h),

                      CustomButton3(
                        label: 'test CustomButton 3',
                        variant: ButtonVariant.primary,
                        onPressed: () {},
                      ),

                      Gap(AppSizes.spaceBtwSections.h),

                      CustomButton4(
                        label: 'test CustomButton 4',
                        variant: ButtonVariant.primary,
                        onPressed: () {},
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
}
