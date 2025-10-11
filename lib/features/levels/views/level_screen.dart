import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';
import 'package:le_petit_davinci/features/levels/widgets/level_content_view.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/widgets/persistent_mascot_widget.dart';

class LevelScreen extends GetView<LevelController> {
  const LevelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main scaffold with app bar and content
        Scaffold(
          appBar: const ProfileHeader(type: ProfileHeaderType.activity),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
            child: const LevelContentView(),
          ),
        ),

        // Focus overlay for mascot introduction - covers entire screen including app bar
        Obx(() {
          final currentActivity = controller.currentActivity;

          if (currentActivity is MascotIntroductionMixin) {
            final mascotMixin = currentActivity as MascotIntroductionMixin;

            return AnimatedOpacity(
              opacity:
                  mascotMixin.isInitialized &&
                          mascotMixin.mascotController != null &&
                          !mascotMixin.isIntroCompleted.value
                      ? 1.0
                      : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.4),
                child: const SizedBox.shrink(),
              ),
            );
          }

          return const SizedBox.shrink();
        }),

        // Mascot widget - on top layer for interaction
        const PersistentMascotWidget(),
      ],
    );
  }
}
