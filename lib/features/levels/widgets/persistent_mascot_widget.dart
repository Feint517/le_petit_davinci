import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/misc/chat_bubble.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';
import 'package:le_petit_davinci/features/levels/controllers/unified_mascot_controller.dart';

/// A persistent mascot widget that shows at the bottom left of the screen
/// and displays mascot messages from activities that use MascotIntroductionMixin.
/// The chat bubble dynamically appears/disappears based on message content.
class PersistentMascotWidget extends StatefulWidget {
  const PersistentMascotWidget({super.key});

  @override
  State<PersistentMascotWidget> createState() => _PersistentMascotWidgetState();
}

class _PersistentMascotWidgetState extends State<PersistentMascotWidget> {
  Artboard? _artboard;
  StateMachineController? _stateMachineController;
  bool _isLoaded = false;
  bool _isInitializing = false; // Prevent multiple initialization attempts
  int _retryCount = 0; // Track retry attempts
  static const int _maxRetries = 100; // Maximum retry attempts

  // Animation state management (handled by unified controller)

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    try {
      // Initialize RiveFile before importing
      await RiveFile.initialize();

      if (!mounted) {
        debugPrint('Widget not mounted, skipping Rive file load');
        return;
      }

      final data = await DefaultAssetBundle.of(
        context,
      ).load(AnimationAssets.talkingBear);
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;

      // Artboard is non-nullable, so no need to check for null

      _stateMachineController = StateMachineController.fromArtboard(
        artboard,
        'State Machine 1',
      );

      if (_stateMachineController != null) {
        artboard.addController(_stateMachineController!);
        debugPrint('State machine controller created successfully');

        // Initialize animation controller with the current activity's unified controller
        _initializeAnimationController();
      } else {
        debugPrint(
          'Warning: Could not create state machine controller, animations will be disabled',
        );
      }

      if (mounted) {
        setState(() {
          _artboard = artboard;
          _isLoaded = true;
        });
        debugPrint('Rive file loaded successfully');
      }
    } catch (e) {
      debugPrint('Error loading Rive file: $e');
      // Fallback: set loaded to true even if Rive fails, so the widget still shows
      if (mounted) {
        setState(() {
          _isLoaded = true;
        });
      }
    }
  }

  /// Initialize the animation controller with the current activity's unified controller
  void _initializeAnimationController() {
    if (_isInitializing) {
      debugPrint('Animation controller initialization already in progress');
      return;
    }

    _isInitializing = true;
    _tryInitializeAnimationController();
  }

  /// Try to initialize the animation controller, retry if needed
  void _tryInitializeAnimationController() {
    try {
      // Check if LevelController is available
      if (!Get.isRegistered<LevelController>()) {
        debugPrint('LevelController not registered yet, will retry...');
        _scheduleRetry();
        return;
      }

      final levelController = Get.find<LevelController>();
      final currentActivity = levelController.currentActivity;

      if (currentActivity is MascotIntroductionMixin) {
        final mascotMixin = currentActivity as MascotIntroductionMixin;
        if (mascotMixin.isInitialized.value &&
            mascotMixin.mascotController != null) {
          mascotMixin.mascotController!.initializeAnimation(
            _stateMachineController,
          );
          debugPrint('Animation controller initialized successfully');
          _isInitializing = false; // Success, stop retrying
        } else {
          debugPrint('Mascot not initialized yet, will retry...');
          _scheduleRetry();
        }
      } else {
        debugPrint(
          'Current activity does not implement MascotIntroductionMixin',
        );
        _isInitializing = false; // No need to retry for this case
      }
    } catch (e) {
      debugPrint('Error initializing animation controller: $e');
      _scheduleRetry();
    }
  }

  /// Schedule a retry of animation controller initialization
  void _scheduleRetry() {
    if (!mounted || _retryCount >= _maxRetries) {
      _isInitializing = false;
      if (_retryCount >= _maxRetries) {
        debugPrint(
          'Max retry attempts reached for animation controller initialization',
        );
      }
      return;
    }

    _retryCount++;
    debugPrint(
      'Retrying animation controller initialization (attempt $_retryCount/$_maxRetries)',
    );

    // Use a shorter delay and keep retrying
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _tryInitializeAnimationController();
      } else {
        _isInitializing = false;
      }
    });
  }

  /// Update animation state based on unified controller state
  void _updateAnimationFromState(MascotState state) {
    // Animation is now handled by the unified controller's animation controller
    // This method is kept for compatibility but the actual animation control
    // is handled directly by the UnifiedMascotController
  }

  // Animation control is now handled by the UnifiedMascotController

  /// Build a fallback mascot when Rive animation fails to load
  Widget _buildFallbackMascot() {
    return Container(
      width: 180,
      height: 180,
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.1),
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.accent.withValues(alpha: 0.3),
          width: 2,
        ),
      ),
      child: const Center(
        child: Icon(Icons.pets, size: 80, color: AppColors.accent),
      ),
    );
  }

  /// Get bubble color based on mascot state
  Color _getBubbleColorFromState(MascotState state) {
    switch (state) {
      case MascotState.idle:
      case MascotState.introducing:
        return AppColors.accent;
      case MascotState.celebrating:
        return Colors.green;
      case MascotState.encouraging:
        return Colors.orange;
    }
  }

  @override
  void dispose() {
    _stateMachineController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Find the current activity and check if it has a mascot
      // Use try-catch to handle cases where LevelController is not ready yet
      try {
        // Check if LevelController is available
        if (!Get.isRegistered<LevelController>()) {
          if (_retryCount < _maxRetries) {
            debugPrint(
              'LevelController not registered in build, will retry...',
            );
            // Trigger a rebuild after a short delay
            Future.delayed(const Duration(milliseconds: 50), () {
              if (mounted) {
                setState(() {}); // Trigger rebuild
              }
            });
          }
          return const SizedBox.shrink();
        }

        final levelController = Get.find<LevelController>();
        final currentActivity = levelController.currentActivity;

        if (currentActivity is MascotIntroductionMixin) {
          final mascotMixin = currentActivity as MascotIntroductionMixin;

          // Additional safety check: ensure the activity is properly initialized
          if (mascotMixin.isInitialized.value &&
              mascotMixin.mascotController != null &&
              !mascotMixin.mascotController!.isInitialized.value) {
            // Mascot controller exists but not fully initialized yet
            if (_retryCount < _maxRetries) {
              debugPrint(
                'Mascot controller not fully initialized, will retry...',
              );
              // Trigger a rebuild after a short delay
              Future.delayed(const Duration(milliseconds: 50), () {
                if (mounted) {
                  setState(() {}); // Trigger rebuild
                }
              });
            }
            return const SizedBox.shrink();
          }

          // If mascot is not initialized at all, trigger a rebuild
          if (!mascotMixin.isInitialized.value) {
            if (_retryCount < _maxRetries) {
              debugPrint('Mascot not initialized, will retry...');
              // Trigger a rebuild after a short delay
              Future.delayed(const Duration(milliseconds: 50), () {
                if (mounted) {
                  setState(() {}); // Trigger rebuild
                }
              });
            }
            return const SizedBox.shrink();
          }

          if (mascotMixin.isInitialized.value &&
              mascotMixin.mascotController != null) {
            return Positioned(
              left: -10,
              bottom: 0,
              child: Obx(() {
                try {
                  // Get current state from unified controller
                  final unifiedController = mascotMixin.mascotController!;
                  final currentMessage = unifiedController.currentMessage.value;
                  final currentState = unifiedController.currentState.value;
                  final showBubble = unifiedController.isShowingMessage.value;

                  // Control animation state based on unified controller state
                  _updateAnimationFromState(currentState);

                  return GestureDetector(
                    onTap: () {
                      unifiedController.triggerAnimation();
                      if (showBubble) {
                        unifiedController.nextMessage();
                      }
                    },
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Rive Animation (mascot) with fallback
                        SizedBox(
                          width: 180,
                          height: 180,
                          child:
                              _isLoaded && _artboard != null
                                  ? Rive(artboard: _artboard!)
                                  : _isLoaded && _artboard == null
                                  ? _buildFallbackMascot()
                                  : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                        ),

                        // Chat Bubble - only show when there's a message
                        if (showBubble)
                          Positioned(
                            left: 100, // Position near the right side of mascot
                            top: 0,
                            child: ChatBubble(
                              bubbleText: currentMessage,
                              bubbleColor: _getBubbleColorFromState(
                                currentState,
                              ),
                              width: 200,
                              enableTypingAnimation: true,
                              characterDelay: const Duration(milliseconds: 50),
                            ),
                          ),
                      ],
                    ),
                  );
                } catch (e) {
                  debugPrint('Error accessing mascot controller: $e');
                  // Return a fallback widget when there's an error
                  return const SizedBox.shrink();
                }
              }),
            );
          }
        }
      } catch (e) {
        debugPrint(
          'Error accessing LevelController in PersistentMascotWidget: $e',
        );
        // Return empty widget if controller is not ready
        return const SizedBox.shrink();
      }

      // No mascot to show
      return const SizedBox.shrink();
    });
  }
}
