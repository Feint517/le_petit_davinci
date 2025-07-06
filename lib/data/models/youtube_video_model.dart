class YouTubeVideo {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String channelTitle;

  YouTubeVideo({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.channelTitle,
  });

  factory YouTubeVideo.fromJson(Map<String, dynamic> json) {
    //? Safely access nested JSON properties with null checks
    final contentDetails = json['contentDetails'] as Map<String, dynamic>?;
    final snippet = json['snippet'] as Map<String, dynamic>?;
    final thumbnails = snippet?['thumbnails'] as Map<String, dynamic>?;
    final highThumbnail = thumbnails?['high'] as Map<String, dynamic>?;

    return YouTubeVideo(
      id: contentDetails?['videoId'] as String? ?? '',
      title: snippet?['title'] as String? ?? '',
      thumbnailUrl: highThumbnail?['url'] as String? ?? '',
      channelTitle: snippet?['channelTitle'] as String? ?? '',
    );
  }
}
