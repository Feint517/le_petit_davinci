import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class EmbeddedVideoPlayer extends StatefulWidget {
  const EmbeddedVideoPlayer({
    super.key,
    required this.videoId,
    required this.onVideoCompleted,
  });

  final String videoId;
  final VoidCallback onVideoCompleted;

  @override
  State<EmbeddedVideoPlayer> createState() => _EmbeddedVideoPlayerState();
}

class _EmbeddedVideoPlayerState extends State<EmbeddedVideoPlayer> {
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
        hideThumbnail: true,
        enableCaption: false,
      ),
    )..addListener(_videoPlayerListener);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.amber,
      ),
    );
  }
}