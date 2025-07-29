import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerController extends GetxController {
  VideoPlayerController({required this.videoId});
  final String videoId;

  late final WebViewController webViewController;
  final RxBool isPlaying = false.obs;
  final RxDouble currentPosition = 0.0.obs;
  final RxDouble duration = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    // Set preferred orientations to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    // Enter full screen mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse(
              'https://www.youtube.com/embed/$videoId?autoplay=1&playsinline=0',
            ),
          );
  }

  @override
  void onClose() {
    // Reset to portrait mode when leaving the screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Exit full screen mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  void play() {
    isPlaying.value = true;
  }

  void pause() {
    isPlaying.value = false;
  }

  void seekTo(double position) {
    currentPosition.value = position;
  }

  void setDuration(double newDuration) {
    duration.value = newDuration;
  }
}
