import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback? onReady;

  const SplashScreen({super.key, this.onReady});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isReady = false;
  final String _loadingText = "loading...";

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Simulate loading time (replace with actual initialization)
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      _isReady = true;
    });

    if (widget.onReady != null) {
      widget.onReady!();
    } else {
      // Navigate to welcome screen by default if no custom onReady callback is provided
      Get.offAndToNamed(AppRoutes.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background
            Positioned.fill(
              child: SvgPicture.asset(
                SvgAssets.splashBackground,
                fit: BoxFit.cover,
                semanticsLabel: 'Splash background',
              ),
            ),

            // Loading text
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child:
                  _isReady
                      ? const SizedBox.shrink()
                      : Center(
                        child:
                            Text(
                                  _loadingText,
                                  style: const TextStyle(
                                    fontFamily: 'DynaPuff_SemiCondensed',
                                    fontSize: 24,
                                    color: AppColors.bluePrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                                .animate(
                                  onPlay: (controller) => controller.repeat(),
                                )
                                .fadeIn(
                                  duration: const Duration(milliseconds: 800),
                                )
                                .then()
                                .fadeOut(
                                  duration: const Duration(milliseconds: 800),
                                )
                                .then(),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
