import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/misc/chat_bubble.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';

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

  @override
  void initState() {
    super.initState();
    _loadRiveFile();
  }

  Future<void> _loadRiveFile() async {
    try {
      // Initialize RiveFile before importing
      await RiveFile.initialize();

      final data = await DefaultAssetBundle.of(
        context,
      ).load(AnimationAssets.talkingBear);
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;

      _stateMachineController = StateMachineController.fromArtboard(
        artboard,
        'State Machine 1',
      );
      if (_stateMachineController != null) {
        artboard.addController(_stateMachineController!);
      }

      setState(() {
        _artboard = artboard;
        _isLoaded = true;
      });
    } catch (e) {
      debugPrint('Error loading Rive file: $e');
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

  void _setAnimationState(bool isTalking) {
    if (_stateMachineController != null) {
      try {
        // Control the state machine directly - pause when not talking, resume when talking
        if (!isTalking) {
          _stateMachineController!.isActive = false;
        } else {
          _stateMachineController!.isActive = true;
        }
      } catch (e) {
        debugPrint('Error setting animation state: $e');
      }
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
      final levelController = Get.find<LevelController>();
      final currentActivity = levelController.currentActivity;

      if (currentActivity is MascotIntroductionMixin) {
        final mascotMixin = currentActivity as MascotIntroductionMixin;

        if (mascotMixin.isInitialized && mascotMixin.mascotController != null) {
          return Positioned(
            left: -10,
            bottom: 0,
            child: Obx(() {
              // Determine if we should show the chat bubble
              final showBubble =
                  !mascotMixin.isIntroCompleted.value &&
                  mascotMixin.mascotController!.currentMessage.isNotEmpty;

              // Control animation state based on whether there's a message
              _setAnimationState(showBubble);

              return GestureDetector(
                onTap: () {
                  _triggerAnimation();
                  if (showBubble) {
                    mascotMixin.mascotController!.nextMessage();
                  }
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Rive Animation (mascot)
                    SizedBox(
                      width: 180,
                      height: 180,
                      child:
                          _isLoaded && _artboard != null
                              ? Rive(artboard: _artboard!)
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
                          bubbleText:
                              mascotMixin.mascotController!.currentMessage,
                          bubbleColor: AppColors.accent,
                          width: 200,
                          enableTypingAnimation: true,
                          characterDelay: const Duration(milliseconds: 50),
                        ),
                      ),
                  ],
                ),
              );
            }),
          );
        }
      }

      // No mascot to show
      return const SizedBox.shrink();
    });
  }
}
