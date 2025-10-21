import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/animations/scroll_animated_item.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';
import 'package:le_petit_davinci/features/dashboard/controllers/dashboard_controller.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/activities_section.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/exercices_section.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/progression_section.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/screen_time_section.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/settings_section.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/statistics_section.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use lazyPut with fenix to prevent multiple instances
    Get.lazyPut(() => DashboardController(), fenix: true);
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const CustomNavBar(),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.defaultSpace,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(AppSizes.spaceBtwSections),

                const ScrollAnimatedItem(child: ProgressionSection()),
                const Gap(AppSizes.spaceBtwSections),

                const ScrollAnimatedItem(child: ExercicesSection()),
                const Gap(AppSizes.spaceBtwSections),

                const ScrollAnimatedItem(child: ActivitiesSection()),
                const Gap(AppSizes.spaceBtwSections),

                const ScrollAnimatedItem(child: ScreenTimeSection()),
                const Gap(AppSizes.spaceBtwSections),

                const ScrollAnimatedItem(child: StatisticsSection()),
                const Gap(AppSizes.spaceBtwSections),

                const ScrollAnimatedItem(child: SettingsSection()),
                const Gap(AppSizes.spaceBtwSections * 2),

                // const CapsulesSection(),
                // const Gap(AppSizes.defaultSpace * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
