import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';
import 'package:le_petit_davinci/features/levels/widgets/level_content_view.dart';
import 'package:le_petit_davinci/features/levels/widgets/activity_wrapper.dart';

class LevelScreen extends GetView<LevelController> {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileHeader(type: ProfileHeaderType.activity),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: const LevelContentView().withStandardNavigation(),
      ),
    );
  }
}
