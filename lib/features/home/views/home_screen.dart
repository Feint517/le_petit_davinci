import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/animations/scroll_animated_item.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/authentication/controllers/login_controller.dart';
import 'package:le_petit_davinci/features/authentication/controllers/user_controller.dart';
import 'package:le_petit_davinci/features/home/controllers/home_controller.dart';
import 'package:le_petit_davinci/features/home/widgets/rewards_section.dart';
import 'package:le_petit_davinci/features/home/widgets/subject_selection.dart';
import 'package:le_petit_davinci/features/home/widgets/welcome_section.dart';
import 'package:le_petit_davinci/features/rewards/views/rewards.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final testController = Get.put(LoginController());
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

            // CustomButton(
            //   label: 'testing',
            //   onPressed: () => testController.test(),
            // ),
            // Gap(40.h),

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
          ],
        ),
      ),
    );
  }
}
