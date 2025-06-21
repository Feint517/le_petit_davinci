import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button_main.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';
import 'package:le_petit_davinci/core/widgets/subheader.dart';
import 'package:le_petit_davinci/features/french/controller/visited_videos_controller.dart';
import 'package:le_petit_davinci/features/french/controller/youtube_service.dart';
import 'package:le_petit_davinci/features/french/model/youtube_video.dart';
import 'package:le_petit_davinci/features/french/view/video_player_screen.dart';

class FrenchLessons extends StatefulWidget {
  const FrenchLessons({super.key});

  @override
  State<FrenchLessons> createState() => _FrenchLessonsState();
}

class _FrenchLessonsState extends State<FrenchLessons> {
  final YouTubeApiService _youtubeService = YouTubeApiService();
  final VisitedVideosController _visitedController = Get.put(VisitedVideosController());
  List<YouTubeVideo> _videos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    try {
      // Replace with your actual playlist ID
      final videos = await _youtubeService.fetchPlaylistVideos('YOUR_PLAYLIST_ID');
      setState(() {
        _videos = videos;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading videos: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluePrimary,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            spacing: 15,
            children: [
              const CustomNavBar(variant: BadgeVariant.french,),
                Text(
                  "Matériel d'apprentissage",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Obx(() => Column(
                  spacing: 15,
                  children: _videos.asMap().entries.map((entry) {
                    final index = entry.key;
                    final video = entry.value;
                    final isVisited = _visitedController.isVideoVisited(video.id);
                    return CustomButtonNew(
                      buttonColor: isVisited ? AppColors.blueSecondary : AppColors.white,
                      shadowColor: isVisited ? AppColors.blueSecondary : AppColors.white,
                      label: '${index + 1}- ${video.title}',
                      labelColor: isVisited ? AppColors.white : AppColors.textPrimary,
                      icon: Icons.play_circle_fill_rounded,
                      iconColor: isVisited ? AppColors.white : AppColors.bluePrimary,
                      mainAxisAlignment: MainAxisAlignment.start,
                      onPressed: () {
                        _visitedController.markVideoAsVisited(video.id);
                        Get.to(() => VideoPlayerScreen(
                              videoId: video.id,
                              videoTitle: video.title,
                            ));
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                    );
                  }).toList(),
                )),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}