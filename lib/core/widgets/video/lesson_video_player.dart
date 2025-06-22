import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class LessonVideoPlayer extends StatefulWidget {
  final String videoTitle;
  final String videoUrl;
  final String? thumbnailUrl;
  final VoidCallback? onVideoEnd;
  final VoidCallback? onVideoStart;

  const LessonVideoPlayer({
    super.key,
    required this.videoTitle,
    required this.videoUrl,
    this.thumbnailUrl,
    this.onVideoEnd,
    this.onVideoStart,
  });

  @override
  State<LessonVideoPlayer> createState() => _LessonVideoPlayerState();
}

class _LessonVideoPlayerState extends State<LessonVideoPlayer> {
  bool _isPlaying = false;
  bool _showControls = true;
  double _currentPosition = 0.0;
  final double _duration = 100.0; // Mock duration for demo

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
    });

    if (_isPlaying) {
      widget.onVideoStart?.call();
      // Start video playback
      _simulateVideoProgress();
    } else {
      // Pause video playback
    }
  }

  void _simulateVideoProgress() {
    // This simulates video progress - replace with actual video player logic
    if (_isPlaying && _currentPosition < _duration) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && _isPlaying) {
          setState(() {
            _currentPosition += 1;
          });
          if (_currentPosition >= _duration) {
            widget.onVideoEnd?.call();
            setState(() {
              _isPlaying = false;
            });
          } else {
            _simulateVideoProgress();
          }
        }
      });
    }
  }

  String _formatDuration(double seconds) {
    final duration = Duration(seconds: seconds.round());
    final minutes = duration.inMinutes;
    final remainingSeconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Video thumbnail/background
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.grey[800]!, Colors.grey[900]!],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_circle_outline,
                      size: 80,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.videoTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Video controls overlay
            if (_showControls)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Progress bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Text(
                              _formatDuration(_currentPosition),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                value: _currentPosition,
                                min: 0,
                                max: _duration,
                                onChanged: (value) {
                                  setState(() {
                                    _currentPosition = value;
                                  });
                                },
                                activeColor: AppColors.secondary,
                                inactiveColor: Colors.white.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                            Text(
                              _formatDuration(_duration),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Control buttons
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _currentPosition = (_currentPosition - 10)
                                      .clamp(0, _duration);
                                });
                              },
                              icon: const Icon(
                                Icons.replay_10,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: _togglePlayPause,
                              icon: Icon(
                                _isPlaying
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_filled,
                                color: AppColors.secondary,
                                size: 64,
                              ),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _currentPosition = (_currentPosition + 10)
                                      .clamp(0, _duration);
                                });
                              },
                              icon: const Icon(
                                Icons.forward_10,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // Tap to toggle controls
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _showControls = !_showControls;
                  });
                },
                child: Container(color: Colors.transparent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
