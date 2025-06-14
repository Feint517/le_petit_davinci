import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';
import 'package:le_petit_davinci/core/widgets/video/lesson_video_player.dart';

class LessonVideoScreen extends StatefulWidget {
  final String lessonTitle;
  final String videoUrl;
  final String? description;

  const LessonVideoScreen({
    super.key,
    required this.lessonTitle,
    required this.videoUrl,
    this.description,
  });

  @override
  State<LessonVideoScreen> createState() => _LessonVideoScreenState();
}

class _LessonVideoScreenState extends State<LessonVideoScreen> {
  bool _videoCompleted = false;
  bool _showQuiz = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomNavBar(
                chipText: 'Mathématiques',
                chipColor: AppColors.orangeAccentDark,
              ),

              Gap(20),

              // Video Player Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Lesson title
                    Text(
                      widget.lessonTitle,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'DynaPuff_SemiCondensed',
                      ),
                    ),

                    Gap(16),

                    // Video Player
                    LessonVideoPlayer(
                      videoTitle: widget.lessonTitle,
                      videoUrl: widget.videoUrl,
                      onVideoStart: () {
                        print('Video started: ${widget.lessonTitle}');
                      },
                      onVideoEnd: () {
                        setState(() {
                          _videoCompleted = true;
                          _showQuiz = true;
                        });
                        print('Video completed: ${widget.lessonTitle}');
                      },
                    ),

                    Gap(20),

                    // Lesson Description
                    if (widget.description != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'À propos de cette leçon',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            Gap(8),
                            Text(
                              widget.description!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                    Gap(20),

                    // Progress indicator
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            _videoCompleted
                                ? Icons.check_circle
                                : Icons.play_circle_outline,
                            color:
                                _videoCompleted
                                    ? Colors.green
                                    : AppColors.secondary,
                            size: 24,
                          ),
                          Gap(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _videoCompleted
                                      ? 'Leçon terminée!'
                                      : 'En cours...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        _videoCompleted
                                            ? Colors.green
                                            : AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  _videoCompleted
                                      ? 'Vous avez terminé cette leçon avec succès'
                                      : 'Regardez la vidéo pour continuer',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Gap(20),

                    // Quiz section (appears after video completion)
                    if (_showQuiz)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.bluePrimary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.quiz,
                              color: Colors.white,
                              size: 48,
                            ),
                            Gap(12),
                            const Text(
                              'Quiz de révision',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Gap(8),
                            const Text(
                              'Testez vos connaissances avec notre quiz interactif!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Gap(16),
                            ElevatedButton(
                              onPressed: () {
                                // Navigate to quiz
                                Get.snackbar(
                                  'Quiz',
                                  'Fonctionnalité à venir!',
                                  backgroundColor: Colors.white,
                                  colorText: AppColors.textPrimary,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppColors.bluePrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: const Text('Commencer le quiz'),
                            ),
                          ],
                        ),
                      ),

                    Gap(40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
