import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/misc/chat_bubble.dart';

class RiveTalkingMascotController extends GetxController {
  final List<String> messages;
  final Function()? onCompleted;

  final RxInt currentIndex = 0.obs;
  final RxBool isCompleted = false.obs;
  final RxBool isTalking = false.obs;

  RiveTalkingMascotController({required this.messages, this.onCompleted});

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
    isTalking.value = false;
  }

  void setTalking(bool talking) {
    isTalking.value = talking;
  }
}

class RiveTalkingMascot extends StatefulWidget {
  const RiveTalkingMascot({
    super.key,
    this.mascotSize = 300,
    required this.bubbleText,
    this.bubbleWidth = 200,
    this.bubbleColor = AppColors.accent,
    this.onTap,
    this.animationType = MascotAnimationType.talking,
  });

  final double mascotSize;
  final String bubbleText;
  final double bubbleWidth;
  final Color bubbleColor;
  final VoidCallback? onTap;
  final MascotAnimationType animationType;

  @override
  State<RiveTalkingMascot> createState() => _RiveTalkingMascotState();
}

class _RiveTalkingMascotState extends State<RiveTalkingMascot> {
  StateMachineController? _stateMachineController;
  Artboard? _artboard;

  @override
  void initState() {
    super.initState();
    _loadRiveAnimation();
  }

  Future<void> _loadRiveAnimation() async {
    final data = await _getRiveData();
    if (data != null) {
      final file = RiveFile.import(ByteData.sublistView(data));
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
    }
  }

  Future<Uint8List?> _getRiveData() async {
    try {
      // Load the appropriate Rive file based on animation type
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

      // Load the asset
      final data = await DefaultAssetBundle.of(context).load(assetPath);
      return data.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error loading Rive animation: $e');
      return null;
    }
  }

  void _triggerAnimation() {
    if (_stateMachineController != null) {
      // Trigger the appropriate animation based on the state
      // This might need to be adjusted based on your Rive file's state machine
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
                20, // Position near the right side of mascot
            top:
                widget.mascotSize *
                0.3, // Position near the mouth area (30% from top)
            child: ChatBubble(
              bubbleText: widget.bubbleText,
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
