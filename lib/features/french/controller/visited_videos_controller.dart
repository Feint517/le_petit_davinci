import 'package:get/get.dart';

class VisitedVideosController extends GetxController {
  // Observable set to store visited video IDs
  final RxSet<String> visitedVideoIds = <String>{}.obs;

  // Mark a video as visited
  void markVideoAsVisited(String videoId) {
    visitedVideoIds.add(videoId);
  }

  // Check if a video has been visited
  bool isVideoVisited(String videoId) {
    return visitedVideoIds.contains(videoId);
  }
} 