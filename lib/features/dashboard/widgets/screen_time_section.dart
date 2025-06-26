import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/features/dashboard/controllers/dashboard_controller.dart';
import 'package:le_petit_davinci/features/home/widgets/section_heading.dart';

class ScreenTimeSection extends GetView<DashboardController> {
  const ScreenTimeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeading(sectionName: "Temps d'écran autorisé"),
        const Gap(AppSizes.spaceBtwItems),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: AppSizes.spaceBtwItems,
            crossAxisSpacing: AppSizes.spaceBtwItems,
            childAspectRatio: 4,
          ),
          itemCount: controller.authorizedTimeOoptions.length,
          itemBuilder: (context, index) {
            final option = controller.authorizedTimeOoptions[index];
            return Obx(
              () => Row(
                children: [
                  Radio<int>(
                    activeColor: AppColors.primary,
                    value: option['value'],
                    groupValue: controller.selectedAthorizedTime.value,
                    onChanged: (value) {
                      if (value != null) {
                        controller.selectedAthorizedTime.value = value;
                      }
                    },
                  ),
                  Text(option['label']),
                ],
              ),
            );
          },
        ),

        const Divider(color: AppColors.grey, thickness: 1.5),
        const Gap(AppSizes.spaceBtwItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Afficher un rappel à l'enfant à"),
            Row(
              spacing: 10,
              children: [
                Container(
                  width: 50,
                  height: 30,
                  padding: EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: Center(
                    child: TextField(
                      controller: controller.textController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        //contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),
                Text('min'),
              ],
            ),
          ],
        ),
        const Gap(AppSizes.spaceBtwItems),
        const Divider(color: AppColors.grey, thickness: 1.5),
        const Gap(AppSizes.spaceBtwItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Bloquer après le temps autorisé"),
            SizedBox(
              width: 70,
              child: Obx(
                () => AnimatedToggleSwitch<bool>.dual(
                  current: controller.blockAfterTime.value,
                  first: false,
                  second: true,
                  spacing: 2,
                  style: const ToggleStyle(borderColor: AppColors.primary),
                  borderWidth: 2,
                  height: 30,
                  onChanged: (value) => controller.blockAfterTime.value = value,
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
        const Gap(AppSizes.spaceBtwItems),
        const Divider(color: AppColors.grey, thickness: 1.5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Autoriser 5 minutes supplémentaires\n avec code PIN"),
            SizedBox(
              width: 70,
              child: Obx(
                () => AnimatedToggleSwitch<bool>.dual(
                  current: controller.authorizeWithPin.value,
                  first: false,
                  second: true,
                  spacing: 2,
                  style: const ToggleStyle(borderColor: AppColors.primary),
                  borderWidth: 2,
                  height: 30,
                  onChanged:
                      (value) => controller.authorizeWithPin.value = value,
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
        const Gap(AppSizes.spaceBtwItems),
        const Divider(color: AppColors.grey, thickness: 1.5),
      ],
    );
  }
}
