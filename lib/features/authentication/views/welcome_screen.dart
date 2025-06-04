import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/widgets/buttons.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class WelcomeScreen extends StatefulWidget {
  final VoidCallback? onContinue;

  const WelcomeScreen({super.key, this.onContinue});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            //* Background (same as splash screen)
            Positioned.fill(
              child: SvgPicture.asset(
                SvgAssets.splashBackground,
                fit: BoxFit.cover,
              ),
            ),

            //* Welcome content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),

                    // Continue button at bottom
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: PillButton(
                            label: 'Continue',
                            icon: const Icon(Icons.arrow_forward),
                            iconPosition: IconPosition.right,
                            size: ButtonSize.lg,
                            width: double.infinity,
                            onPressed: widget.onContinue ?? () => Get.offAndToNamed(AppRoutes.home),
                          )
                          .animate()
                          .fadeIn(
                            duration: const Duration(milliseconds: 800),
                            delay: const Duration(milliseconds: 1000),
                          )
                          .scale(
                            begin: const Offset(0.9, 0.9),
                            end: const Offset(1.0, 1.0),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                            delay: const Duration(milliseconds: 1000),
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
