// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:le_petit_davinci/services/youtube_service.dart';

class VideoLessonController extends GetxController {
  VideoLessonController({required this.videoId});

  final String videoId;
  final videoTitle = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVideoDetails(videoId: videoId);
  }

  void fetchVideoDetails({required String videoId}) async {
    isLoading.value = true;
    try {
      final video = await YouTubeApiService.fetchVideoDetails(videoId);
      if (video != null) {
        videoTitle.value = video.title;
        print(videoTitle.value);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }
}
