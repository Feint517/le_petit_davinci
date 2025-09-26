import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/misc/chat_bubble.dart';

class TalkingMascotController extends GetxController {
  final List<String> messages;
  final Function()? onCompleted;

  final RxInt currentIndex = 0.obs;
  final RxBool isCompleted = false.obs;

  TalkingMascotController({required this.messages, this.onCompleted});

  String get currentMessage => messages[currentIndex.value];

  void nextMessage() {
    if (currentIndex.value < messages.length - 1) {
      currentIndex.value++;
    } else if (!isCompleted.value) {
      isCompleted.value = true;
      onCompleted?.call();
    }
  }

  void reset() {
    currentIndex.value = 0;
    isCompleted.value = false;
  }
}

class TalkingMascot extends StatefulWidget {
  const TalkingMascot({
    super.key,
    this.mascotSize = 300,
    required this.bubbleText,
    this.bubbleWidth = 200,
    this.bubbleColor = AppColors.accent,
    this.onTap,
    this.enableTypingAnimation = true,
    this.characterDelay = const Duration(milliseconds: 50),
  });

  final double mascotSize;
  final String bubbleText;
  final double bubbleWidth;
  final Color bubbleColor;
  final VoidCallback? onTap;
  final bool enableTypingAnimation;
  final Duration characterDelay;

  @override
  State<TalkingMascot> createState() => _TalkingMascotState();
}

class _TalkingMascotState extends State<TalkingMascot> {
  Artboard? _artboard;
  StateMachineController? _stateMachineController;

  @override
  void initState() {
    super.initState();
    _loadRiveAnimation();
  }

  Future<void> _loadRiveAnimation() async {
    try {
      final data = await DefaultAssetBundle.of(
        context,
      ).load(AnimationAssets.talkingBear);
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;

      setState(() {
        _artboard = artboard;
      });

      // Try to get the state machine controller
      _stateMachineController = StateMachineController.fromArtboard(
        artboard,
        'State Machine 1', // This might need to be adjusted based on your Rive file
      );

      if (_stateMachineController != null) {
        artboard.addController(_stateMachineController!);
      }
    } catch (e) {
      debugPrint('Error loading Rive animation: $e');
    }
  }

  void _triggerAnimation() {
    if (_stateMachineController != null) {
      // Trigger the talking animation
      // Note: The exact input name and value may need to be adjusted based on your Rive file
      try {
        // Note: The exact input name and value may need to be adjusted based on your Rive file
        // This is a placeholder - you'll need to check your Rive file's state machine inputs
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
    _stateMachineController?.dispose();
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
                _artboard != null
                    ? Rive(artboard: _artboard!)
                    : const Center(child: CircularProgressIndicator()),
          ),

          // Chat Bubble positioned near the mascot's mouth area
          Positioned(
            left:
                widget.mascotSize -
                80, // Position near the right side of mascot
            top: 0,
            child: ChatBubble(
              bubbleText: widget.bubbleText,
              bubbleColor: widget.bubbleColor,
              width: widget.bubbleWidth,
              enableTypingAnimation: widget.enableTypingAnimation,
              characterDelay: widget.characterDelay,
            ),
          ),
        ],
      ),
    );
  }
}
