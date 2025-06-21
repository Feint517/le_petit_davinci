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
    return YouTubeVideo(
      id: json['contentDetails']['videoId'] as String,
      title: json['snippet']['title'] as String,
      thumbnailUrl: json['snippet']['thumbnails']['high']['url'] as String,
      channelTitle: json['snippet']['channelTitle'] as String,
    );
  }
}