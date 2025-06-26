import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/misc/profile_header.dart';
import 'package:le_petit_davinci/features/dashboard/controllers/dashboard_controller.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/activities_section.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/capsule_section.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/exercices_section.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/progression_section.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/screen_time_section.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/settings_section.dart';
import 'package:le_petit_davinci/features/dashboard/widgets/statistics_section.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(DashboardController());
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: ProfileHeader(
        userName: 'Alex',
        userClass: 'Classe 2',
        changeAvatar: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.defaultSpace,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(color: AppColors.grey, thickness: 1.5),
              const Gap(AppSizes.spaceBtwItems),

              const ProgressionSection(),
              const Gap(AppSizes.spaceBtwSections),

              const ExercicesSection(),
              const Gap(AppSizes.spaceBtwSections),

              const ActivitiesSection(),
              const Gap(AppSizes.spaceBtwSections),

              const ScreenTimeSection(),
              const Gap(AppSizes.spaceBtwSections),

              const StatisticsSection(),
              const Gap(AppSizes.spaceBtwSections),

              const SettingsSection(),
              const Gap(AppSizes.spaceBtwSections),

              const CapsulesSection(),
              const Gap(AppSizes.defaultSpace * 2),
            ],
          ),
        ),
      ),
    );
  }
}
