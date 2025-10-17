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
// import 'package:le_petit_davinci/features/home/widgets/welcome_section.dart';
import 'package:le_petit_davinci/features/home/widgets/quiz_dashboard_section.dart';
import 'package:le_petit_davinci/features/rewards/views/rewards.dart';
import 'package:le_petit_davinci/services/progress_service.dart';
import 'package:le_petit_davinci/services/sfx_service.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    Get.put(ProgressService());
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     color: AppColors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.black.withOpacity(0.1),
      //         blurRadius: 10,
      //         offset: const Offset(0, -2),
      //       ),
      //     ],
      //   ),
      //   child: SafeArea(
      //     child: Padding(
      //       padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      //       child: GNav(
      //         backgroundColor: AppColors.white,
      //         color: AppColors.textSecondary,
      //         activeColor: AppColors.primary,
      //         tabBackgroundColor: AppColors.primary.withOpacity(0.1),
      //         gap: 8.w,
      //         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      //         tabs: const [
      //           GButton(
      //             icon: Icons.home,
      //             text: 'Home',
      //           ),
      //           GButton(
      //             icon: Icons.leaderboard,
      //             text: 'Leaderboard',
      //           ),
      //           GButton(
      //             icon: Icons.person,
      //             text: 'Profile',
      //           ),
      //         ],
      //         selectedIndex: 0,
      //         onTabChange: (index) {
      //           if (index == 0) return;
      //           if (index == 1) {
      //             Get.to(() => const LeaderboardScreen());
      //           } else if (index == 2) {
      //             Get.to(() => const RewardsScreen());
      //           }
      //         },
      //       ),
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            ProfileHeader(
              avatarOnTap: () => Get.to(() => const RewardsScreen()),
            ),

            const Divider(
              color: AppColors.grey,
              thickness: 1.5,
              indent: 30,
              endIndent: 30,
            ),

            // const ScrollAnimatedItem(child: WelcomeSection()),
            const ScrollAnimatedItem(child: QuizDashboardSection()),
            Gap(24.h),

            //* Subject Selection Grid
            const ScrollAnimatedItem(child: SubjectSelection()),
            Gap(24.h),

            //* Rewards Section
            const ScrollAnimatedItem(child: RewardsSection()),
            Gap(40.h),

            //* Bottom footer image
            const ScrollAnimatedItem(
              child: ResponsiveImageAsset(assetPath: SvgAssets.homeBottom),
            ),

            Gap(40.h),
            CustomButton(
              label: '🔓 Unlock All Levels (Testing)',
              onPressed: () async {
                AppSfx.click();
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
                AppSfx.click();
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
            Gap(20.h),
            CustomButton(
              label: '🎨 Rive Inspector (Testing)',
              onPressed: () {
                AppSfx.click();
                Get.toNamed(AppRoutes.riveInspector);
              },
            ),
            Gap(40.h),
          ],
        ),
      ),
    );
  }
}
