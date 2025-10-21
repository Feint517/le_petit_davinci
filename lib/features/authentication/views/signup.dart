import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/core/widgets/text_fields/custom_text_field.dart';
import 'package:le_petit_davinci/features/authentication/controllers/signup_controller.dart';
import 'package:le_petit_davinci/features/authentication/views/login.dart';
import 'package:le_petit_davinci/features/authentication/widgets/social_login_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final SignupController signupController = Get.put(SignupController());
  bool showAuth0Options = false;

  @override
  Widget build(BuildContext context) {
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
                        StringsManager.signupText,
                        style: Theme.of(context).textTheme.headlineLarge!.apply(
                          color: AppColors.secondary,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            StringsManager.alreadyHaveAccount,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.black),
                          ),
                          TextButton(
                            onPressed: () => Get.to(() => const LoginScreen()),
                            child: Text(
                              StringsManager.signIn,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .apply(color: AppColors.accent),
                            ),
                          ),
                        ],
                      ),

                      Gap(AppSizes.spaceBtwItems.h),

                      // Signup Options Toggle
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              label: StringsManager.emailSignup,
                              onPressed:
                                  () =>
                                      setState(() => showAuth0Options = false),
                              variant:
                                  showAuth0Options
                                      ? ButtonVariant.ghost
                                      : ButtonVariant.primary,
                            ),
                          ),
                          const Gap(8),
                          Expanded(
                            child: CustomButton(
                              label: StringsManager.socialSignup,
                              onPressed:
                                  () => setState(() => showAuth0Options = true),
                              variant:
                                  showAuth0Options
                                      ? ButtonVariant.primary
                                      : ButtonVariant.ghost,
                            ),
                          ),
                        ],
                      ),

                      Gap(AppSizes.spaceBtwItems.h),

                      // Show appropriate signup form
                      if (!showAuth0Options) ...[
                        // Traditional Email/Password Signup
                        Form(
                          key: signupController.signupFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                type: TextFieldType.text,
                                controller: signupController.firstName,
                                hintText: StringsManager.firstName,
                              ),
                              Gap(AppSizes.spaceBtwInputFields.h),

                              CustomTextField(
                                type: TextFieldType.text,
                                controller: signupController.lastName,
                                hintText: StringsManager.lastName,
                              ),
                              Gap(AppSizes.spaceBtwInputFields.h),

                              CustomTextField(
                                type: TextFieldType.email,
                                controller: signupController.email,
                              ),
                              Gap(AppSizes.spaceBtwInputFields.h),

                              CustomTextField(
                                type: TextFieldType.password,
                                controller: signupController.password,
                              ),
                              Gap(AppSizes.spaceBtwInputFields.h),

                              CustomTextField(
                                type: TextFieldType.password,
                                controller: signupController.confirmPassword,
                                hintText: StringsManager.confirmPassword,
                              ),
                            ],
                          ),
                        ),
                        Gap(AppSizes.spaceBtwSections.h),
                        CustomButton(
                          label: StringsManager.createAccount,
                          onPressed: () => signupController.signup(),
                        ),
                      ] else ...[
                        // Auth0 Social Signup Options
                        Column(
                          children: [
                            // Google Signup
                            Obx(
                              () => SocialLoginButton(
                                onTap: signupController.isGoogleLoading.value
                                    ? () {}
                                    : () => signupController.signupWithGoogle(),
                                icon: Icons.g_mobiledata,
                                label: StringsManager.continueWithGoogle,
                                backgroundColor: Colors.white,
                                textColor: Colors.black87,
                                isLoading: signupController.isGoogleLoading.value,
                              ),
                            ),

                            // Gap(AppSizes.spaceBtwInputFields.h),

                            // Facebook Signup
                            // SocialLoginButton(
                            //   onTap: () {},
                            //   icon: Icons.facebook,
                            //   label: StringsManager.continueWithFacebook,
                            //   backgroundColor: const Color(0xFF1877F2),
                            //   textColor: Colors.white,
                            //   isLoading: false,
                            // ),

                            // Gap(AppSizes.spaceBtwInputFields.h),

                            // // Microsoft Signup
                            // SocialLoginButton(
                            //   onTap: () {},
                            //   icon: Icons.business,
                            //   label: StringsManager.continueWithMicrosoft,
                            //   backgroundColor: const Color(0xFF00BCF2),
                            //   textColor: Colors.white,
                            //   isLoading: false,
                            // ),
                            Gap(AppSizes.spaceBtwInputFields.h),

                            // Divider
                            Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Text(
                                    'OU',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),

                            Gap(AppSizes.spaceBtwInputFields.h),

                            // Universal Signup
                            CustomButton(
                              label: StringsManager.signupWithAuth0,
                              onPressed: () {},
                              variant: ButtonVariant.secondary,
                            ),
                          ],
                        ),
                      ],
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
