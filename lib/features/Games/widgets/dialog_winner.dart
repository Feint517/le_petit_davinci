import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;
import 'package:gif/gif.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class CongratulationsDialog extends StatefulWidget {
  final VoidCallback onPressed;

  const CongratulationsDialog({super.key, required this.onPressed});

  @override
  State<CongratulationsDialog> createState() => _CongratulationsDialogOState();
}

class _CongratulationsDialogOState extends State<CongratulationsDialog>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _rotationAnimation = Tween<double>(begin: -0.1, end: 0.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.4, 0.8, curve: Curves.easeInOut),
      ),
    );

    _bounceAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1.0, curve: Curves.elasticOut),
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
        // Ensure opacity is within valid range
        final safeOpacity = _scaleAnimation.value.clamp(0.0, 1.0);

        return Transform.translate(
          offset: Offset(
            0,
            math.sin(_controller.value * math.pi * 2) * _bounceAnimation.value,
          ),
          child: Transform.rotate(
            angle:
                math.sin(_controller.value * math.pi * 4) *
                _rotationAnimation.value,
            child: Opacity(
              opacity: safeOpacity,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Dialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Gif(
                          image: AssetImage(GifAssets.congrats),
                          fps: 30,
                          width: 150,
                          height: 150,
                          //duration: const Duration(seconds: 3),
                          autostart: Autostart.loop,
                        ),
                        Gap(10),
                        Text(
                          'Félicitations!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: AppColors.secondary,
                            fontFamily: 'BricolageGrotesque',
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'vous avez gagné!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BricolageGrotesque',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Gap(20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onPressed();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 10,
                            ),
                          ),
                          child: Text(
                            'Super!',
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
            ),
          ),
        );
      },
    );
  }
}

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

class CongratulationsDialogEqual extends StatefulWidget {
  final VoidCallback onPressed;

  const CongratulationsDialogEqual({super.key, required this.onPressed});

  @override
  State<CongratulationsDialogEqual> createState() =>
      _CongratulationsDialogEqualState();
}

class _CongratulationsDialogEqualState extends State<CongratulationsDialogEqual>
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
