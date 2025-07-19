import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/Mathematic/controllers/math_map_controller.dart';

class MathMapScreen extends GetView<MathMapController> {
  const MathMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MathMapController());
    return Scaffold(
      appBar: const ProfileHeader(type: ProfileHeaderType.compact),
      body: const Placeholder(),
    );
  }
}