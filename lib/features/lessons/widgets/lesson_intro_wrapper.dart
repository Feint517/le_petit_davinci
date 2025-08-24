// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/core/utils/device_utils.dart';
// import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
// import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';

// class LessonIntroWrapper extends StatelessWidget {
//   final List<String> messages;
//   final VoidCallback onIntroComplete;
//   final String buttonLabel;

//   const LessonIntroWrapper({
//     super.key,
//     required this.messages,
//     required this.onIntroComplete,
//     required this.buttonLabel,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final tag = 'mascot_${messages.hashCode}';
//     final mascotController = Get.put(
//       TalkingMascotController(messages: messages),
//       tag: tag,
//     );

//     // This ensures the controller is removed when the intro is done.
//     ever(mascotController.isCompleted, (bool isDone) {
//       if (isDone) {
//         // Optional: clean up the controller after a delay
//         Future.delayed(const Duration(seconds: 1), () {
//           if (Get.isRegistered<TalkingMascotController>(tag: tag)) {
//             Get.delete<TalkingMascotController>(tag: tag);
//           }
//         });
//       }
//     });

//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Obx(
//           () => TalkingMascot(
//             mascotSize: 220,
//             bubbleText: mascotController.currentMessage,
//             onTap: mascotController.nextMessage,
//           ),
//         ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Padding(
//             padding: EdgeInsets.only(
//               bottom: DeviceUtils.getBottomNavigationBarHeight() + 16,
//             ),
//             child: Obx(() {
//               return AnimatedOpacity(
//                 opacity: mascotController.isCompleted.value ? 1.0 : 0.0,
//                 duration: const Duration(milliseconds: 300),
//                 child: mascotController.isCompleted.value
//                     ? CustomButton(
//                         label: buttonLabel,
//                         width: DeviceUtils.getScreenWidth() * 0.6,
//                         onPressed: onIntroComplete,
//                       )
//                     : const SizedBox.shrink(),
//               );
//             }),
//           ),
//         ),
//       ],
//     );
//   }
// }