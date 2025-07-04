import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/rewards/controllers/rewards_controller.dart';
import 'package:le_petit_davinci/features/rewards/widgets/selection_tile.dart';

class CategoryRow extends GetView<RewardsController> {
  const CategoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Obx(
            () => SelectionTile(
              text: 'Mes Étoiles',
              backgroundColor: AppColors.primary,
              isSelected: controller.selectedSection.value == SectionType.stars,
              onTap: () => controller.selectedSection.value = SectionType.stars,
            ),
          ),
        ),
        Gap(12.w),
        Expanded(
          child: Obx(
            () => SelectionTile(
              text: 'Mes Badges',
              backgroundColor: AppColors.accent,
              isSelected:
                  controller.selectedSection.value == SectionType.badges,
              onTap:
                  () => controller.selectedSection.value = SectionType.badges,
            ),
          ),
        ),
        Gap(12.w),
        Expanded(
          child: Obx(
            () => SelectionTile(
              text: 'Mes Titres',
              backgroundColor: AppColors.accent2,
              isSelected:
                  controller.selectedSection.value == SectionType.titles,
              onTap:
                  () => controller.selectedSection.value = SectionType.titles,
            ),
          ),
        ),
      ],
    );
  }
}
