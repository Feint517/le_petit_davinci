import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;

class GameOverDialog extends StatefulWidget {
  final VoidCallback onPlayAgain;
  final VoidCallback onMenu;

  const GameOverDialog({
    super.key,
    required this.onPlayAgain,
    required this.onMenu,
  });

  @override
  State<GameOverDialog> createState() => _GameOverDialogState();
}

class _GameOverDialogState extends State<GameOverDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shakeAnimation;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _shakeAnimation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.4, curve: Curves.elasticIn),
      ),
    );

    _colorAnimation = ColorTween(
      begin: Colors.redAccent,
      end: Colors.deepOrangeAccent,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.3, 0.7, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        final shake =
            _controller.value < 0.4
                ? math.sin(_controller.value * math.pi * 8) *
                    _shakeAnimation.value *
                    5
                : 0.0;

        return Transform.translate(
          offset: Offset(shake, 0),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Container(
                  width: 300,
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: (_colorAnimation.value ?? Colors.redAccent)
                            .withValues(alpha: 0.25),
                        spreadRadius: 3,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Game Over icon
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: (_colorAnimation.value ?? Colors.redAccent)
                              .withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.sentiment_dissatisfied_rounded,
                          size: 56,
                          color: _colorAnimation.value ?? Colors.redAccent,
                        ),
                      ),
                      Gap(16),

                      // Game Over text
                      Text(
                        'Partie Terminée',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.black87,
                          fontFamily: 'BricolageGrotesque',
                        ),
                      ),

                      Gap(12),

                      // Motivational text
                      Text(
                        'Pas de chance cette fois-ci!\nEssayez encore!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                          fontFamily: 'BricolageGrotesque',
                        ),
                      ),
                      Gap(12),
                      // Action buttons
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Play Again button
                          ElevatedButton.icon(
                            onPressed: widget.onPlayAgain,
                            icon: Icon(Icons.replay),
                            label: Text('Rejouer'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  _colorAnimation.value ?? Colors.redAccent,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: TextStyle(
                                fontFamily: 'BricolageGrotesque',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          // Menu button
                          ElevatedButton.icon(
                            onPressed: widget.onMenu,
                            icon: Icon(Icons.menu),
                            label: Text('Menu'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade800,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              textStyle: TextStyle(
                                fontFamily: 'BricolageGrotesque',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}