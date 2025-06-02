import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import '../../../core/constants/assets_manager.dart';
import '../widgets/profile_header.dart';
import '../widgets/achievement_banner.dart';
import '../widgets/homescreen_content.dart';
import '../widgets/subject_selection.dart';
import '../widgets/rewards_section.dart';

/// Main home screen after login - blank with profile header
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Profile Header
            ProfileHeader(
              userName: 'Alex',
              userClass: 'Classe 2',
              changeAvatar: true,
              onChangeAvatar: () {
                // TODO: Implement avatar change functionality
                print('Change avatar pressed');
              },
            ),
            
            // Content area - Scrollable
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Achievement Banner with padding
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          AchievementBanner(
                            title: 'Explorateur des mots',
                            starCount: 5,
                            onRewardsPressed: () {
                              // TODO: Navigate to rewards screen
                              print('Rewards pressed');
                            },
                          ),
                        ],
                      ),
                    ),
                    
                    Gap(8.h),
                    
                    // Homescreen Content Unit (Image + Mascot + Mission Card)
                    HomescreenContent(
                      mascotMessage: 'Bonjour Alex ! Prêt pour une nouvelle aventure ?',
                      missionDescription: 'Trouve 5 mots qui riment !',
                      onAcceptMission: () {
                        // TODO: Navigate to mission
                        print('Mission accepted');
                      },
                    ),
                    
                    Gap(24.h),
                    
                    // Subject Selection Grid
                    const SubjectSelection(),
                    
                    Gap(24.h),
                    
                    // Rewards Section
                    const RewardsSection(),
                    
                    Gap(40.h),
                    
                    // Bottom footer image
                    SvgPicture.asset(
                      SvgAssets.bottom,
                      width: double.infinity,
                      height: 300.h,
                      fit: BoxFit.contain,
                      alignment: Alignment.topCenter,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}