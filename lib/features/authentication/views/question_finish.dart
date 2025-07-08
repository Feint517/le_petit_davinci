import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/features/authentication/controllers/question_finish_controller.dart';
import 'package:le_petit_davinci/features/authentication/widgets/header_message_box.dart';
import 'package:le_petit_davinci/features/authentication/widgets/informational_text_section.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class QuestionFinishScreen extends GetView<QuestionFinishController> {
  const QuestionFinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(QuestionFinishController());
    return Scaffold(
      body: Stack(
        children: [
          //* Background image
          const Positioned(
            bottom: 0,
            child: ResponsiveImageAsset(
              assetPath: SvgAssets.questionsFinishedBackground,
            ),
          ),

          //* Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
              child: Column(
                children: [
                  Gap(30.h),

                  AnimatedBuilder(
                    animation: controller.animationController,
                    builder: (_, __) {
                      return Opacity(
                        opacity: controller.fadeAnimations[0].value,
                        child: Transform.translate(
                          offset: Offset(
                            0,
                            30 * (1 - controller.fadeAnimations[0].value),
                          ),
                          child: const HeaderMessageBox(),
                        ),
                      );
                    },
                  ),
                  Gap(40.h),

                  AnimatedBuilder(
                    animation: controller.animationController,
                    builder: (_, __) {
                      return Opacity(
                        opacity: controller.fadeAnimations[1].value,
                        child: Transform.translate(
                          offset: Offset(
                            0,
                            30 * (1 - controller.fadeAnimations[1].value),
                          ),
                          child: const InformationalTextSection(),
                        ),
                      );
                    },
                  ),
                  Gap(60.h),

                  AnimatedBuilder(
                    animation: controller.animationController,
                    builder: (_, __) {
                      return Opacity(
                        opacity: controller.fadeAnimations[2].value,
                        child: Transform.translate(
                          offset: Offset(
                            0,
                            30 * (1 - controller.fadeAnimations[2].value),
                          ),
                          child: CustomButton(
                            variant: ButtonVariant.secondary,
                            label: StringsManager.discoverMySpace,
                            icon: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16.sp,
                              color: AppColors.white,
                            ),
                            iconPosition: IconPosition.right,
                            onPressed: () {
                              //AuthenticationRepository.instance.completeIntro();
                              Get.offAllNamed(AppRoutes.home);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
