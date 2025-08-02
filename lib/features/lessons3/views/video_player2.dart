// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:le_petit_davinci/features/video_player/controllers/video_player_controller.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class VideoPlayerScreen2 extends GetView<VideoPlayerController> {
//   const VideoPlayerScreen2({
//     super.key,
//     required this.videoId,
//     required this.onVideoCompleted,
//   });

//   final String videoId;
//   final VoidCallback onVideoCompleted;

//   @override
//   Widget build(BuildContext context) {
//     Get.put(VideoPlayerController(videoId: videoId));
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             //? Video player takes full screen
//             Center(
//               child: WebViewWidget(controller: controller.webViewController),
//             ),
//             //? Back button overlay
//             Positioned(
//               top: 16,
//               left: 16,
//               child: IconButton(
//                 icon: const Icon(Icons.arrow_back, color: Colors.white),
//                 onPressed: () {
//                   //? When the user leaves, call the callback to mark it complete.
//                   onVideoCompleted();
//                   Get.back();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen2 extends StatefulWidget {
  const VideoPlayerScreen2({
    super.key,
    required this.videoId,
    required this.onVideoCompleted,
  });

  final String videoId;
  final VoidCallback onVideoCompleted;

  @override
  State<VideoPlayerScreen2> createState() => _VideoPlayerScreen2State();
}

class _VideoPlayerScreen2State extends State<VideoPlayerScreen2> {
  late final YoutubePlayerController _controller;
  final RxBool _isVideoEnded = false.obs;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        forceHD: true,
      ),
    )..addListener(_videoPlayerListener);
  }

  void _videoPlayerListener() {
    // Listen for the video to end.
    if (_controller.value.playerState == PlayerState.ended) {
      // Mark the activity as complete and show the button.
      widget.onVideoCompleted();
      _isVideoEnded.value = true;
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed.
    _controller.removeListener(_videoPlayerListener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // The YouTube Player
            Center(
              child: YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
              ),
            ),

            // The "Continue" button that appears when the video ends.
            Obx(() {
              if (_isVideoEnded.value) {
                return Center(
                  // child: ElevatedButton.icon(
                  //   icon: const Icon(Icons.arrow_forward),
                  //   label: const Text('Continue to Next Activity'),
                  //   onPressed: () {
                  //     // Go back to the lesson screen. The "Continue" button
                  //     // there will now be enabled.
                  //     Get.back();
                  //   },
                  //   style: ElevatedButton.styleFrom(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 24,
                  //       vertical: 12,
                  //     ),
                  //   ),
                  // ),
                  child: CustomButton(
                    label: 'Continue to Next Activity',
                    onPressed: () {
                      // Go back to the lesson screen. The "Continue" button
                      // there will now be enabled.
                      Get.back();
                    },
                    width: DeviceUtils.getScreenWidth() * 0.6,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
          ],
        ),
      ),
    );
  }
}
