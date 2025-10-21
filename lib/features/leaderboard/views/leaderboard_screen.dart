import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/animations/scroll_animated_item.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/features/leaderboard/controllers/leaderboard_controller.dart';
import 'package:le_petit_davinci/features/leaderboard/widgets/leaderboard_item.dart';
import 'package:le_petit_davinci/features/leaderboard/widgets/leaderboard_header.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LeaderboardController());

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            const ScrollAnimatedItem(child: LeaderboardHeader()),

            Gap(20.h),

            // Leaderboard List
            Expanded(
              child: GetBuilder<LeaderboardController>(
                builder: (controller) {
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: controller.leaderboardData.length,
                    itemBuilder: (context, index) {
                      final player = controller.leaderboardData[index];
                      return ScrollAnimatedItem(
                        child: LeaderboardItem(
                          player: player,
                          rank: index + 1,
                          isCurrentUser: player.isCurrentUser,
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            Gap(20.h),

            // Bottom decoration
            const ScrollAnimatedItem(
              child: ResponsiveImageAsset(
                assetPath: 'assets/svg/leaderboard_bottom.svg',
                height: 100,
              ),
            ),

            Gap(20.h),
          ],
        ),
      ),
    );
  }
}
