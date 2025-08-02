import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/lessons2/controllers/lesson_controller.dart';
import 'package:le_petit_davinci/features/video_player/controllers/video_player_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerScreen extends GetView<VideoPlayerController> {
  const VideoPlayerScreen({super.key, required this.videoId});

  final String videoId;

  @override
  Widget build(BuildContext context) {
    Get.put(VideoPlayerController(videoId: videoId));
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            //? Video player takes full screen
            Center(
              child: WebViewWidget(controller: controller.webViewController),
            ),
            //? Back button overlay
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  final lessonController = Get.put(LessonController2());
                  lessonController.markVideoCompleted();
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
