import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// A full-screen, chrome-less view specifically for playing a YouTube video.
class FullScreenVideoPlayer extends StatefulWidget {
  const FullScreenVideoPlayer({
    super.key,
    required this.videoId,
    required this.onVideoCompleted,
  });

  final String videoId;
  final VoidCallback onVideoCompleted;

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        forceHD: true,
        hideControls: false,
        enableCaption: false,
        // Ensures the player UI is optimized for full-screen
        isLive: false,
      ),
    )..addListener(_videoPlayerListener);

    // Force landscape mode when the screen is displayed
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  void _videoPlayerListener() {
    if (!mounted) return;
    if (_controller.value.playerState == PlayerState.ended) {
      widget.onVideoCompleted();
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoPlayerListener);
    _controller.dispose();
    // Revert to portrait mode when the screen is disposed
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.amber,
        ),
      ),
    );
  }
}
