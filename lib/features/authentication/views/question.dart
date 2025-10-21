import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/checkbox_widget.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/features/authentication/widgets/question_widget.dart';
import 'package:le_petit_davinci/features/authentication/controllers/questions_controller.dart';
import 'package:get/get.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use lazyPut with fenix to prevent multiple instances
    Get.lazyPut(() => QuestionsController(), fenix: true);
    final controller = Get.find<QuestionsController>();
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          //* Fullscreen background image
          SizedBox.expand(
            child: Image.asset(
              ImageAssets.questionBackground,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            bottom: DeviceUtils.getScreenHeight() * 0.3,
            child: Obx(() {
              final question =
                  controller.questions[controller.currentIndex.value];
              final selected =
                  controller.answers[controller.currentIndex.value];
              return Container(
                width: 0.9.sw,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    QuestionWidget(
                      questionNumber: controller.currentIndex.value + 1,
                      questionText: question.questionText,
                    ),
                    Gap(20.h),

                    ...List.generate(
                      question.options.length,
                      (i) => CheckboxWidget(
                        title: question.options[i].title,
                        subtitle: question.options[i].subtitle,
                        //icon: question.options[i].iconWidget,
                        isSelected: selected == question.options[i].value,
                        onTap: () {
                          controller.answers[controller.currentIndex.value] =
                              question.options[i].value;
                        },
                      ),
                    ),
                    Gap(20.h),
                    CustomButton(
                      variant: ButtonVariant.secondary,
                      label:
                          controller.currentIndex.value <
                                  controller.questions.length - 1
                              ? "Continuer"
                              : "Terminer",
                      onPressed: () {
                        controller.checkIfQuestionAnswered();
                      },
                      size: ButtonSize.lg,
                      width: double.infinity,
                    ),
                  ],
                ),
              );
            }),
          ),
          Positioned(
            bottom: DeviceUtils.getBottomNavigationBarHeight(),
            right: DeviceUtils.getScreenWidth() * 0.1,
            child: ResponsiveImageAsset(
              assetPath: SvgAssets.bearMasscot,
              width: DeviceUtils.getScreenWidth() * 0.4,
            ),
          ),
        ],
      ),
    );
  }
}
