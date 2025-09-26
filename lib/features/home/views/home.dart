import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/animations/scroll_animated_item.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/authentication/controllers/user_controller.dart';
import 'package:le_petit_davinci/features/home/widgets/rewards_section.dart';
import 'package:le_petit_davinci/features/home/widgets/subject_selection.dart';
import 'package:le_petit_davinci/features/home/widgets/welcome_section.dart';
import 'package:le_petit_davinci/features/rewards/views/rewards.dart';
import 'package:le_petit_davinci/services/progress_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    Get.put(ProgressService());
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: ProfileHeader(
        avatarOnTap: () => Get.to(() => const RewardsScreen()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Divider(
              color: AppColors.grey,
              thickness: 1.5,
              indent: 30,
              endIndent: 30,
            ),

            const ScrollAnimatedItem(child: WelcomeSection()),
            Gap(24.h),

            //* Subject Selection Grid
            const ScrollAnimatedItem(child: SubjectSelection()),
            Gap(24.h),

            //* Rewards Section
            const ScrollAnimatedItem(child: RewardsSection()),
            Gap(40.h),

            //* Rive Animation Testing Section
            // SizedBox(
            //   height: 220,
            //   child: RiveAnimation.asset(
            //     'assets/animations/rive/talking_bear.riv',
            //     fit: BoxFit.contain,
            //     onInit: (artboard) {
            //       final first =
            //           artboard.animations.isNotEmpty
            //               ? artboard.animations.first.name
            //               : null;
            //       if (first != null) {
            //         artboard.addController(SimpleAnimation(first));
            //       }
            //     },
            //   ),
            // ),
            // Gap(40.h),

            //* Bottom footer image
            const ScrollAnimatedItem(
              child: ResponsiveImageAsset(assetPath: SvgAssets.homeBottom),
            ),

            Gap(40.h),
            CustomButton(
              label: '🔓 Unlock All Levels (Testing)',
              onPressed: () async {
                await ProgressService.instance.unlockAllLevelsForTesting();
                Get.snackbar(
                  'Testing Mode',
                  'All levels unlocked for testing!',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              },
            ),
            Gap(20.h),
            CustomButton(
              label: ' Reset Progress (Testing)',
              onPressed: () async {
                await ProgressService.instance.resetAllProgressForTesting();
                Get.snackbar(
                  'Testing Mode',
                  'All progress reset!',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.orange,
                  colorText: Colors.white,
                );
              },
            ),
            Gap(40.h),
          ],
        ),
      ),
    );
  }
}
