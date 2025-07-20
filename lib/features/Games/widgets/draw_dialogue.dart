import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';

class DrawDialogue extends StatefulWidget {
  final VoidCallback onPressed;

  const DrawDialogue({super.key, required this.onPressed});

  @override
  State<DrawDialogue> createState() => _DrawDialogueState();
}

class _DrawDialogueState extends State<DrawDialogue>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Color?> _gradientAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _pulseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(_pulseController);

    _gradientAnimation = ColorTween(
      begin: Colors.purple,
      end: Colors.blue,
    ).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_controller, _pulseController]),
      builder: (BuildContext context, Widget? child) {
        // Ensure opacity is within valid range
        final safeOpacity = _scaleAnimation.value.clamp(0.0, 1.0);

        return Opacity(
          opacity: safeOpacity,
          child: Transform.scale(
            scale: _scaleAnimation.value * _pulseAnimation.value,
            child: Dialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              child: Container(
                width: 300,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _gradientAnimation.value ?? Colors.purple,
                      Colors.deepPurple,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: (_gradientAnimation.value ?? Colors.purple)
                          .withValues(alpha: 0.4),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.handshake, size: 70, color: Colors.white),
                    Gap(10),
                    Text(
                      'Match nul!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white,
                        fontFamily: 'BricolageGrotesque',
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    Gap(15),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImageAssets.o, height: 30, width: 30),
                          Gap(10),
                          Text(
                            'vs',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'BricolageGrotesque',
                            ),
                          ),
                          Gap(10),
                          Image.asset(ImageAssets.x, height: 30, width: 30),
                        ],
                      ),
                    ),
                    Gap(10),
                    Text(
                      'Tous les deux sont forts!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'BricolageGrotesque',
                      ),
                    ),
                    Gap(20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        widget.onPressed();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.deepPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                      ),
                      child: Text(
                        'Rejouer!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'BricolageGrotesque',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
