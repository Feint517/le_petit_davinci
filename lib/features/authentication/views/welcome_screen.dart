import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
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

                    // Continue button at bottom with delightful animations
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: PrimaryAnimatedButton(
                        label: 'Continue',
                        icon: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        iconPosition: IconPosition.right,
                        width: double.infinity,
                        entranceDelay: const Duration(milliseconds: 800),
                        onPressed:
                            widget.onContinue ??
                            () => Get.offAndToNamed(AppRoutes.home),
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
