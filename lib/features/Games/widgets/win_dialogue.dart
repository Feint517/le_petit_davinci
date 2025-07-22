import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:math' as math;
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:lottie/lottie.dart';

class WinDialogue extends StatefulWidget {
  const WinDialogue({
    super.key,
    required this.onPressed,
    this.backgroundColor = AppColors.accent,
  });

  final Color backgroundColor;
  final VoidCallback onPressed;

  @override
  State<WinDialogue> createState() => _WinDialogueState();
}

class _WinDialogueState extends State<WinDialogue>
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
                      color: widget.backgroundColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: CustomShadowStyle.customCircleShadows(
                        color: widget.backgroundColor,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          LottieAssets.confetti,
                          width: 150,
                          height: 150,
                        ),
                        Gap(AppSizes.spaceBtwItems),
                        Text(
                          'Félicitations!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: AppColors.secondary,
                          ),
                        ),
                        Text(
                          'vous avez gagné!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            color: AppColors.textPrimary,
                          ),
                        ),

                        const Gap(AppSizes.spaceBtwItems),

                        CustomButton(
                          variant: ButtonVariant.secondary,
                          label: 'Super!',
                          width: 100,
                          onPressed: () {
                            Navigator.of(context).pop();
                            widget.onPressed();
                          },
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
