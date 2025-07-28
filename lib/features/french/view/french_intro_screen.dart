// // ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/core/constants/assets_manager.dart';
// import 'package:le_petit_davinci/core/constants/colors.dart';
// import 'package:le_petit_davinci/core/constants/enums.dart';
// import 'package:le_petit_davinci/core/utils/device_utils.dart';
// import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
// import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
// import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';
// import 'package:le_petit_davinci/features/french/view/lessons.dart';

// class FrenchIntroScreen extends StatelessWidget {
//   const FrenchIntroScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Color(0xFF0B9FD9), // Light blue
//               Color(0xFF87CEEB), // Sky blue
//               Color(0xFFE6F3FF), // Very light blue
//             ],
//             stops: [0.0, 0.5, 1.0],
//           ),
//         ),
//         child: SafeArea(
//           bottom: false,
//           child: Stack(
//             children: [
//               SingleChildScrollView(
//                 physics: const ClampingScrollPhysics(),
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                     minHeight:
//                         DeviceUtils.getScreenHeight() -
//                         MediaQuery.of(context).padding.top,
//                   ),
//                   child: Column(
//                     children: [
//                       // Top section with buttons
//                       // Padding(
//                       //   padding: EdgeInsets.symmetric(
//                       //     horizontal: 20.w,
//                       //     vertical: 20.h,
//                       //   ),
//                       //   child: Row(
//                       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       //     children: [
//                       //       // Back button
//                       //       Container(
//                       //         decoration: BoxDecoration(
//                       //           color: Colors.white.withValues(alpha: 0.9),
//                       //           borderRadius: BorderRadius.circular(20.r),
//                       //         ),
//                       //         child: IconButton(
//                       //           icon: Icon(
//                       //             Icons.arrow_back,
//                       //             color: AppColors.textSecondary,
//                       //             size: 20.sp,
//                       //           ),
//                       //           onPressed: () => Get.back(),
//                       //         ),
//                       //       ),

//                       //       // Français label
//                       //       Container(
//                       //         padding: EdgeInsets.symmetric(
//                       //           horizontal: 16.w,
//                       //           vertical: 8.h,
//                       //         ),
//                       //         decoration: BoxDecoration(
//                       //           color: AppColors.bluePrimary,
//                       //           borderRadius: BorderRadius.circular(20.r),
//                       //         ),
//                       //         child: Text(
//                       //           'Français',
//                       //           style: TextStyle(
//                       //             color: AppColors.bluePrimaryDark,
//                       //             fontSize: 14.sp,
//                       //             fontWeight: FontWeight.w600,
//                       //             fontFamily: 'DynaPuff_SemiCondensed',
//                       //           ),
//                       //         ),
//                       //       ),
//                       //     ],
//                       //   ),
//                       // ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 20.w,
//                           vertical: 20.h,
//                         ),
//                         child: CustomNavBar(
//                           activeChip: true,
//                           variant: BadgeVariant.french,
//                         ),
//                       ),

//                       // Flexible space for content
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 40.w),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             //* Bear mascot with floating animation
//                             // SizedBox(
//                             //   height:
//                             //       screenHeight * 0.35, // 35% of screen height
//                             //   child: SvgPicture.asset(
//                             //         SvgAssets.bearFrench,
//                             //         height: screenHeight * 0.35,
//                             //         fit: BoxFit.contain,
//                             //       )
//                             //       .animate(
//                             //         onPlay:
//                             //             (controller) =>
//                             //                 controller.repeat(reverse: true),
//                             //       )
//                             //       .moveY(
//                             //         begin: 0,
//                             //         end: -15,
//                             //         duration: const Duration(seconds: 3),
//                             //         curve: Curves.easeInOut,
//                             //       )
//                             //       .scale(
//                             //         begin: const Offset(1.0, 1.0),
//                             //         end: const Offset(1.02, 1.02),
//                             //         duration: const Duration(seconds: 3),
//                             //         curve: Curves.easeInOut,
//                             //       ),
//                             // ),
//                             ResponsiveImageAsset(
//                                   assetPath: SvgAssets.bearFrench,
//                                   width: DeviceUtils.getScreenWidth() * 0.6,
//                                 )
//                                 .animate(
//                                   onPlay:
//                                       (controller) =>
//                                           controller.repeat(reverse: true),
//                                 )
//                                 .moveY(
//                                   begin: 0,
//                                   end: -15,
//                                   duration: const Duration(seconds: 3),
//                                   curve: Curves.easeInOut,
//                                 )
//                                 .scale(
//                                   begin: const Offset(1.0, 1.0),
//                                   end: const Offset(1.02, 1.02),
//                                   duration: const Duration(seconds: 3),
//                                   curve: Curves.easeInOut,
//                                 ),

//                             Gap(30.h),

//                             // Welcome message
//                             Row(
//                                   children: [
//                                     // Sun icon
//                                     Container(
//                                       padding: EdgeInsets.all(8.w),
//                                       decoration: BoxDecoration(
//                                         color: Colors.yellow.shade600,
//                                         shape: BoxShape.circle,
//                                       ),
//                                       child: Icon(
//                                         Icons.wb_sunny,
//                                         color: Colors.white,
//                                         size: 20.sp,
//                                       ),
//                                     ),
//                                     Gap(12.w),
//                                     // Welcome text
//                                     Expanded(
//                                       child: Text(
//                                         'Bienvenue dans le coin des leçons! Ici, on apprendra ensemble le français.',
//                                         style: TextStyle(
//                                           fontSize: 18.sp,
//                                           fontWeight: FontWeight.w500,
//                                           color: AppColors.textPrimary,
//                                           fontFamily: 'DynaPuff_SemiCondensed',
//                                           height: 1.3,
//                                         ),
//                                         textAlign: TextAlign.left,
//                                       ),
//                                     ),
//                                   ],
//                                 )
//                                 .animate()
//                                 .fadeIn(
//                                   duration: const Duration(milliseconds: 800),
//                                   delay: const Duration(milliseconds: 600),
//                                 )
//                                 .slideX(
//                                   begin: 0.3,
//                                   duration: const Duration(milliseconds: 600),
//                                   curve: Curves.easeOutBack,
//                                 ),
//                           ],
//                         ),
//                       ),

//                       // Continue button with proper spacing
//                       Padding(
//                         padding: EdgeInsets.fromLTRB(
//                           40.w,
//                           20.h,
//                           40.w,
//                           120.h,
//                         ), // Extra bottom padding for plants
//                         child: CustomButton(
//                               label: 'Continuer',
//                               icon: Icon(
//                                 Icons.arrow_forward,
//                                 color: Colors.white,
//                               ),
//                               iconPosition: IconPosition.right,
//                               variant: ButtonVariant.secondary,
//                               size: ButtonSize.lg,
//                               width: double.infinity,
//                               onPressed: () {
//                                 print('🚀 Continue button pressed!');
//                                 print('🎓 Navigating to French Lessons Screen');
//                                 Get.to(
//                                   () => const FrenchLessons(),
//                                   transition: Transition.rightToLeft,
//                                   duration: const Duration(milliseconds: 500),
//                                 );
//                               },
//                             )
//                             .animate()
//                             .fadeIn(
//                               duration: const Duration(milliseconds: 600),
//                               delay: const Duration(milliseconds: 1000),
//                             )
//                             .scale(
//                               begin: const Offset(0.8, 0.8),
//                               duration: const Duration(milliseconds: 500),
//                               curve: Curves.elasticOut,
//                             ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),

//               // Bottom plants decoration - positioned to not overlap content
//               Positioned(
//                 bottom: 0,
//                 left: 0,
//                 child: ResponsiveImageAsset(
//                       assetPath:
//                           SvgAssets
//                               .plants1, // Reduced height to prevent overlap
//                       width:
//                           DeviceUtils.getScreenWidth() *
//                           0.3, // Responsive width
//                       fit: BoxFit.contain,
//                     )
//                     .animate()
//                     .fadeIn(
//                       duration: const Duration(milliseconds: 1000),
//                       delay: const Duration(milliseconds: 1200),
//                     )
//                     .slideX(
//                       begin: -0.5,
//                       duration: const Duration(milliseconds: 800),
//                       curve: Curves.easeOutBack,
//                     ),
//               ),

//               Positioned(
//                 bottom: 0,
//                 right: 0,
//                 child: ResponsiveImageAsset(
//                       assetPath: SvgAssets.plants2,
//                       width: DeviceUtils.getScreenWidth() * 0.25,
//                     )
//                     .animate()
//                     .fadeIn(
//                       duration: const Duration(milliseconds: 1000),
//                       delay: const Duration(milliseconds: 1400),
//                     )
//                     .slideX(
//                       begin: 0.5,
//                       duration: const Duration(milliseconds: 800),
//                       curve: Curves.easeOutBack,
//                     ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
