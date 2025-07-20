import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/features/dashboard/controllers/dashboard_controller.dart';
import 'package:le_petit_davinci/features/home/widgets/section_heading.dart';

class CapsulesSection extends GetView<DashboardController> {
  const CapsulesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(sectionName: 'Ajouter une capsule personnalisée'),
        const Gap(AppSizes.spaceBtwItems),
        Column(
          spacing: AppSizes.spaceBtwItems,
          children: [
            Column(
              spacing: AppSizes.spaceBtwItems,
              children: List.generate(
                5,
                (index) => Container(
                  width: DeviceUtils.getScreenWidth(),
                  padding: EdgeInsets.all(AppSizes.md),
                  decoration: BoxDecoration(
                    color: AppColors.accent2,
                    borderRadius: const BorderRadiusGeometry.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Capsule ${index + 1}',
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium!.apply(color: AppColors.white),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            const ResponsiveImageAsset(
                              assetPath: IconAssets.writingPen,
                              width: 10,
                            ),
                            const Gap(AppSizes.sm),
                            Text(
                              'Modifier la capsule',
                              style: Theme.of(context).textTheme.labelMedium!
                                  .apply(color: AppColors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomButton(label: 'Créer une nouvelle capsule'),
          ],
        ),
        const Gap(AppSizes.spaceBtwItems),

        Container(
          width: DeviceUtils.getScreenWidth(),
          height: 700,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.md,
            vertical: AppSizes.lg,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadiusGeometry.all(Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Titre de la capsule',
                style: TextStyle(color: AppColors.black),
              ),
              const Gap(AppSizes.spaceBtwItems),
              Container(
                height: 30,
                padding: const EdgeInsets.only(bottom: 12, left: 12),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary),
                ),
                child: TextField(
                  controller: controller.capsuleName,
                  keyboardType: TextInputType.text,
                  cursorColor: AppColors.primary,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    //contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),

              const Gap(AppSizes.spaceBtwSections),

              Text(
                'Ajouter une vidéo',
                style: TextStyle(color: AppColors.black),
              ),
              const Gap(AppSizes.spaceBtwItems),
              Row(
                spacing: AppSizes.sm,
                children: [
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.primary),
                        ),
                        child: Center(
                          child: Text(
                            'Lien YouTube/Vimeo',
                            style: TextStyle(color: AppColors.darkGrey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text('Or'),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.primary),
                        ),
                        child: Center(
                          child: Text(
                            'Upload vidéo',
                            style: TextStyle(color: AppColors.darkGrey),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const Gap(AppSizes.spaceBtwSections),

              Text(
                'Ajouter un audio',
                style: TextStyle(color: AppColors.black),
              ),
              const Gap(AppSizes.spaceBtwItems),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: Center(
                    child: Text(
                      'Upload mp3 or enregistrement micro',
                      style: TextStyle(color: AppColors.darkGrey),
                    ),
                  ),
                ),
              ),

              const Gap(AppSizes.spaceBtwSections),

              const Text(
                'Ajouter une image',
                style: TextStyle(color: AppColors.black),
              ),
              const Gap(AppSizes.spaceBtwItems),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Iconsax.add, color: AppColors.darkGrey),
                          const Gap(AppSizes.sm),
                          Text(
                            'Upload mp3 or enregistrement micro',
                            style: TextStyle(color: AppColors.darkGrey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              const Gap(AppSizes.spaceBtwSections),

              const Text(
                'Ajouter un texte',
                style: TextStyle(color: AppColors.black),
              ),
              const Gap(AppSizes.spaceBtwItems),
              Container(
                height: 100,
                padding: const EdgeInsets.only(bottom: 12, left: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary),
                ),
                child: TextField(
                  controller: controller.capsuleText,
                  keyboardType: TextInputType.text,
                  cursorColor: AppColors.primary,
                  maxLines: null,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.labelSmall,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    //contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),

        const Gap(AppSizes.spaceBtwItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "Rendre cette capsule visible immédiatement dans l'app enfant",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Gap(16),

            SizedBox(
              width: 70,
              child: Obx(
                () => AnimatedToggleSwitch<bool>.dual(
                  current: controller.makeCapsuleVisible.value,
                  first: false,
                  second: true,
                  spacing: 2,
                  style: const ToggleStyle(borderColor: AppColors.primary),
                  borderWidth: 2,
                  height: 30,
                  onChanged:
                      (value) => controller.makeCapsuleVisible.value = value,
                  styleBuilder:
                      (value) => ToggleStyle(
                        backgroundColor: value ? Colors.white : Colors.white,
                        indicatorColor: value ? AppColors.accent2 : Colors.red,
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(50.0),
                          right: Radius.circular(50.0),
                        ),
                        indicatorBorderRadius: BorderRadius.circular(50),
                      ),
                  iconBuilder:
                      (value) => Icon(
                        value ? Iconsax.lock : Iconsax.unlock,
                        size: 16,
                        color: Colors.white,
                      ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
