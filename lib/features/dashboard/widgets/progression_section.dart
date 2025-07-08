import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/string_utils.dart';
import 'package:le_petit_davinci/features/authentication/controllers/user_controller.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/progression_row.dart';

class ProgressionSection extends GetView<UserController> {
  const ProgressionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w400),
            children: [
              const TextSpan(
                text: 'Progression de ',
                style: TextStyle(color: AppColors.black),
              ),
              TextSpan(
                text: StringUtils.capitalize(controller.user.value!.name),
                style: const TextStyle(color: AppColors.primary),
              ),
            ],
          ),
        ),
        const Gap(AppSizes.spaceBtwItems),
        ProgressionRow(
          text: 'Français',
          variant: BadgeVariant.french,
          currentLevel:
              int.tryParse(controller.user.value!.french.progress) ?? 0,
          totalLevels: 5,
        ),
        const Gap(AppSizes.spaceBtwItems),
        ProgressionRow(
          text: 'Mathématiques',
          variant: BadgeVariant.math,
          currentLevel: int.tryParse(controller.user.value!.math.progress) ?? 0,
          totalLevels: 14,
        ),
        const Gap(AppSizes.spaceBtwItems),
        ProgressionRow(
          text: 'Anglais',
          variant: BadgeVariant.english,
          currentLevel:
              int.tryParse(controller.user.value!.english.progress) ?? 0,
          totalLevels: 5,
        ),
        const Gap(AppSizes.spaceBtwItems),
        const ProgressionRow(
          text: 'Vie quotidienne',
          variant: BadgeVariant.dailyLife,
          currentLevel: 4,
          totalLevels: 7,
        ),
      ],
    );
  }
}
