// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';
// import 'package:le_petit_davinci/features/lessons/widgets/full_screen_video_player.dart';
// import 'package:le_petit_davinci/features/lessons/views/video_activity_view.dart';
// import 'package:le_petit_davinci/features/levels/models/activity_model.dart';

// class VideoActivity extends Activity {
//   VideoActivity({required this.videoId}) {
//     // The model now creates and configures its own mascot controller.
//     mascotController = TalkingMascotController(
//       messages: ['Super! Prêt à voir la vidéo?'],
//     );

//     // Listen to the mascot controller to know when the intro is done.
//     ever(mascotController.isCompleted, (bool isDone) {
//       if (isDone) {
//         // Use a small delay to allow the button animation to finish.
//         Future.delayed(const Duration(milliseconds: 400), () {
//           isIntroCompleted.value = true;
//         });
//       }
//     });

//     // When the intro is complete, launch the full-screen player.
//     ever(isIntroCompleted, (bool isReady) {
//       if (isReady) {
//         Get.to(
//           () => FullScreenVideoPlayer(
//             videoId: videoId,
//             onVideoCompleted: () {
//               // When the video finishes, navigate back and mark the activity as complete.
//               Get.back();
//               markVideoAsCompleted();
//             },
//           ),
//         );
//       }
//     });
//   }

//   final String videoId;

//   /// State specific to this activity: is the intro mascot done talking?
//   late final TalkingMascotController mascotController;
//   final RxBool isIntroCompleted = false.obs;

//   /// The video player will call this when the video ends.
//   /// This triggers the main `isCompleted` flag, advancing the lesson.
//   void markVideoAsCompleted() {
//     isCompleted.value = true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     //? The state change is now handled by the view.
//     return VideoActivityView(activity: this);
//   }

//   @override
//   void dispose() {
//     // Clean up the controller when the activity is disposed.
//     mascotController.dispose();
//   }
// }
