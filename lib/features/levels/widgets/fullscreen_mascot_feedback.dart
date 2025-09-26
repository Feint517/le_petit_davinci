import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart' as rive;
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/widgets/misc/chat_bubble.dart';

/// A full-screen mascot feedback widget that slides up from the bottom
/// with animated text and appropriate mascot based on answer correctness
class FullScreenMascotFeedback extends StatefulWidget {
  const FullScreenMascotFeedback({
    super.key,
    required this.isCorrect,
    this.correctAnswer,
    this.onContinue,
  });

  final bool isCorrect;
  final String? correctAnswer;
  final VoidCallback? onContinue;

  @override
  State<FullScreenMascotFeedback> createState() =>
      _FullScreenMascotFeedbackState();
}

class _FullScreenMascotFeedbackState extends State<FullScreenMascotFeedback>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _mascotController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _mascotScaleAnimation;

  rive.Artboard? _artboard;
  rive.StateMachineController? _stateMachineController;
  rive.SimpleAnimation? _simpleAnimation;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _loadRiveAnimation();
  }

  void _setupAnimations() {
    // Slide up animation
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Mascot scale animation
    _mascotController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from bottom
      end: Offset.zero, // End at normal position
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack),
    );

    _mascotScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _mascotController, curve: Curves.elasticOut),
    );

    // Start animations
    _slideController.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      _mascotController.forward();
    });
  }

  Future<void> _loadRiveAnimation() async {
    try {
      String assetPath;
      if (widget.isCorrect) {
        assetPath = AnimationAssets.happyBear;
      } else {
        assetPath = AnimationAssets.sadBear;
      }

      final data = await DefaultAssetBundle.of(context).load(assetPath);
      final file = rive.RiveFile.import(data);
      final artboard = file.mainArtboard;

      setState(() {
        _artboard = artboard;
        _isLoaded = true;
      });

      // Try to get the state machine controller
      _stateMachineController = rive.StateMachineController.fromArtboard(
        artboard,
        'State Machine 1',
      );

      if (_stateMachineController != null) {
        artboard.addController(_stateMachineController!);
        // Trigger animation after a short delay
        Future.delayed(const Duration(milliseconds: 500), () {
          _triggerAnimation();
        });
      } else {
        // Fallback to simple animation
        _simpleAnimation = rive.SimpleAnimation('Animation 1');
        artboard.addController(_simpleAnimation!);
        _simpleAnimation!.isActive = true;
      }
    } catch (e) {
      debugPrint('Error loading Rive animation: $e');
    }
  }

  void _triggerAnimation() {
    if (_stateMachineController != null) {
      try {
        final inputs = _stateMachineController!.findInput('Trigger');
        if (inputs != null) {
          inputs.value = true;
        }
      } catch (e) {
        debugPrint('Error triggering animation: $e');
      }
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    _mascotController.dispose();
    _stateMachineController?.dispose();
    _simpleAnimation?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: widget.onContinue,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors:
                  widget.isCorrect
                      ? [
                        const Color(0xFFE8F5E8),
                        const Color(0xFFD7F9E9),
                        const Color(0xFFC8F7C5),
                      ]
                      : [
                        const Color(0xFFFDE2E4),
                        const Color(0xFFF8D7DA),
                        const Color(0xFFF5C6CB),
                      ],
            ),
          ),
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              children: [
                // Top spacing
                SizedBox(height: MediaQuery.of(context).padding.top + 20),

                // Main content
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Mascot with animation
                      ScaleTransition(
                        scale: _mascotScaleAnimation,
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child:
                              _isLoaded && _artboard != null
                                  ? rive.Rive(artboard: _artboard!)
                                  : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Animated chat bubble
                      ChatBubble(
                        bubbleText: _getFeedbackMessage(),
                        bubbleColor:
                            widget.isCorrect
                                ? Colors.green.shade400
                                : Colors.red.shade400,
                        width: 280,
                        enableTypingAnimation: true,
                        characterDelay: const Duration(milliseconds: 60),
                        onAnimationComplete: () {
                          // Animation complete, screen is now ready for interaction
                        },
                      ),

                      const SizedBox(height: 40),

                      // Correct answer display (only for incorrect answers)
                      if (!widget.isCorrect &&
                          widget.correctAnswer != null) ...[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 40),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                'The correct answer is:',
                                style: Get.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red.shade700,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                widget.correctAnswer!,
                                style: Get.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade800,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],

                      // Tap instruction text
                      AnimatedOpacity(
                        opacity: _mascotController.isCompleted ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: Text(
                          'Tap anywhere to continue',
                          style: Get.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey.shade600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Bottom spacing
                SizedBox(height: MediaQuery.of(context).padding.bottom + 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getFeedbackMessage() {
    if (widget.isCorrect) {
      final messages = [
        'Excellent! 🎉',
        'Great job! ⭐',
        'Perfect! 🌟',
        'Well done! 👏',
        'Amazing! 🚀',
        'Fantastic! 🎊',
        'Outstanding! 🏆',
        'Brilliant! ✨',
      ];
      return messages[DateTime.now().millisecond % messages.length];
    } else {
      final messages = [
        'Not quite right... 😔',
        'Try again! 💪',
        'Don\'t give up! 🌱',
        'You can do it! 💫',
        'Keep trying! 🔄',
        'Almost there! 🎯',
        'One more time! 🚀',
        'You\'ve got this! 💪',
      ];
      return messages[DateTime.now().millisecond % messages.length];
    }
  }
}
