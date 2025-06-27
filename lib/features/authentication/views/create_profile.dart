import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/dropdown/custom_dropdown_field.dart';
import 'package:le_petit_davinci/core/widgets/misc/profile_card.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/core/widgets/text_fields/custom_text_field.dart';
import 'package:le_petit_davinci/features/authentication/controllers/create_profile_controller.dart';
import 'package:le_petit_davinci/features/authentication/widgets/header_vector.dart';

class CreateProfileScreen extends StatelessWidget {
  const CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateProfileController());
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          const HeaderVector(color: HeaderVectorColor.green),
          const Positioned(
            bottom: 0,
            child: ResponsiveSvgAsset(
              assetPath: SvgAssets.createProfileBackground,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.defaultSpace,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'À propos de votre enfant',
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium!.apply(color: AppColors.primary),
                  ),

                  const Gap(AppSizes.spaceBtwSections),

                  CustomTextField(
                    controller: controller.kidName,
                    hintText: 'Prénom',
                  ),

                  const Gap(AppSizes.spaceBtwSections),

                  Obx(
                    () => CustomDropdownField<String>(
                      value: controller.selectedYear.value,
                      hintText: "Année",
                      items: [],
                      prefixIcon: Icons.calendar_month,
                      suffixIcon: Icons.arrow_downward,
                      onChanged:
                          (val) => controller.selectedLanguage.value = val,
                    ),
                  ),
                  const Gap(AppSizes.spaceBtwSections),

                  Text('Choisissez votre avatar'),
                  const Gap(AppSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const ProfileCard(
                        isExpanded: false,
                        name: 'Alex',
                        subInfo: 'class 2',
                        image: SvgAssets.profileSelectionBackground,
                        backgroundColor: AppColors.primary,
                      ),
                      const ProfileCard(
                        isExpanded: false,
                        name: 'Alex',
                        subInfo: 'class 2',
                        image: SvgAssets.profileSelectionBackground,
                        backgroundColor: AppColors.secondary,
                      ),
                      const ProfileCard(
                        isExpanded: false,
                        name: 'Alex',
                        subInfo: 'class 2',
                        image: SvgAssets.profileSelectionBackground,
                        backgroundColor: AppColors.accent,
                      ),
                      const ProfileCard(
                        isExpanded: false,
                        name: 'Alex',
                        subInfo: 'class 2',
                        image: SvgAssets.profileSelectionBackground,
                        backgroundColor: AppColors.accent3,
                      ),
                    ],
                  ),

                  const Gap(AppSizes.spaceBtwSections),

                  Obx(
                    () => CustomDropdownField<String>(
                      value: controller.selectedLanguage.value,
                      hintText: "Langue",
                      items: [
                        DropdownMenuItem(
                          value: "fr",
                          child: Text(
                            "Francais",
                            style: Theme.of(context).textTheme.headlineSmall!
                                .apply(color: AppColors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: "en",
                          child: Text(
                            "Anglais",
                            style: Theme.of(context).textTheme.headlineSmall!
                                .apply(color: AppColors.black),
                          ),
                        ),
                      ],
                      prefixIcon: Icons.flag,
                      suffixIcon: Icons.arrow_downward,
                      onChanged:
                          (val) => controller.selectedLanguage.value = val,
                    ),
                  ),

                  const Gap(AppSizes.spaceBtwSections),

                  Obx(
                    () => CustomDropdownField<int>(
                      value: controller.selectedTime.value,
                      hintText: "Temps d'écran",
                      items: [
                        DropdownMenuItem(
                          value: 5,
                          child: Text(
                            "5 minutes",
                            style: Theme.of(context).textTheme.headlineSmall!
                                .apply(color: AppColors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 10,
                          child: Text(
                            "10 minutes",
                            style: Theme.of(context).textTheme.headlineSmall!
                                .apply(color: AppColors.black),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 20,
                          child: Text(
                            "20 minutes",
                            style: Theme.of(context).textTheme.headlineSmall!
                                .apply(color: AppColors.black),
                          ),
                        ),
                      ],
                      prefixIcon: Iconsax.clock,
                      suffixIcon: Icons.arrow_downward,
                      onChanged: (val) => controller.selectedTime.value = val,
                    ),
                  ),

                  const Gap(AppSizes.spaceBtwSections),

                  CustomButton(
                    label: ' Créer un profil enfant',
                    onPressed: () {},
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
