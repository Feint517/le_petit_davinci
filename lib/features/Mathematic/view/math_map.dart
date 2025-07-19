import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/math_map_controller.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/math_map_controller_old.dart';
import 'package:le_petit_davinci/features/Mathematic/widgets/timeline_step.dart';

class MathMapScreen extends GetView<MathMapController> {
  const MathMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MathMapController());
    return Scaffold(
      appBar: const ProfileHeader(type: ProfileHeaderType.compact),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: Obx(
          () => ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.levels.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.levels.length) {
                return Center(child: CircularProgressIndicator());
              }
              return TimelineStep(
                label: controller.levels[index],
                isFirst: index == 0,
                isLast: index == controller.levels.length - 1,
              );
            },
          ),
        ),
      ),
    );
  }
}
