// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:le_petit_davinci/data/models/youtube_video_model.dart';

class YouTubeApiService {
  final String baseUrl = 'https://www.googleapis.com/youtube/v3';

  Future<List<YouTubeVideo>> fetchPlaylistVideos({
    required String playlistId,
    int maxResults = 50,
  }) async {
    final String url =
        '$baseUrl/playlistItems?part=snippet,contentDetails&playlistId=$playlistId&key=AIzaSyDqrhsTwe8Bj5Uf2OoXJ8LeyFr3eNlhaww&maxResults=${maxResults.toString()}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> items = data['items'] ?? [];

        print('Found ${items.length} items in playlist');

        //* Debug: Print first item structure
        if (items.isNotEmpty) {
          print('First item structure: ${json.encode(items.first)}');
        }

        return items.map((item) {
          try {
            return YouTubeVideo.fromJson(item);
          } catch (e) {
            print('Error parsing item: $e');
            print('Item data: ${json.encode(item)}');
            rethrow;
          }
        }).toList();
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
