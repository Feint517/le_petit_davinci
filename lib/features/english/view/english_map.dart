import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/colors_utils.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/Mathematic/widgets/map_section.dart';
import 'package:le_petit_davinci/features/english/controllers/english_map_controller.dart';

class EnglishMapScreen extends GetView<EnglishMapController> {
  const EnglishMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(EnglishMapController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ColorsUtils.makeDarker(AppColors.accent),
      appBar: const ProfileHeader(type: ProfileHeaderType.compact),
      body: Stack(
        children: [
          const Positioned.fill(
            child: ResponsiveImageAsset(
              assetPath: SvgAssets.mapBackground,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
            child: ListView.separated(
              controller: controller.scrollController,
              itemBuilder:
                  (_, index) =>
                      index == 0
                          ? Gap(DeviceUtils.getAppBarHeight() * 2)
                          : MapSection(data: controller.mapSections[index - 1]),
              separatorBuilder: (_, i) => const Gap(24.0),
              padding: const EdgeInsets.only(
                bottom: 24.0,
                left: 16.0,
                right: 16.0,
              ),
              itemCount: controller.mapSections.length + 1,
            ),
          ),
        ],
      ),
    );
  }
}
