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
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/core/widgets/text_fields/custom_text_field.dart';
import 'package:le_petit_davinci/features/authentication/controllers/login_controller.dart';
import 'package:le_petit_davinci/features/authentication/views/create_profile.dart';
import 'package:le_petit_davinci/features/authentication/widgets/social_login_button.dart';

class EnhancedLoginScreen extends StatefulWidget {
  const EnhancedLoginScreen({super.key});

  @override
  State<EnhancedLoginScreen> createState() => _EnhancedLoginScreenState();
}

class _EnhancedLoginScreenState extends State<EnhancedLoginScreen> {
  final LoginController loginController = Get.put(LoginController());
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
                        StringsManager.loginText,
                        style: Theme.of(context).textTheme.headlineLarge!.apply(
                          color: AppColors.secondary,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            StringsManager.newHere,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: AppColors.black),
                          ),
                          TextButton(
                            onPressed: () => Get.to(() => const CreateProfileScreen()),
                            child: Text(
                              StringsManager.createParentAccount,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .apply(color: AppColors.accent),
                            ),
                          ),
                        ],
                      ),

                      Gap(AppSizes.spaceBtwItems.h),

                      // Login Options Toggle
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              label: 'Email Login',
                              onPressed: () => setState(() => showAuth0Options = false),
                              variant: showAuth0Options 
                                  ? ButtonVariant.ghost 
                                  : ButtonVariant.primary,
                            ),
                          ),
                          const Gap(8),
                          Expanded(
                            child: CustomButton(
                              label: 'Social Login',
                              onPressed: () => setState(() => showAuth0Options = true),
                              variant: showAuth0Options 
                                  ? ButtonVariant.primary 
                                  : ButtonVariant.ghost,
                            ),
                          ),
                        ],
                      ),

                      Gap(AppSizes.spaceBtwItems.h),

                      // Show appropriate login form
                      if (!showAuth0Options) ...[
                        // Traditional Email/Password Login
                        Form(
                          key: loginController.loginFormKey,
                          child: Column(
                            children: [
                              CustomTextField(
                                type: TextFieldType.email,
                                controller: loginController.email,
                              ),
                              Gap(AppSizes.spaceBtwInputFields.h),
                              CustomTextField(
                                type: TextFieldType.password,
                                controller: loginController.password,
                              ),
                            ],
                          ),
                        ),
                        Gap(AppSizes.spaceBtwSections.h),
                        CustomButton(
                          label: StringsManager.connect,
                          onPressed: () => loginController.login(),
                        ),
                      ] else ...[
                        // Auth0 Social Login Options
                        Column(
                          children: [
                            // Google Login
                            SocialLoginButton(
                              onTap: () {},
                              icon: Icons.g_mobiledata,
                              label: 'Continue with Google',
                              backgroundColor: Colors.white,
                              textColor: Colors.black87,
                              isLoading: false,
                            ),
                            
                            Gap(AppSizes.spaceBtwInputFields.h),
                            
                            // Facebook Login
                            SocialLoginButton(
                              onTap: () {},
                              icon: Icons.facebook,
                              label: 'Continue with Facebook',
                              backgroundColor: const Color(0xFF1877F2),
                              textColor: Colors.white,
                              isLoading: false,
                            ),
                            
                            Gap(AppSizes.spaceBtwInputFields.h),
                            
                            // Microsoft Login
                            SocialLoginButton(
                              onTap: () {},
                              icon: Icons.business,
                              label: 'Continue with Microsoft',
                              backgroundColor: const Color(0xFF00BCF2),
                              textColor: Colors.white,
                              isLoading: false,
                            ),
                            
                            Gap(AppSizes.spaceBtwInputFields.h),
                            
                            // Divider
                            Row(
                              children: [
                                const Expanded(child: Divider(color: AppColors.textSecondary)),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    'OR',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                                const Expanded(child: Divider(color: AppColors.textSecondary)),
                              ],
                            ),
                            
                            Gap(AppSizes.spaceBtwInputFields.h),
                            
                            // Universal Login
                            CustomButton(
                              label: 'Login with Auth0',
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
