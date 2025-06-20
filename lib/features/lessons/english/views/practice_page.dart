// // curved_edges_bottom.dart - Custom clipper for bottom curved edges
// import 'package:flutter/material.dart';
// import 'package:le_petit_davinci/core/constants/colors.dart';
// import 'package:le_petit_davinci/core/constants/enums.dart';
// import 'package:le_petit_davinci/core/utils/device_utils.dart';
// import 'package:le_petit_davinci/features/lessons/widget/practice_content.dart';

// class PracticePage extends StatelessWidget {
//   const PracticePage({super.key, required this.type});

//   final PracticeType type;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.accent,
//       body: SingleChildScrollView(
//         primary: true,
//         child: SizedBox(
//           height: DeviceUtils.getScreenHeight(),
//           //? we wrapped the stack with SizedBox because because in a scroll view, the Stack takes only the height of its children
//           child: Stack(
//             children: [
//               //CustomCurvedHeaderContainer(child: PracticeHeader(type: type)),
//               Positioned(
//                 top: 400 - 80,
//                 right: 0,
//                 left: 0,
//                 child: PracticeContent(type: type),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
