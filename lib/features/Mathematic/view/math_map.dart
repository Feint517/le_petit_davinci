import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/colors_utils.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/math_map_controller.dart';
import 'package:le_petit_davinci/features/Mathematic/widgets/map_section.dart';

class MathMapScreen extends GetView<MathMapController> {
  const MathMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MathMapController());
    return Scaffold(
      backgroundColor: ColorsUtils.makeDarker(AppColors.secondary),
      appBar: const ProfileHeader(type: ProfileHeaderType.compact),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: ListView.separated(
          controller: controller.scrollController,
          itemBuilder:
              (_, index) =>
                  index == 0
                      ? const Gap(20)
                      : MapSection(data: controller.mapSections[index - 1]),
          separatorBuilder: (_, i) => const Gap(24.0),
          padding: const EdgeInsets.only(bottom: 24.0, left: 16.0, right: 16.0),
          itemCount: controller.mapSections.length + 1,
        ),
      ),
    );
  }
}
