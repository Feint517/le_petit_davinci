import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
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
          body: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: const ResponsiveImageAsset(
                  assetPath: SvgAssets.blueBackground,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                child: const LevelContentView(),
              ),
            ],
          ),
        ),

        // Focus overlay for mascot introduction - covers entire screen including app bar
        Obx(() {
          try {
            final currentActivity = controller.currentActivity;

            if (currentActivity is MascotIntroductionMixin) {
              final mascotMixin = currentActivity as MascotIntroductionMixin;

              // Make the overlay check reactive to mascot state changes
              return Obx(() {
                // Check if we should show overlay
                final shouldShowOverlay =
                    mascotMixin.isInitialized.value &&
                    mascotMixin.mascotController != null &&
                    !mascotMixin.isIntroCompleted.value;

                // Debug logging
                debugPrint('Focus overlay check:');
                debugPrint(
                  '  - isInitialized: ${mascotMixin.isInitialized.value}',
                );
                debugPrint(
                  '  - mascotController != null: ${mascotMixin.mascotController != null}',
                );
                debugPrint(
                  '  - isIntroCompleted: ${mascotMixin.isIntroCompleted.value}',
                );
                debugPrint('  - shouldShowOverlay: $shouldShowOverlay');

                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child:
                      shouldShowOverlay
                          ? GestureDetector(
                            key: ValueKey(
                              'overlay-${currentActivity.hashCode}',
                            ),
                            onTap: () {
                              // Allow user to tap anywhere to advance to next message
                              mascotMixin.nextMessage();
                            },
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.black.withValues(alpha: 0.4),
                              child: const SizedBox.shrink(),
                            ),
                          )
                          : SizedBox.shrink(
                            key: ValueKey(
                              'no-overlay-${currentActivity.hashCode}',
                            ),
                          ),
                );
              });
            }

            return SizedBox.shrink(
              key: ValueKey('no-overlay-no-mascot-${currentActivity.hashCode}'),
            );
          } catch (e) {
            debugPrint('Error in focus overlay: $e');
            return const SizedBox.shrink(key: ValueKey('no-overlay-error'));
          }
        }),

        // Mascot widget - on top layer for interaction
        PersistentMascotWidget(
          key: ValueKey('mascot-${controller.currentActivity.hashCode}'),
        ),
      ],
    );
  }
}
