import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/date_utils.dart';
import 'package:le_petit_davinci/core/widgets/layouts/grid_layout.dart';
import 'package:le_petit_davinci/features/rewards/controllers/rewards_controller.dart';
import 'package:le_petit_davinci/features/rewards/widgets/day_tile.dart';
import 'package:le_petit_davinci/features/rewards/widgets/info_display_section.dart';
import 'package:le_petit_davinci/features/rewards/widgets/message_section.dart';

class StarsSection extends GetView<RewardsController> {
  const StarsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const InfoDisplaySection(stars: 16),
        const Gap(AppSizes.spaceBtwItems),

        const MessageSection(
          message:
              "Si tu gagnes 5 étoiles d'ici vendredi, tu débloques un badge surprise !",
        ),
        const Gap(AppSizes.spaceBtwSections),

        CustomGridLayout(
          spacing: 16,
          itemCount: 7,
          itemBuilder: (_, index) {
            final starsPerDay = [3, 4, 1, 3, 2, 2, 2];
            final colorsPerDay = [
              AppColors.accent2,
              AppColors.accent3,
              AppColors.accent,
              AppColors.secondary,
              AppColors.primary,
              AppColors.accent2,
              AppColors.accent3,
            ];
            final activePerDay = [true, true, true, false, false, false, false];
            return DayTile(
              label: DateUtilsHelper.getWeekDayNames()[index],
              starsCount: starsPerDay[index],
              backgroundColor: colorsPerDay[index],
              isActive: activePerDay[index],
            );
          },
        ),
      ],
    );
  }
}
