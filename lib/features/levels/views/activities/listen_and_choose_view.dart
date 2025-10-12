import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/core/widgets/layouts/grid_layout.dart';
import 'package:le_petit_davinci/features/levels/models/activities/listen_and_choose_activity.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';
import 'package:le_petit_davinci/features/levels/widgets/play_audio_button.dart';

// OLD IMPLEMENTATION - COMMENTED OUT FOR REVERSION
//
class ListenAndChooseView extends StatelessWidget {
  const ListenAndChooseView({super.key, required this.activity});

  final ListenAndChooseActivity activity;

  @override
  Widget build(BuildContext context) {
    // Initialize mascot when the view is built (only if not already initialized)
    if (!activity.isInitialized.value) {
      final messages = [
        'Listen carefully!',
        'Choose the correct answer.',
        'Use your ears to help you!',
      ];

      // Use a post-frame callback to ensure proper timing
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          activity.initializeMascot(messages);
        } catch (e) {
          debugPrint('Error initializing mascot in ListenAndChooseView: $e');
        }
      });
    }

    return _buildMainContent(context);
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Listen and choose the correct answer',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Gap(AppSizes.spaceBtwSections),
        Stack(
          alignment: Alignment.center,
          children: [
            CustomGridLayout(
              itemCount: activity.imageAssets.length,
              spacing: AppSizes.gridViewSpacing * 2,
              itemBuilder: (context, index) {
                return Obx(
                  () => GestureDetector(
                    onTap: () => activity.selectOption(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.all(AppSizes.sm),
                      decoration: BoxDecoration(
                        color:
                            activity.selectedIndex.value == index
                                ? Color(0xFFe1f4ff)
                                : AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: CustomShadowStyle.customCircleShadows(
                          color:
                              activity.selectedIndex.value == index
                                  ? AppColors.primary
                                  : AppColors.grey,
                        ),
                        border: Border.all(
                          color:
                              activity.selectedIndex.value == index
                                  ? AppColors.primary
                                  : AppColors.grey,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: ResponsiveImageAsset(
                          assetPath: activity.imageAssets[index],
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            PlayAudioButton(
              buttonSize: PlayAudioButtonSize.big,
              onPressed: () => Get.find<LevelController>().playCurrentAudio(),
            ),
          ],
        ),
        const Gap(AppSizes.spaceBtwSections),
        Obx(() {
          // Cast the activity to access its specific properties
          final listenActivity = activity;
          return AnimatedOpacity(
            // Read the state directly from the activity model
            opacity: listenActivity.showHint.value ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 400),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  activity.label,
                  style: Get.textTheme.headlineSmall?.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
