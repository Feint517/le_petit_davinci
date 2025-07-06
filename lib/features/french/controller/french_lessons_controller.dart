import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/data/repositories/youtube_service.dart';
import 'package:le_petit_davinci/data/models/youtube_video_model.dart';

class FrenchLessonsController extends GetxController {
  final YouTubeApiService youtubeService = YouTubeApiService();
  List<YouTubeVideo> fetchedVideos = [];
  final RxBool isLoading = false.obs;
  final RxSet<String> visitedVideoIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    loadVideos();
  }

  Future<void> loadVideos() async {
    try {
      final videos = await youtubeService.fetchPlaylistVideos(
        playlistId: 'PLaeXjdOcp1n1pluHNqy3YYlBe8pUIR9DH',
      );

      fetchedVideos = videos;
      isLoading.value = false;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading videos: $e');
      }
      isLoading.value = false;
    }
  }

  void markVideoAsVisited(String videoId) {
    visitedVideoIds.add(videoId);
  }

  bool isVideoVisited(String videoId) {
    return visitedVideoIds.contains(videoId);
  }
}
