import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/features/levels/models/activities/fill_the_blank_activity.dart';

class FillTheBlankView extends StatelessWidget {
  const FillTheBlankView({super.key, required this.activity});

  final FillTheBlankActivity activity;

  @override
  Widget build(BuildContext context) {
    return _buildMainContent();
  }

  Widget _buildMainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The question
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: AppColors.accent, width: 3),
                ),
              ),
              child: Center(
                child: Obx(() {
                  final selected = activity.selectedIndex.value;
                  return Text(
                    selected != null
                        ? activity.options[selected].optionText
                        : '',
                    style: Get.textTheme.bodyMedium?.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }),
              ),
            ),
            Text(
              ' ${activity.questionSuffix}',
              style: Get.textTheme.bodyMedium?.copyWith(color: AppColors.black),
            ),
          ],
        ),
        const Gap(140),
        // Choices
        Expanded(
          child: Column(
            children: List.generate(activity.options.length, (index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.spaceBtwItems),
                child: Obx(
                  () => GestureDetector(
                    onTap: () => activity.selectOption(index),

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: DeviceUtils.getScreenWidth(),
                      height: 45,
                      decoration: BoxDecoration(
                        color:
                            activity.selectedIndex.value == index
                                ? AppColors.accent
                                : AppColors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: CustomShadowStyle.customCircleShadows(
                          color:
                              activity.selectedIndex.value == index
                                  ? AppColors.accent
                                  : AppColors.white,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          activity.options[index].optionText,
                          style: Get.textTheme.bodyLarge?.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
