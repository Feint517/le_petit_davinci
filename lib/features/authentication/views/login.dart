import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/core/widgets/text_fields/custom_text_field.dart';
import 'package:le_petit_davinci/features/authentication/controllers/login_controller.dart';
import 'package:le_petit_davinci/features/authentication/views/create_profile.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
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
              child: ResponsiveImageAsset(assetPath: SvgAssets.loginBackground),
            ),
            Column(
              children: [
                ResponsiveImageAsset(
                  assetPath: SvgAssets.logoBlue,
                  width: DeviceUtils.getScreenWidth() * 0.5,
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
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          TextButton(
                            onPressed:
                                () => Get.to(() => const CreateProfileScreen()),
                            child: Text(
                              StringsManager.createParentAccount,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .apply(color: AppColors.accent),
                            ),
                          ),
                        ],
                      ),

                      Gap(AppSizes.spaceBtwItems.h),

                      Form(
                        key: controller.loginFormKey,
                        child: Column(
                          children: [
                            CustomTextField(
                              type: TextFieldType.email,
                              controller: controller.email,
                            ),
                            Gap(AppSizes.spaceBtwInputFields.h),

                            CustomTextField(
                              type: TextFieldType.password,
                              controller: controller.password,
                            ),
                          ],
                        ),
                      ),

                      Gap(AppSizes.spaceBtwSections.h),

                      //* Login button
                      CustomButton(
                        label: StringsManager.connect,
                        onPressed: () => controller.login(),
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
