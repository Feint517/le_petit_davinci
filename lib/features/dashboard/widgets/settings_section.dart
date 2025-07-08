import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/dashboard/controllers/dashboard_controller.dart';
import 'package:le_petit_davinci/features/home/widgets/section_heading.dart';

class SettingsSection extends GetView<DashboardController> {
  const SettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(sectionName: 'Paramètres'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Modifier le code PIN parental'),
            CustomButton(label: 'Changer', width: 80),
          ],
        ),

        const Gap(AppSizes.spaceBtwItems),
        const Divider(color: AppColors.grey, thickness: 1.5),
        const Gap(AppSizes.spaceBtwItems),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Gérer les enfants'),
            CustomButton(label: 'Gérer', width: 80),
          ],
        ),
        const Gap(AppSizes.spaceBtwItems),
        const Divider(color: AppColors.grey, thickness: 1.5),
        const Gap(AppSizes.spaceBtwItems),
        Text('Langue préférée'),
        Obx(
          () => Row(
            children: [
              Radio<String>(
                activeColor: AppColors.primary,
                value: 'fr',
                groupValue: controller.selectedPrefferedLanguage.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedPrefferedLanguage.value = value;
                  }
                },
              ),
              const Text('Français'),
              const Gap(16),
              Radio<String>(
                activeColor: AppColors.primary,
                value: 'en',
                groupValue: controller.selectedPrefferedLanguage.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedPrefferedLanguage.value = value;
                  }
                },
              ),
              const Text('Anglais'),
              const Gap(16),
              Radio<String>(
                activeColor: AppColors.primary,
                value: 'both',
                groupValue: controller.selectedPrefferedLanguage.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedPrefferedLanguage.value = value;
                  }
                },
              ),
              const Text('Les deux'),
            ],
          ),
        ),
        const Divider(color: AppColors.grey, thickness: 1.5),
        const Gap(AppSizes.spaceBtwItems),
        Text("Réinitialiser l'app ou supprimer un profil (code requis)"),
        const Gap(AppSizes.spaceBtwItems),
        Column(
          spacing: AppSizes.spaceBtwItems,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    label: 'Réinitialiser',
                    variant: ButtonVariant.primary,
                  ),
                ),
                const Gap(AppSizes.spaceBtwItems),
                Expanded(
                  child: CustomButton(
                    label: 'Supprimer',
                    variant: ButtonVariant.warning,
                  ),
                ),
              ],
            ),
            CustomButton(
              variant: ButtonVariant.secondary,
              label: 'Logout',
              onPressed: () async {
                await Future.delayed(const Duration(seconds: 2));
                controller.logout();
              },
            ),
          ],
        ),
      ],
    );
  }
}
