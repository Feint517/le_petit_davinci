import 'package:flutter/material.dart';

/// A widget that animates text character by character, creating a typing effect.
class AnimatedTextWidget extends StatefulWidget {
  /// The text to animate
  final String text;

  /// Duration between each character (default 50ms)
  final Duration characterDelay;

  /// Text style for the animated text
  final TextStyle? style;

  /// Text alignment
  final TextAlign textAlign;

  /// Maximum number of lines for the text
  final int? maxLines;

  /// Callback when animation completes
  final VoidCallback? onAnimationComplete;

  /// Whether to start animation automatically
  final bool autoStart;

  const AnimatedTextWidget({
    super.key,
    required this.text,
    this.characterDelay = const Duration(milliseconds: 50),
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.onAnimationComplete,
    this.autoStart = true,
  });

  @override
  State<AnimatedTextWidget> createState() => _AnimatedTextWidgetState();
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget>
    with TickerProviderStateMixin {
  late AnimationController _typingController;
  late Animation<int> _typingAnimation;

  int _currentLength = 0;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    _typingController = AnimationController(
      duration: Duration(
        milliseconds: widget.text.length * widget.characterDelay.inMilliseconds,
      ),
      vsync: this,
    );

    _typingAnimation = IntTween(
      begin: 0,
      end: widget.text.length,
    ).animate(CurvedAnimation(parent: _typingController, curve: Curves.linear));

    _typingController.addListener(() {
      setState(() {
        _currentLength = _typingAnimation.value;
      });
    });

    _typingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isAnimating = false;
        });
        widget.onAnimationComplete?.call();
      }
    });

    if (widget.autoStart) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    if (!_isAnimating) {
      setState(() {
        _isAnimating = true;
        _currentLength = 0;
      });
      _typingController.forward();
    }
  }

  void _resetAnimation() {
    _typingController.reset();
    setState(() {
      _currentLength = 0;
      _isAnimating = false;
    });
  }

  void _restartAnimation() {
    _resetAnimation();
    _startAnimation();
  }

  @override
  void dispose() {
    _typingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayText = widget.text.substring(0, _currentLength);

    return Text(
      displayText,
      style: widget.style,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
    );
  }

  /// Start the typing animation
  void startAnimation() {
    _startAnimation();
  }

  /// Reset the animation to the beginning
  void resetAnimation() {
    _resetAnimation();
  }

  /// Restart the animation from the beginning
  void restartAnimation() {
    _restartAnimation();
  }

  /// Check if the animation is currently running
  bool get isAnimating => _isAnimating;

  /// Check if the animation is completed
  bool get isCompleted => _currentLength == widget.text.length;
}
