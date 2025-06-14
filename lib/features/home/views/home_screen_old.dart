// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/core/constants/colors.dart';
// import 'package:le_petit_davinci/core/constants/text_strings.dart';
// import 'package:le_petit_davinci/features/home/controllers/home_controller.dart';
// import '../../../core/constants/assets_manager.dart';
// import '../../../core/widgets/misc/profile_header.dart';
// import '../widgets/achievement_banner.dart';
// import '../widgets/homescreen_content.dart';
// import '../widgets/subject_selection.dart';
// import '../widgets/rewards_section.dart';

// /// Main home screen after login - blank with profile header
// class HomeScreenOld extends GetView<HomeController> {
//   const HomeScreenOld({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundLight,
//       body: SafeArea(
//         bottom: false,
//         child: Column(
//           children: [
//             ProfileHeader(
//               userName: 'Alex',
//               userClass: 'Classe 2',
//               changeAvatar: true,
//             ),

//             //* Content area - Scrollable
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     //* Achievement Banner with padding
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.w),
//                       child: AchievementBanner(
//                         starCount: 4,
//                       ),
//                     ),

//                     Gap(8.h),

//                     //* Homescreen Content Unit (Image + Mascot + Mission Card)
//                     HomeScreenContent(
//                       mascotMessage: StringsManager.homeScreenMessage,
//                       missionDescription: 'Trouve 5 mots qui riment !',
//                     ),
//                     Gap(24.h),

//                     //* Subject Selection Grid
//                     const SubjectSelection(),
//                     Gap(24.h),

//                     //* Rewards Section
//                     const RewardsSection(),
//                     Gap(40.h),

//                     //* Bottom footer image
//                     SvgPicture.asset(
//                       SvgAssets.homeBottom,
//                       width: double.infinity,
//                       height: 300.h,
//                       fit: BoxFit.contain,
//                       alignment: Alignment.topCenter,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
