import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/misc/chat_bubble.dart';

/// Controller for AnimatedMascot to allow external control of animations
class AnimatedMascotController {
  _AnimatedMascotState? _state;

  void _attach(_AnimatedMascotState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  /// Triggers the mascot animation
  void triggerAnimation() {
    _state?._triggerAnimation();
  }

  /// Resets the animation state
  void reset() {
    _state?._resetAnimation();
  }

  /// Disposes the controller
  void dispose() {
    _detach();
  }
}

/// A widget that displays an animated mascot using Rive animations
class AnimatedMascot extends StatefulWidget {
  const AnimatedMascot({
    super.key,
    this.mascotSize = 100,
    this.bubbleText,
    this.bubbleWidth = 200,
    this.bubbleColor = AppColors.accent,
    this.onTap,
    this.animationType = MascotAnimationType.talking,
    this.autoPlay = true,
    this.showBubble = true,
    this.controller,
  });

  final double mascotSize;
  final String? bubbleText;
  final double bubbleWidth;
  final Color bubbleColor;
  final VoidCallback? onTap;
  final MascotAnimationType animationType;
  final bool autoPlay;
  final bool showBubble;
  final AnimatedMascotController? controller;

  @override
  State<AnimatedMascot> createState() => _AnimatedMascotState();
}

class _AnimatedMascotState extends State<AnimatedMascot> {
  Artboard? _artboard;
  StateMachineController? _stateMachineController;
  SimpleAnimation? _simpleAnimation;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    widget.controller?._attach(this);
    _loadRiveAnimation();
  }

  Future<void> _loadRiveAnimation() async {
    try {
      final data = await _getRiveData();
      if (data != null) {
        final file = RiveFile.import(ByteData.sublistView(data));
        final artboard = file.mainArtboard;

        setState(() {
          _artboard = artboard;
          _isLoaded = true;
        });

        // Try to get the state machine controller first
        _stateMachineController = StateMachineController.fromArtboard(
          artboard,
          'State Machine 1', // This might need to be adjusted based on your Rive file
        );

        if (_stateMachineController != null) {
          artboard.addController(_stateMachineController!);
          // Ensure the animation doesn't auto-start
          if (!widget.autoPlay) {
            // Try to stop the animation if it's auto-playing
            try {
              final inputs = _stateMachineController!.findInput('Trigger');
              if (inputs != null) {
                inputs.value = false;
              }
            } catch (e) {
              debugPrint('Error stopping auto-animation: $e');
            }
          }
        } else {
          // Fallback to simple animation if state machine is not available
          _simpleAnimation = SimpleAnimation(
            'Animation 1',
          ); // This might need adjustment
          artboard.addController(_simpleAnimation!);
          // Ensure simple animation doesn't auto-start
          if (!widget.autoPlay) {
            _simpleAnimation!.isActive = false;
          }
        }

        if (widget.autoPlay) {
          _triggerAnimation();
        }
      }
    } catch (e) {
      debugPrint('Error loading Rive animation: $e');
    }
  }

  Future<Uint8List?> _getRiveData() async {
    try {
      String assetPath;
      switch (widget.animationType) {
        case MascotAnimationType.talking:
          assetPath = AnimationAssets.talkingBear;
          break;
        case MascotAnimationType.happy:
          assetPath = AnimationAssets.happyBear;
          break;
        case MascotAnimationType.sad:
          assetPath = AnimationAssets.sadBear;
          break;
      }

      final data = await DefaultAssetBundle.of(context).load(assetPath);
      return data.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error loading Rive data: $e');
      return null;
    }
  }

  void _triggerAnimation() {
    if (_stateMachineController != null) {
      try {
        // Try to find and trigger the animation input
        final inputs = _stateMachineController!.findInput('Trigger');
        if (inputs != null) {
          inputs.value = true;
        }
      } catch (e) {
        debugPrint('Error triggering state machine animation: $e');
      }
    } else if (_simpleAnimation != null) {
      try {
        _simpleAnimation!.isActive = true;
      } catch (e) {
        debugPrint('Error triggering simple animation: $e');
      }
    }
  }

  void _resetAnimation() {
    if (_stateMachineController != null) {
      try {
        final inputs = _stateMachineController!.findInput('Trigger');
        if (inputs != null) {
          inputs.value = false;
        }
      } catch (e) {
        debugPrint('Error resetting state machine animation: $e');
      }
    } else if (_simpleAnimation != null) {
      try {
        _simpleAnimation!.isActive = false;
      } catch (e) {
        debugPrint('Error resetting simple animation: $e');
      }
    }
  }

  @override
  void dispose() {
    widget.controller?._detach();
    _stateMachineController?.dispose();
    _simpleAnimation?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _triggerAnimation();
        widget.onTap?.call();
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Rive Animation
          SizedBox(
            width: widget.mascotSize,
            height: widget.mascotSize,
            child:
                _isLoaded && _artboard != null
                    ? Rive(artboard: _artboard!)
                    : const Center(child: CircularProgressIndicator()),
          ),

          // Chat Bubble positioned near the mascot's mouth area (only if showBubble is true and bubbleText is provided)
          if (widget.showBubble && widget.bubbleText != null)
            Positioned(
              left:
                  widget.mascotSize -
                  10, // Position near the right side of mascot
              top:
                  widget.mascotSize *
                  0.3, // Position near the mouth area (30% from top)
              child: ChatBubble(
                bubbleText: widget.bubbleText!,
                bubbleColor: widget.bubbleColor,
                width: widget.bubbleWidth,
              ),
            ),
        ],
      ),
    );
  }
}

enum MascotAnimationType { talking, happy, sad }
