// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:le_petit_davinci/core/constants/colors.dart';
// import 'package:le_petit_davinci/features/navigation/controllers/main_navigation_controller.dart';

// class MainNavigationScreen extends StatelessWidget {
//   const MainNavigationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(MainNavigationController());

//     return Scaffold(
//       body: Obx(() => controller.pages[controller.currentIndex.value]),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: AppColors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
//             child: GNav(
//               backgroundColor: AppColors.white,
//               color: AppColors.textSecondary,
//               activeColor: AppColors.primary,
//               tabBackgroundColor: AppColors.primary.withOpacity(0.1),
//               gap: 8.w,
//               padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
//               tabs: const [
//                 GButton(
//                   icon: Icons.home,
//                   text: 'Home',
//                 ),
//                 GButton(
//                   icon: Icons.leaderboard,
//                   text: 'Leaderboard',
//                 ),
//                 GButton(
//                   icon: Icons.person,
//                   text: 'Profile',
//                 ),
//               ],
//               selectedIndex: controller.currentIndex.value,
//               onTabChange: (index) {
//                 controller.changePage(index);
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
