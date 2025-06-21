import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:le_petit_davinci/features/french/model/youtube_video.dart';

class YouTubeApiService { 
  final String baseUrl = 'https://www.googleapis.com/youtube/v3';

  YouTubeApiService( );

  Future<List<YouTubeVideo>> fetchPlaylistVideos(String playlistId) async {
    final String url = '$baseUrl/playlistItems?part=snippet,contentDetails&playlistId=PLV1-QgpUU7N3ZGbRMIrV24FCuvZoMt4xw&key=AIzaSyDqrhsTwe8Bj5Uf2OoXJ8LeyFr3eNlhaww&maxResults=50'; // You can adjust maxResults

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> items = data['items'];

        return items.map((item) => YouTubeVideo.fromJson(item)).toList();
      } else {
        print('Failed to load playlist videos: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load playlist videos');
      }
    } catch (e) {
      print('Error fetching playlist videos: $e');
      rethrow;
    }
  }
  
}
